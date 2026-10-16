# Changelog

All notable changes to the `revolt_data` application will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
