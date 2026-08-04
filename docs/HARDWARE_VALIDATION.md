# Revolt RV400 Real Hardware Validation Checklist

This document serves as the official hardware verification checklist for validating real-time Bluetooth Low Energy (BLE) telemetry, connection lifecycles, edge cases, trip auto-detection, and charging auto-detection on the physical **Revolt RV400** electric motorcycle before declaring the app production-ready.

---

## 1. Telemetry Fields Validation

The following table documents each telemetry field received via the RV400 BLE characteristic, its expected raw format, validation methodology, and verification status.

| Field Name | Expected Source (RV400 BLE packet) | Validation Method | Pass/Fail |
| :--- | :--- | :--- | :---: |
| `batteryPercentage` | ASCII string field `parts[1]` or Byte `data[0]` (0-100%) | Compare app UI against bike instrument cluster LCD battery % gauge | [ ] Pass / [ ] Fail |
| `range` | ASCII string field `parts[10]` or Byte `data[17]` (km) | Compare estimated remaining range display on app vs speedometer cluster | [ ] Pass / [ ] Fail |
| `speed` | ASCII string field `parts[6]` or Bytes `data[7..8]` / 10.0 (km/h) | Compare live speed graph with physical speedometer during test ride | [ ] Pass / [ ] Fail |
| `odometer` | ASCII string field `parts[8]` or Bytes `data[11..14]` / 10.0 (km) | Verify total distance matches physical bike odometer readout exactly | [ ] Pass / [ ] Fail |
| `batteryHealth` | ASCII string field `parts[13]` or Byte `data[16]` (0-100 SOH) | Verify State of Health (SOH) reporting against Revolt diagnostics tool | [ ] Pass / [ ] Fail |
| `batteryTemp` | ASCII string field `parts[4]` or Byte `data[5]` (°C) | Verify pack temperature increases under load and cools down post-ride | [ ] Pass / [ ] Fail |
| `motorTemp` | ASCII string field `parts[5]` or Byte `data[6]` (°C) | Verify motor temp fluctuates with throttle input and hill climb tests | [ ] Pass / [ ] Fail |
| `rideMode` | ASCII string field `parts[9]` ("Eco", "Normal", "Sport") | Toggle handlebar mode switch (1, 2, 3) and verify real-time state change | [ ] Pass / [ ] Fail |
| `ecoMode` | ASCII `parts[9] == 'Eco'` or Byte `data[15] == 1` | Switch bike to Mode 1 (Eco) and verify Eco active status and power cap | [ ] Pass / [ ] Fail |
| `sportMode` | ASCII `parts[9] == 'Sport'` or Byte `data[15] == 3` | Switch bike to Mode 3 (Sport) and verify Sport active status and peak power | [ ] Pass / [ ] Fail |
| `faultCodes` | ASCII string field `parts[12]` (Semicolon-separated strings) | Trigger test fault (e.g. side-stand down) and verify fault code parsing | [ ] Pass / [ ] Fail |
| `gpsCoords` | ASCII string field `parts[14]` ("Lat,Lng" format) | Verify GPS coordinates match physical bike location coordinates | [ ] Pass / [ ] Fail |
| `chargingStatus` | Calculated from current (>0A), voltage gain, & speed (0 km/h) | Plug in portable charger and verify app transitions to Charging State | [ ] Pass / [ ] Fail |

---

## 2. BLE Connection Lifecycle

Verify the end-to-end BLE connection pipeline on real hardware:

1. **Scan**: App discovers `RV400` advertising packet (`advName` / `platformName` matching filter `"RV400"`) within 10 seconds.
2. **Pair**: User initiates pairing; app exchanges token handshake with control characteristic.
3. **Authenticate**: Security token validation returns `true`; connection state transitions from `connecting` → `connected` → `authenticated`.
4. **Subscribe to Notifications**: App subscribes to GATT telemetry characteristic notifications (`00002a19-0000-1000-8000-00805f9b34fb`).
5. **Verify Heartbeat**: Telemetry packets stream continuously at 1 Hz (1 packet per second); `lastUpdated` timestamp refreshes.
6. **Disconnect**: Manual disconnect or bike key-off updates app state to `disconnected` cleanly without crashing.
7. **Reconnect**: Turning bike back on auto-reconnects BLE session within 5 seconds.
8. **Verify Resume**: Telemetry streaming resumes and live cards reflect current bike state.

---

## 3. Edge Cases Validation Checklist

- [ ] **Mid-Ride Disconnect**: Turn off phone Bluetooth mid-ride. App starts 60-second grace timer. Re-enabling Bluetooth resumes tracking without fragmenting trip into two separate logs.
- [ ] **Mid-Charge Disconnect**: Unplug charger or move phone out of range mid-charge. App starts 120-second grace timer. Reconnecting within grace period preserves session start battery %.
- [ ] **App Backgrounded During Ride**: Background app for 15 minutes during an active ride. Verify OS background service / state retention records full trip duration and distance correctly.
- [ ] **App Killed and Reopened Mid-Trip**: Force kill app during active ride. Reopen app — verify odometer state recovers and previous ride auto-finalizes or resumes.
- [ ] **Low Battery (<10%) Telemetry Accuracy**: Ride bike until battery drops below 10%. Verify low battery warnings, percentage accuracy, and range degradation match instrument panel.
- [ ] **High Temperature (>50°C) Warnings**: Test bike under heavy load on incline to elevate motor/battery temp. Verify high temperature warning banners trigger at >50°C.

---

## 4. Trip Detection Accuracy

- [ ] **Odometer Delta vs Auto-Logged Distance**: Take a measured 10.0 km test ride. Verify auto-logged trip distance matches `endOdometer - startOdometer` delta within ±0.1 km.
- [ ] **±2 Minute Duplicate Guard**: Attempt to log a duplicate ride manually or via BLE within 2 minutes of an existing ride with matching start/end odometers. Verify duplicate is rejected.
- [ ] **0.1 km Minimum Threshold**: Move bike 30 meters (0.03 km) and stop. Verify trip detector ignores micro-movements under 0.1 km threshold and does not log garbage entries.

---

## 5. Charge Detection Accuracy

- [ ] **Auto-Logged % Gained vs Charger Display**: Charge bike from 40% to 80%. Verify auto-logged charge log records +40% gain and ~1.30 kWh added (`3.24 kWh * 0.40`).
- [ ] **2% Minimum Threshold**: Plug charger for 30 seconds (gaining <1%). Verify session is discarded upon disconnect due to <2% threshold rule.
- [ ] **Trickle-Charge Finalization at 100%**: Charge bike to 100%. Verify 5-minute plateau timer detects constant 100% state and finalizes charge session cleanly.

---

## 6. Real Hardware Sign-off Table

| Date | Firmware Version | Phone Model | Android/iOS Version | Tester Signature | Status |
| :--- | :--- | :--- | :--- | :--- | :---: |
| 2026-08-04 | v2.4.12-RV | Pixel 8 Pro | Android 15 | Mann Dangrechiya | [ ] PENDING / [ ] APPROVED |
| | | | | | |
| | | | | | |

---
