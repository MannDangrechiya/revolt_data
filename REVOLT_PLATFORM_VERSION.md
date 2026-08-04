# Revolt EV Platform Version Manifest

**Platform Version:** `1.0.0`  
**Release Status:** **Production Candidate**  
**Release Date:** August 4, 2026  
**Ecosystem Lead:** Revolt Open Source Engineering Team

---

## 1. Managed Repositories & Release Versions

| Repository Name | Package / App Name | Target Version | Status | Primary Technology |
| :--- | :--- | :---: | :---: | :--- |
| **`revolt_data`** | VoltLog Flutter Application | `1.0.0` | Production Candidate | Flutter 3.27.x, Riverpod, Drift |
| **`revolt_ble_sdk`** | Revolt BLE Client SDK | `1.0.0` | Production Candidate | Dart / Flutter, flutter_blue_plus |
| **`revolt_ble_toolkit`** | Revolt HCI Snoop Toolkit & GUI | `1.0.0` | Production Candidate | Python 3.12, PySide6, Bleak |

---

## 2. Compatibility Matrix

| Subsystem / Platform | Supported Version Range | Tested Environment | Verification Notes |
| :--- | :--- | :--- | :--- |
| **Flutter SDK** | `>= 3.27.0 < 4.0.0` | `3.27.x` | Clean `flutter analyze` & 53 unit/widget tests |
| **Dart SDK** | `>= 3.0.0 < 4.0.0` | `3.8.0` | Tested with strict static options |
| **Python** | `>= 3.12` | `Python 3.12.x` | 170 pytest suites, Ruff lint, MyPy strict |
| **Android OS** | `Android 11` to `Android 15` | API Level 34/35 | BLUETOOTH_SCAN, CONNECT permissions verified |
| **iOS** | `iOS 15.0` to `iOS 18.0` | iOS 17.x / 18.x | Bluetooth peripheral usage keys configured |
| **Target Vehicle** | Revolt RV400 / RV400 BRZ | ECU Firmware `v2.4.12-RV` | Pending Real Hardware Validation |

---

## 3. Release Verification Summary

- **Code Quality**: Zero static analysis warnings across Dart and Python codebase.
- **Test Coverage**: 100% test pass rate (53 Flutter tests, 170 Pytest tests).
- **Security Audit**: Confidential credentials, passkeys, and tokens stripped from loggers and release builds.
- **Hardware Sign-off**: Marked as **`Pending Real Hardware Validation`** until live vehicle verification.
