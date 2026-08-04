# Revolt RV400 Hardware Validation Issue Log

This document serves as the active issue log for Bluetooth Low Energy (BLE) protocol integration, vehicle telemetry parsing, edge-case handle management, and state machine recovery across `revolt_ble_toolkit`, `revolt_ble_sdk`, and `revolt_data`.

> [!NOTE]
> Issues identified below include both empirical observations from test suites / BTSnoop HCI packet dumps and hardware edge cases reserved for verification during physical vehicle testing.

---

## Issue Summary Matrix

| Issue ID | Category | Title | Severity | Status |
| :--- | :--- | :--- | :---: | :---: |
| **BLE-001** | Protocol / SDK | Exponential Backoff on Continuous Out-of-Range Reconnect | Medium | Mitigated / Patch Ready |
| **BLE-002** | Telemetry / Data | High-Frequency Location Deltas during Micro-Moves (<0.1km) | Low | Resolved in Parser |
| **BLE-003** | Hardware / ECU | Unobserved GATT Attribute Handles 85 & 87 in ECU Table | Low | Investigating / Pending HW |
| **BLE-004** | State / App | Grace Period State Cleanup on App Unexpected Process Termination | Medium | Resolved via Persistence |
| **BLE-005** | Hardware / ECU | High Electromagnetic Interference (EMI) Packet Drop near Fast Chargers | Critical / Pending HW | Pending Real Hardware Validation |

---

## Detailed Issue Breakdown

### [BLE-001] Exponential Backoff on Continuous Out-of-Range Reconnect
* **Category**: Medium
* **Component**: `revolt_ble_sdk` (`revolt_ble_client.dart`)
* **Reproduction Steps**:
  1. Pair and authenticate app with RV400 BLE stack.
  2. Move phone out of Bluetooth range (> 15 meters) for > 10 minutes.
  3. Observe reconnect loop attempt frequency in log output.
* **Expected Behavior**: Connection retry loop should utilize exponential backoff (e.g. 2s, 4s, 8s, 16s up to 60s max) to prevent battery drain on Android/iOS host.
* **Actual Behavior**: Previous implementation attempted reconnect at fixed 3-second intervals endlessly.
* **Proposed Fix / Resolution**: Implemented exponential backoff with jitter algorithm in `revolt_ble_sdk` reconnection queue manager.

---

### [BLE-002] High-Frequency Location Deltas during Micro-Moves (< 0.1 km)
* **Category**: Low
* **Component**: `revolt_data` (`ble_trip_provider.dart`)
* **Reproduction Steps**:
  1. Move motorcycle 20–30 meters inside a parking garage (Odometer unchanged).
  2. Turn key switch to OFF.
* **Expected Behavior**: Trip logger ignores movements under 0.1 km threshold and discards transient parking maneuvers.
* **Actual Behavior**: Noise in GPS coordinates initially logged a 0.03 km trip entry in local database.
* **Proposed Fix / Resolution**: Enforced `0.1 km` minimum distance requirement in `BleTripProvider` auto-finalize check.

---

### [BLE-003] Unobserved GATT Attribute Handles 85 & 87 in ECU Table
* **Category**: Low
* **Component**: `revolt_ble_toolkit` (`analyzers/gatt/analyzer.py`)
* **Reproduction Steps**:
  1. Perform full GATT service & characteristic handle enumeration on RV400 ECU.
  2. Inspect Handles `85` (Write) and `87` (Write+Notify).
* **Expected Behavior**: Understand purpose of reserved handles or map to extended vehicle parameters (e.g. BMS cell diagnostics).
* **Actual Behavior**: Handles exist in ECU GATT structure but stream zero traffic during standard operations.
* **Proposed Fix / Resolution**: Cataloged as `UNOBSERVED` in `PROTOCOL_DATABASE.md`; scheduled for empirical probing during physical hardware audit.

---

### [BLE-004] Grace Period State Cleanup on App Unexpected Process Termination
* **Category**: Medium
* **Component**: `revolt_data` (`ble_debug_provider.dart`)
* **Reproduction Steps**:
  1. Initiate active ride session.
  2. Disconnect BLE connection (triggering 60-second grace timer).
  3. Force kill app process before grace timer expires.
  4. Re-open app.
* **Expected Behavior**: App recovers trip state from SQLite database, detects elapsed time, and either resumes tracking or finalizes trip cleanly.
* **Actual Behavior**: Transient state in memory was lost without persistence.
* **Proposed Fix / Resolution**: Added continuous state snapshot save to local SQLite storage on state transition.

---

### [BLE-005] High EMI Packet Drop near High-Power Fast Chargers
* **Category**: Critical
* **Component**: Physical Hardware / ECU BLE Radio
* **Reproduction Steps**:
  1. Plug RV400 into high-power fast charger station.
  2. Place phone within 0.5 meters of charger transformer block.
  3. Monitor BLE notification packet loss.
* **Expected Behavior**: Packet reception rate remains ≥ 95% during charging cycles.
* **Actual Behavior**: **Pending Real Hardware Validation**. (Theoretical risk based on high-frequency noise from fast-charger AC/DC converters).
* **Proposed Fix / Resolution**: Validate during physical charging session test; adjust BLE link supervisory timeout (MTU/Timeout) if packet drops occur.

---
