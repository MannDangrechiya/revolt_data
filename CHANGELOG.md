# Changelog

All notable changes to the `revolt_data` application will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.2.0+3] — 2026-10-17

### Added
- **Phase 1: Real Telemetry & Physical Cluster Calibration**:
  - Calibrated odometer baseline (`19,920 km`) in Drift SQLite database (schema migration v10) and `SyncStateService`.
  - Added interactive 1-tap "Calibrate Odometer" modal bottom sheet to `DashboardHeader` with quick adjustments ($\pm 1$, $\pm 10$, reset to `19,920 km`, and direct km entry).
  - Implemented GPS breadcrumb noise filter in `BackgroundLocationService` discarding noisy fixes with accuracy $> 20$ meters.
- **Phase 2: Commute & Daily Routine Intelligence**:
  - Added dedicated **Vastral ↔ Kudasan (55 km round-trip) Commute Readiness** assistant card to `DashboardScreen` with live SOC evaluation (🟢 Ready $\ge 75\%$, 🟡 Marginal $60\text{--}74\%$, 🔴 Charge Needed $<60\%$).
  - Added **Night 15A Home Charging Coach** to `HomeChargingScreen` with Gujarat residential tariff preset (`₹6.50/unit`), 80% lithium longevity countdown, daily commute recharge cost (`~₹13/day`), and monthly petrol savings (`~₹2,400/month`).
  - Added **Weekend Idle Battery Guard** rule alerting riders on Friday evening to store battery at $\ge 45\%$ if parked under $20\%$.
- **Phase 3: Universal Multi-EV Protocol Layer (HAL)**:
  - Created universal `EvProtocolAdapter` hardware abstraction interface for connecting to any EV ecosystem.
  - Implemented 4 concrete adapters: `RevoltBleAdapter` (RV400 ASCII), `StandardGattAdapter` (Ather & TVS Bluetooth SIG 0x180F & navigation cues), `SmartBmsAdapter` (Daly / JK / JBD BMS UART 0xFFE0 & active balancing), and `ObdCanAdapter` (ELM327 Bluetooth CAN diagnostic PIDs & DTC code clearing).
  - Added universal EV protocol selector chips directly to `DeviceScanScreen`.
- **Phase 4: Size, Speed, Smoothness & Polish Optimization**:
  - Configured Android Gradle split-per-ABI packaging (`armeabi-v7a`, `arm64-v8a`, `x86_64`) reducing APK download and install size by over 60% (~45MB down to ~14MB).
  - Enabled Android R8 full-mode code shrinking and resource shrinking with comprehensive `proguard-rules.pro`.
  - Added `RepaintBoundary` isolation render layers across high-speed widgets (Speedometer, Power Meter, Mode range row, Performance cluster, and `FlutterMap` views) achieving smooth 120 FPS frame rates.
  - Implemented granular Riverpod `.select()` subscriptions in `LiveBikeMapWidget` to eliminate unnecessary full-screen rebuilds.

## [2.1.0+2] — 2026-10-16

