# ⚡ My Revolt (RV400 Companion)

[![Flutter CI](https://github.com/MannDangrechiya/revolt_data/workflows/Flutter%20CI/badge.svg?branch=main)](https://github.com/MannDangrechiya/revolt_data/actions)
[![Release](https://img.shields.io/badge/Release-v2.3.1-blue.svg)](https://github.com/MannDangrechiya/revolt_data/releases/tag/v2.3.1)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-green.svg)](https://flutter.dev)
[![Architecture](https://img.shields.io/badge/Architecture-Riverpod%20%2B%20Drift%20SQLite-orange.svg)](https://drift.simonbinder.eu/)

**My Revolt** is a companion and intelligent telemetry logbook application for the **Revolt RV400** electric motorcycle. Designed with a local-first, offline-ready architecture, it connects seamlessly via Bluetooth Low Energy (BLE) to deliver live telemetry, ride tracking, smart battery diagnostics, and automated commute scheduling.

---

## 🌟 Key Features

### 🏍️ Real-Time Telemetry & Cockpit HUD
- **Live Diagnostics**: Battery percentage, State of Health (SOH), motor/battery temperatures, instantaneous speed, and active ride mode (Eco / Normal / Sport).
- **Speedometer with GPS Fallback**: The cockpit HUD displays live instrument cluster speed and smoothly falls back to phone GPS velocity if the BLE link drops mid-ride.
- **Fault Code Decoding**: Direct decoding of Revolt controller alerts and battery management system (BMS) status.

### 🛡️ Resilient Disconnect & Reconnect Lifecycle
- **Zero Ride Loss**: If the Bluetooth connection is severed (pocket occlusion, walking away, or signal drop), telemetry polling pauses gracefully, GPS handoff activates, and the offline queue preserves trip segments.
- **Silent Auto-Recovery**: Re-authenticates and re-pairs automatically as soon as the motorcycle is back in range.
- **Realistic Energy Estimation**: Uses an empirical baseline of 30 Wh/km (~9% SOC drop per 10 km on the 3.24 kWh pack) during GPS-only intervals.

### ⏰ Automated Morning Commute Intelligence
- **Scheduled Weekday Reminders**: Automatically reminds you every Monday through Friday at 8:00 AM local time ("Morning Commute Ready"). Survives device reboots with persistent broadcast receivers.
- **1-Tap Tracking**: Tapping the notification opens the Cockpit and begins GPS commute logging immediately.
- **Morning Window Detection (07:30–09:30 AM)**: Displays a lightweight 1-tap start banner if opened during morning commute hours.

### 💾 Local-First SQLite Database & Cloud Sync
- **Drift / SQLite Engine**: All rides, charge cycles, battery health history, and expenses stay stored safely on your device.
- **Automated Sync Engine**: Background offline queue with confidence scoring and duplicate collision detection for seamless cloud backup.

### 🔊 Sound Studio & Bike Security
- **Sound Studio**: Custom exhaust acoustic profiles and sound simulation for the RV400 speaker.
- **Anti-Theft Guard**: Movement detection triggers and geofence tracking alerts.

---

## 📲 Download & Installation

The latest pre-built production APK is available directly in the repository releases:

| Asset | Details |
| :--- | :--- |
| **Latest Release** | **v2.3.1** |
| **APK File** | `My_Revolt_v2.3.1.apk` / `app-release.apk` |
| **Minimum Android** | Android 8.0 (API 26+) |
| **Target Architecture** | Universal (`arm64-v8a`, `armeabi-v7a`, `x86_64`) |

### Installing the APK on Android:
1. Download `My_Revolt_v2.3.1.apk` to your phone.
2. Tap the file in your Downloads folder.
3. If prompted, enable **"Allow from this source"** in your phone settings to proceed with the sideload.
4. Open **My Revolt** and grant the required permissions:
   - **Nearby Devices / Bluetooth**: To scan, pair, and read RV400 telemetry.
   - **Location ("Allow all the time")**: Required for BLE discovery and background GPS ride tracking.
   - **Notifications**: For scheduled morning commute reminders.

---

## 🛠️ Tech Stack & Architecture

- **UI Framework**: Flutter (Material 3 with custom high-contrast dark automotive aesthetic)
- **State Management**: Riverpod (`hooks_riverpod`, `riverpod_generator`)
- **Local Storage**: Drift (Type-safe SQLite persistence)
- **Hardware Integration**: Custom `revolt_ble_sdk` with `flutter_blue_plus`
- **Location & Tracking**: `geolocator` with background foreground service & `flutter_map`
- **Notifications**: `flutter_local_notifications` with `timezone` support
- **Code Generation**: Freezed, Drift Dev, JSON Serializable

---

## 💻 Developer Setup & Contributing

### Prerequisites
- Flutter SDK `^3.8.0` / Dart SDK `^3.8.0`
- Android Studio / VS Code with Flutter extension
- Java 17+ (configured for Android Gradle Plugin)

### 1. Clone the repository
```bash
git clone git@github.com:MannDangrechiya/revolt_data.git
cd revolt_data
```

### 2. Install dependencies
```bash
flutter pub get
```

### 3. Generate code (Drift & Freezed)
```bash
dart run build_runner build --delete-conflicting-outputs
```

### 4. Run tests
```bash
flutter test
```
*Current test suite: **148 / 148 passing tests**.*

### 5. Static code analysis
```bash
flutter analyze
```

### 6. Build release APK
```bash
flutter build apk --release
```
The output APK will be placed in `build/app/outputs/flutter-apk/app-release.apk`.

---

## 🔐 Permissions Overview

| Permission | Reason |
| :--- | :--- |
| `BLUETOOTH_SCAN` & `BLUETOOTH_CONNECT` | Connect and exchange telemetry frames with RV400 motorcycle. |
| `ACCESS_FINE_LOCATION` & `ACCESS_BACKGROUND_LOCATION` | GPS route mapping and BLE scan authorization on Android 12+. |
| `FOREGROUND_SERVICE_LOCATION` | Continuous GPS route logging when the screen is off or in pocket. |
| `POST_NOTIFICATIONS` | Telemetry warnings, charge completion alerts, and morning commute reminders. |
| `RECEIVE_BOOT_COMPLETED` | Reschedules the 8:00 AM weekday commute reminder across phone reboots. |

---

## 📄 License & Ownership

Developed for Revolt RV400 riders. All rights reserved.
