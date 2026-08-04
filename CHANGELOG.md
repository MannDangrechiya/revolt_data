# Changelog

All notable changes to the `revolt_data` application will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] — 2026-08-04

### Added
- **Production Candidate Release (v1.0.0)**: Offline-first EV logbook application for the Revolt RV400 electric motorcycle.
- **Drift SQLite Persistence**: On-device database with 10,000+ record performance capacity, automatic schema migration (v5), and cascading data deletion.
- **Revolt BLE Integration**: Integrated `revolt_ble_sdk` and `revolt_ble_toolkit` for live vehicle scanning, GATT connectivity, PAIR authentication, 1 Hz telemetry streaming, and automated charge/trip detection.
- **Responsive UI & Navigation**: 18 GoRouter routes with bottom navigation shell, full dark mode and light mode (`VoltColors`), list virtualizations, and dynamic flex layouts.
- **Analytics & Export Suite**: Interactive ride statistics, charging analytics, expense tracking, maintenance reminders, and PDF/Excel/CSV data export.
- **Developer Debug Suite**: Production-guarded BLE debug dashboard (`/device/debug`) with simulated telemetry stream toggles.
