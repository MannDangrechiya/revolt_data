# RV400 Hardware Validation Checklist

## Overview
This document outlines the step-by-step physical validation process for connecting the Revolt Platform application to a real Revolt RV400 motorcycle. Since automated tests rely on mock BLE environments, this checklist verifies real-world integration, timing, permission handling, and data accuracy.

## Prerequisites
- Physical Revolt RV400 motorcycle with ignition OFF initially.
- Android device running Android 12+ (or Android 11 with Location Services enabled).
- Valid Pairing Token for the motorcycle.
- Latest `app-debug.apk` built and installed on the test device.

## Validation Steps

### Step 1: BLE Advertising & Discovery
**Objective**: Verify the bike advertises correctly and the app can discover it.
1. Turn the motorcycle ignition **ON**.
2. Open the application and initiate a BLE Scan.
- **Expected Outcome [UNVERIFIED]**: The bike appears in the scan results (typically named `RV_44B7D02C758E` or similar).
- **Pass/Fail Criteria**: `[ ] Pass / [ ] Fail`
- **Diagnostic Log Check**: Verify `Scanning for devices matching...` and `Scan completed: found ...` appear in the logs.

### Step 2: Connection & GATT Service Discovery
**Objective**: Verify GATT connection and service discovery.
1. Tap the discovered RV400 device in the app to connect.
- **Expected Outcome [UNVERIFIED]**: The app successfully connects and discovers the ISSC Transparent UART service (`49535343-fe7d-4ae5-8fa9-9fafd205e455`) and characteristic (`49535343-1e4d-4bd9-ba61-23c647249616`).
- **Pass/Fail Criteria**: `[ ] Pass / [ ] Fail`
- **Diagnostic Log Check**: Verify `Connecting to...`, `Discovering services for...`, and `Notifications enabled on...` appear in logs.

### Step 3: Authentication Handshake
**Objective**: Verify the application-level security handshake.
1. Enter your legitimately provisioned token in the UI when prompted and tap to pair.
- **Expected Outcome [UNVERIFIED]**: The app sends `PAIR<token>#` to the UART characteristic and receives a response (codebase currently expects `ACCEPTED`, but this must be physically confirmed).
- **Pass/Fail Criteria**: `[ ] Pass / [ ] Fail`
- **Diagnostic Log Check**: Log should indicate `Authenticating with token...` followed by `Authentication result: true/false`. Token must NOT be printed in the logs.

### Step 4: Telemetry Streaming & Parsing
**Objective**: Verify raw packet ingestion and conversion.
1. Observe the live dashboard or debug screen in the app.
- **Expected Outcome [UNVERIFIED]**: 
  - Battery percentage matches the LCD cluster.
  - Speed responds in real-time when the rear wheel is spun (safely, on a center stand).
  - Odometer matches the instrument cluster.
  - Ride mode switches correctly (Eco / Normal / Sport) when toggled on the handlebars.
- **Pass/Fail Criteria**: `[ ] Pass / [ ] Fail`

### Step 5: Lifecycle & Reconnection
**Objective**: Verify robustness against disconnects.
1. Turn the motorcycle ignition **OFF**.
- **Expected Outcome**: App detects disconnection and transitions to a reconnecting/grace state.
2. Wait 30 seconds, then turn the motorcycle ignition **ON**.
- **Expected Outcome [UNVERIFIED]**: App automatically reconnects, re-authenticates (sends PAIR handshake automatically), and resumes telemetry.
- **Pass/Fail Criteria**: `[ ] Pass / [ ] Fail`

### Step 6: Trip Recording Persistence
**Objective**: Verify local database logic for rides using safe, supported test conditions.
1. Take a short test ride (or simulate distance safely on a stand > 0.1km).
2. Turn the motorcycle ignition **OFF** and let the grace period expire (or force-stop the trip).
- **Expected Outcome**: The trip is finalized and accurately recorded in the local SQLite database (matching start/end odometers).
- **Pass/Fail Criteria**: `[ ] Pass / [ ] Fail`

## Instructions for the Owner
Please install the generated APK on your Android device via `adb install <path-to-apk>`, stand near your RV400 motorcycle, and execute these steps. Provide the Pass/Fail results, confirm the exact authentication response received (e.g. `ACCEPTED` or something else), and any relevant diagnostic logs or observed crashes. Do not perform unsafe road tests while monitoring the app.
