# Changelog

All notable changes to the `revolt_data` application will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
