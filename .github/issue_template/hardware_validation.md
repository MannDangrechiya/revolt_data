---
name: Hardware Validation Report
about: Submit physical test results or packet logs from a Revolt RV400 vehicle
title: '[HW-TEST] '
labels: 'hardware, BLE'
assignees: ''
---

**Vehicle Details:**
 - Bike Model: [Revolt RV400 / RV400 BRZ]
 - ECU / Firmware Version: [e.g. v2.4.12-RV]
 - Mobile Device: [e.g. Pixel 8 Pro]
 - OS Version: [e.g. Android 14]

**Test Procedures Executed:**
- [ ] BLE Scan & Device Discovery
- [ ] GATT Service & Characteristic Discovery
- [ ] PAIR Authentication (`PAIR<token>#` -> `ACCEPTED`)
- [ ] 1 Hz ASCII Telemetry Stream (`LD,...`)
- [ ] Auto-Trip Recording
- [ ] Charge Session Detection

**Observed Results & Latency:**
- Connection Latency: ~[ms]
- Telemetry Packet Frequency: [Hz]
- Reconnection Recovery Time: ~[seconds]

**Raw Packet Captures / Logs:**
```text
Paste sanitized raw packet captures or diagnostic logs here
```
