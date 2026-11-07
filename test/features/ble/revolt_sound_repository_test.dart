import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:revolt_ble_sdk/revolt_ble_sdk.dart';
import 'package:revolt_data/features/ble/data/revolt_sound_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('SoundSettings Tests', () {
    test('toJson and fromJson serialize and restore sound settings accurately', () {
      final settings = const SoundSettings(
        profile: RevoltSoundProfile.rage,
        volume: 85,
        isEnabled: true,
      );

      final json = settings.toJson();
      expect(json['soundId'], 'sx04');
      expect(json['soundName'], 'Rage');
      expect(json['volume'], 85);
      expect(json['soundStatus'], 1);

      final restored = SoundSettings.fromJson(json);
      expect(restored.profile, RevoltSoundProfile.rage);
      expect(restored.volume, 85);
      expect(restored.isEnabled, isTrue);
    });
  });

  group('RevoltSoundRepository Tests', () {
    test('setSoundProfile updates local profile and persists to SharedPreferences', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();

      final repo = RevoltSoundRepository(prefs: prefs);
      await repo.setSoundProfile(RevoltSoundProfile.rebel);

      expect(repo.currentProfile, RevoltSoundProfile.rebel);

      final saved = prefs.getString(RevoltSoundRepository.prefsKey);
      expect(saved, isNotNull);
      expect(jsonDecode(saved!)['soundId'], 'sx03');
    });

    test('setVolume clamps volume between 0 and 100 and persists', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();

      final repo = RevoltSoundRepository(prefs: prefs);
      await repo.setVolume(150);
      expect(repo.currentVolume, 100);

      await repo.setVolume(-20);
      expect(repo.currentVolume, 0);

      await repo.setVolume(65);
      expect(repo.currentVolume, 65);
    });

    test('syncToCloud sends valid JSON payload to official Revolt endpoint', () async {
      late String postedBody;
      late Map<String, String> headers;

      final client = MockClient((request) async {
        expect(request.url.toString(), RevoltSoundRepository.updateSoundEndpoint);
        postedBody = request.body;
        headers = request.headers;
        return http.Response(jsonEncode({'status': true, 'message': 'Sound updated'}), 200);
      });

      final repo = RevoltSoundRepository(httpClient: client);
      await repo.setSoundProfile(RevoltSoundProfile.roar);
      await repo.setVolume(80);

      final success = await repo.syncToCloud(
        bikeId: 'RV400-DELHI-007',
        authToken: 'auth-jwt-token-xyz',
      );

      expect(success, isTrue);
      expect(headers['Authorization'], 'Bearer auth-jwt-token-xyz');
      expect(headers['Content-Type'], 'application/json');

      final bodyJson = jsonDecode(postedBody);
      expect(bodyJson['bikeId'], 'RV400-DELHI-007');
      expect(bodyJson['soundId'], 'sx02');
      expect(bodyJson['soundName'], 'Roar');
      expect(bodyJson['volume'], 80);
      expect(bodyJson['soundStatus'], 1);
    });

    test('loadSavedSettings restores prior user sound settings', () async {
      SharedPreferences.setMockInitialValues({
        RevoltSoundRepository.prefsKey: jsonEncode({
          'soundId': 'sx04',
          'soundName': 'Rage',
          'volume': 90,
          'soundStatus': 0,
        }),
      });
      final prefs = await SharedPreferences.getInstance();

      final repo = RevoltSoundRepository(prefs: prefs);
      await repo.loadSavedSettings();

      expect(repo.currentProfile, RevoltSoundProfile.rage);
      expect(repo.currentVolume, 90);
      expect(repo.isEnabled, isFalse);
    });
  });
}
