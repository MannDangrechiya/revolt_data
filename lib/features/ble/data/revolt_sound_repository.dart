import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:revolt_ble_sdk/revolt_ble_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Sound settings state model.
class SoundSettings {
  final RevoltSoundProfile profile;
  final int volume;
  final bool isEnabled;

  const SoundSettings({
    required this.profile,
    required this.volume,
    required this.isEnabled,
  });

  Map<String, dynamic> toJson() => {
        'soundId': profile.code,
        'soundName': profile.label,
        'volume': volume,
        'soundStatus': isEnabled ? 1 : 0,
      };

  factory SoundSettings.fromJson(Map<String, dynamic> json) {
    final code = json['soundId']?.toString() ?? 'sx01';
    final profile = RevoltSoundProfile.fromCode(code) ?? RevoltSoundProfile.revolt;
    final volume = (json['volume'] is num)
        ? (json['volume'] as num).toInt()
        : int.tryParse(json['volume']?.toString() ?? '') ?? 50;
    final isEnabled = json['soundStatus'] == 1 || json['isEnabled'] == true;

    return SoundSettings(
      profile: profile,
      volume: volume.clamp(0, 100),
      isEnabled: isEnabled,
    );
  }
}

/// Repository for coordinating the Revolt RV400 exhaust Sound Box hardware (over BLE)
/// and persisting sound preferences to both local storage and Revolt Cloud services.
class RevoltSoundRepository {
  static const String updateSoundEndpoint =
      'https://apix.revoltmotors.com/userservices/v1/bike/updatesound';
  static const String prefsKey = 'revolt_sound_settings_cache';

  final RevoltSoundClient soundClient;
  final http.Client _httpClient;
  final SharedPreferences? _prefs;

  RevoltSoundProfile _currentProfile = RevoltSoundProfile.revolt;
  int _currentVolume = 50;
  bool _isEnabled = true;

  RevoltSoundRepository({
    RevoltSoundClient? soundClient,
    http.Client? httpClient,
    SharedPreferences? prefs,
  })  : soundClient = soundClient ?? RevoltSoundClient(),
        _httpClient = httpClient ?? http.Client(),
        _prefs = prefs;

  RevoltSoundProfile get currentProfile => _currentProfile;
  int get currentVolume => _currentVolume;
  bool get isEnabled => _isEnabled;

  /// Loads saved sound settings from SharedPreferences.
  Future<void> loadSavedSettings() async {
    final prefs = _prefs ?? await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(prefsKey);
    if (jsonStr != null && jsonStr.isNotEmpty) {
      try {
        final Map<String, dynamic> data = jsonDecode(jsonStr);
        final settings = SoundSettings.fromJson(data);
        _currentProfile = settings.profile;
        _currentVolume = settings.volume;
        _isEnabled = settings.isEnabled;
      } catch (e) {
        debugPrint('[RevoltSoundRepository] loadSavedSettings error: $e');
      }
    }
  }

  /// Sets the sound profile, sends BLE command to the Sound Box, and persists.
  Future<void> setSoundProfile(
    RevoltSoundProfile profile, {
    String? bikeId,
    String? authToken,
  }) async {
    _currentProfile = profile;
    try {
      await soundClient.setSound(profile);
    } catch (_) {
      // Best-effort if not currently connected to BLE sound box
    }
    await _persistSettings();

    if (bikeId != null) {
      await syncToCloud(bikeId: bikeId, authToken: authToken);
    }
  }

  /// Sets the speaker volume (0 - 100), sends BLE command, and persists.
  Future<void> setVolume(
    int volume, {
    String? bikeId,
    String? authToken,
  }) async {
    _currentVolume = volume.clamp(0, 100);
    try {
      await soundClient.setVolume(_currentVolume);
    } catch (_) {
      // Best-effort if not currently connected
    }
    await _persistSettings();

    if (bikeId != null) {
      await syncToCloud(bikeId: bikeId, authToken: authToken);
    }
  }

  /// Toggles sound power output, sends BLE command, and persists.
  Future<void> setSoundEnabled(
    bool enabled, {
    String? bikeId,
    String? authToken,
  }) async {
    _isEnabled = enabled;
    try {
      await soundClient.setPower(enabled);
    } catch (_) {
      // Best-effort if not currently connected
    }
    await _persistSettings();

    if (bikeId != null) {
      await syncToCloud(bikeId: bikeId, authToken: authToken);
    }
  }

  /// Syncs active sound configuration to the official Revolt Cloud API.
  Future<bool> syncToCloud({
    required String bikeId,
    String? authToken,
  }) async {
    try {
      final body = jsonEncode({
        'bikeId': bikeId,
        'soundId': _currentProfile.code,
        'soundName': _currentProfile.label,
        'volume': _currentVolume,
        'soundStatus': _isEnabled ? 1 : 0,
      });

      final headers = <String, String>{
        'Content-Type': 'application/json',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      };

      final response = await _httpClient
          .post(
            Uri.parse(updateSoundEndpoint),
            headers: headers,
            body: body,
          )
          .timeout(const Duration(seconds: 10));

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      debugPrint('[RevoltSoundRepository] syncToCloud failed: $e');
      return false;
    }
  }

  Future<void> _persistSettings() async {
    final prefs = _prefs ?? await SharedPreferences.getInstance();
    final settings = SoundSettings(
      profile: _currentProfile,
      volume: _currentVolume,
      isEnabled: _isEnabled,
    );
    await prefs.setString(prefsKey, jsonEncode(settings.toJson()));
  }
}