### Added
- **Full MyRevolt Parity with Zero-Login Architecture**: Complete bike companion experience operating directly via BLE and 4G cloud telematics without user registration or OTP login barriers.
- **Adaptive 15-Field Telemetry Parser**: Robust BLE parser supporting standard Revolt RV400 15-field notification layout extracting battery %, voltage, current, temps, speed, odometer, and GPS coordinates without packet drops.
- **OpenStreetMap & Geospatial Visualizer**: Free, keyless interactive OSM map integration with bike location pins and route polyline rendering.
- **Automated Ride & Odometer Gap Engine**: ECU odometer reconciliation engine automatically detecting and recording rides taken without the smartphone companion.
- **Keyless Ignition & Revolt Sound Studio**: Interactive "Swipe to Start" slider (`START#`/`STOP#`) and dedicated sound selector supporting all 4 authentic RV400 exhaust profiles (`Revolt`, `Roar`, `Rebel`, `Rage`).
- **Zero-Login 4G Cloud Telematics**: Seamless background telemetry polling by device ID with live dual-link status indicators (`🟢 Live BLE`, `🔵 4G Cloud`, `⚪ Offline`).
- **Interactive Security Shield**: Geofence radius slider (50m–2000m), real-time distance displacement meter, horn chirp "Find My Bike" (`LOCATE#`), and remote engine immobilizer (`LOCK#`).
- **15A Home AC Charging Intelligence**: Standard household AC 15A socket simulation (~4.5h 0–100%), live power draw monitoring, dynamic time-to-full countdown, and electricity cost calculations.
- **Smart Round-Trip Range Planner**: Elevation and mode-aware round-trip feasibility calculator preventing unexpected stranding.
- **Speed Heatmaps & Animated Trip Replay HUD**: Multi-band color-coded speed segmentations (Green <35 km/h, Amber 35–60 km/h, Red >60 km/h), interactive scrubber slider with playback speed control (1x, 2x, 5x), and moving glowing motorcycle marker.
- **Shareable Ride Story Sheet**: Instant card computing ₹ petrol savings and kg CO₂ offset with one-tap social sharing.
- **Handlebar Cockpit HUD**: High-contrast OLED dark theme with `WakelockPlus` screen wake lock, giant digital speedometer, live power/regen kW rate meter, and multi-mode range projections.
- **Battery Longevity & Health Analytics**: State of Health (SOH %) tracking, equivalent full cycle counter ($kWh / 3.24$), thermal zone history, and lithium care protocols.
- **Full-System Vehicle Diagnostics Self-Check Scanner**: In-app hardware diagnostic scanner inspecting BMS, MCU, 4G IoT telematics, safety sensors, and 12V auxiliary circuits with haptic feedback.
- **RV400 Preventive Mechanical Care Guide**: Continental/Gates carbon belt tensioning rules (5–8mm deflection @ 4.5kg load), cold tyre PSI matrix, CBS brake inspection, and 12V aux battery idle drain guidelines.

## [2.0.0+1] — 2026-08-05

### Added
- **Phase 1 (Battery & Notifications)**: Added battery health trend chart with fl_chart, real local notifications scheduling with flutter_local_notifications, and app constants extraction.
- **Phase 2 (Intelligence & Service)**: Added Intelligence layer with rideScore, healthScore, smartAlerts, service predictions, and dashboard micro-animations.
- **Phase 3 (Ownership & Documents)**: Added document expiry tracking with automated reminder generation, and notification history screen with unread counter.
- **Phase 4 (AI Coaches & Range)**: Added 5 specialized AI Coach providers (Battery, Ride, Charging, Maintenance, Range Prediction) and dedicated Coaches Screen at `/coaches`.
- **Phase 5 (Production & Release)**: Repository cleanup, performance list caching, full WCAG AA accessibility & text scaling, dark mode theme auditing, complete offline verification, and Play Store release prep.

## [1.0.0] — 2026-08-04

### Added
- **Production Candidate Release (v1.0.0)**: Offline-first EV logbook application for the Revolt RV400 electric motorcycle.
- **Drift SQLite Persistence**: On-device database with 10,000+ record performance capacity, automatic schema migration (v5), and cascading data deletion.
- **Revolt BLE Integration**: Integrated `revolt_ble_sdk` and `revolt_ble_toolkit` for live vehicle scanning, GATT connectivity, PAIR authentication, 1 Hz telemetry streaming, and automated charge/trip detection.
- **Responsive UI & Navigation**: 18 GoRouter routes with bottom navigation shell, full dark mode and light mode (`VoltColors`), list virtualizations, and dynamic flex layouts.
- **Analytics & Export Suite**: Interactive ride statistics, charging analytics, expense tracking, maintenance reminders, and PDF/Excel/CSV data export.
- **Developer Debug Suite**: Production-guarded BLE debug dashboard (`/device/debug`) with simulated telemetry stream toggles.
