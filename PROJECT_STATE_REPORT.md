# PROJECT STATE REPORT

**Repository:** `revolt_data`
**Audit date:** 2026-08-02
**Auditor role:** Lead Flutter Architect (read-only audit — no code was modified, generated, or added)

> This document describes ONLY the current state of the repository as found on disk. Nothing here speculates about shipped behavior beyond what the source actually does.

---

# 1. Executive Summary

**What this application actually is:**
A **local-first, single-user, offline logbook/journal for a Revolt electric motorcycle** (RV400 is hard-coded as the assumed model throughout). It records rides, charging sessions, expenses, maintenance, documents, and reminders to an on-device SQLite database (Drift) and renders analytics, charts, and exports (PDF/Excel/CSV) from that local data.

**What it is NOT (critical finding):**
There is **no BLE, no Bluetooth, no vehicle connectivity, no telemetry, no authentication, and no backend/network layer** anywhere in the codebase. The pubspec, Android manifest, iOS plist, and all Dart source confirm this. The `models/user.py` file is an orphaned Python/SQLAlchemy backend model disconnected from the Flutter app. Comments referencing rides/battery are derived exclusively from **manually entered logbook entries**, not live vehicle data.

## Project Maturity
| Dimension | Assessment |
|---|---|
| Lifecycle stage | Late prototype → early MVP (feature-complete logbook, zero device integration) |
| Code volume | 127 Dart files (~mostly screens + generated Freezed/Drift code) |
| Build readiness | Compiles conceptually; **not release-ready** |
| Test coverage | 4 test files (1 integration, 1 db, 2 widget) — very thin |
| Architecture quality | Clean, modern, consistent — genuinely good skeleton |

## Current Architecture
- **Pattern:** Feature-first Clean-ish architecture with clear `domain` / `data` / `presentation` separation per feature.
- **Stack:** Flutter + Riverpod (code-gen, `@riverpod`) + Drift (SQLite) + Freezed models + go_router + FlexColorScheme.
- **Data flow:** `Drift Table ↔ Mapper extension ↔ Freezed domain model ↔ Riverpod notifier (AsyncValue/Stream) ↔ Screen`.
- **Documentation:** An unusually thorough pre-existing UI-redesign dossier exists in `stitch_ui_documentation/` (34 markdown files) written to hand the app to a UI team ("Stitch"). `Untitled.canvas` (Obsidian) and `.obsidian/` indicate the repo doubles as a planning vault.

## Overall Status
| Area | Status |
|---|---|
| Logbook CRUD engine | ✅ Working & tested lightly |
| Local persistence | ✅ Solid (Drift, schema v4, FK cascade, migrations) |
| Dashboard / analytics | ✅ Functional, reads from DB |
| Export pipeline | ✅ PDF (pdf pkg), Excel (syncfusion), CSV |
| **BLE / vehicle link** | ❌ **Absent — not started, not scaffolded** |
| Auth / user accounts | ❌ Absent in app |
| Notifications | 🟡 Partial (immediate only; no scheduled/background delivery despite `workmanager` being a declared-but-unused dependency) |
| Native platform config | ❌ Missing all `<uses-permission>` entries (no INTERNET, no BLUETOOTH), so even `connectivity_plus`/notifications are under-provisioned on Android |

**Bottom line:** This is a well-structured manual logging app that needs a hardware-integration layer grafted on. The graft point is clean (see §10/§14), but the revolt_ble_toolkit is a **build-from-zero** addition, not a hook-up.

---

# 2. Folder Structure

| Path | Purpose | Notes |
|---|---|---|
| `lib/` | All Flutter/Dart source | Clean feature-first layout |
| `lib/app.dart` | Root widget (`AppWidget`) → `MaterialApp.router` | Organization name `"VoltLog Engineering"` |
| `lib/main.dart` | `main()` + orientation lock + local-notifications init | No DI setup needed beyond `ProviderScope` |
| `lib/app/view/app_shell.dart` | Bottom-nav (mobile) / NavigationRail (desktop) shell | Context-aware FAB |
| `lib/core/` | Cross-cutting concerns | `router.dart`, `theme/`, `database/`, `services/notifications/`, `utils/`, `widgets/` |
| `lib/core/router.dart` | go_router configuration | Single file, all routes |
| `lib/core/database/` | Drift DB (`app_database.dart`), mappers, provider | `app_database.g.dart` generated |
| `lib/core/theme/` | FlexColorScheme + Google Fonts (Outfit) + sizes | Light & dark |
| `lib/core/widgets/` | `animated_number`, `skeleton_loader`, `error_retry_widget`, `empty_state_widget`, `offline_banner` | Duplicated again under `shared/ui/` |
| `lib/core/utils/` | `report_generator.dart`, `responsive.dart` | Static PDF/CSV helpers |
| `lib/features/<name>/` | 11 feature modules, each split `domain / data / presentation` | `analytics, bikes, charging, dashboard, documents, expenses, maintenance, reminders, reports, rides, settings` |
| `lib/shared/ui/` | "Volt" design-system widgets (`volt_card`, `volt_fab`, `volt_app_bar`, `stat_tile`, etc.) + duplicates of core widgets | Naming/branding = "Volt" |
| `models/` | **Orphaned Python backend model** (`user.py`, SQLAlchemy) | Not referenced by Flutter; references a `revolt_data.database`/`models.vehicle` that do not exist in repo |
| `test/` | Unit/widget tests | 3 files + 1 feature subfolder |
| `integration_test/` | `app_test.dart` — single smoke test | Checks dashboard text only |
| `test_driver/` | Legacy driver stub | For `flutter drive` |
| `android/` | Standard Flutter template | `AndroidManifest.xml` declares **zero permissions** |
| `ios/` | Standard Flutter template | No Bluetooth/permission strings in Info.plist |
| `stitch_ui_documentation/` | 34-file UI redesign handoff dossier | Planning artifacts, not runtime code |
| `assets/` | **Does not exist**; not declared in pubspec | — |

---

# 3. Application Architecture

## Navigation
- **Library:** `go_router: ^17.3.0`.
- **Shape:** One `GoRouter` (`lib/core/router.dart`) with a single `StatefulShellRoute.indexedStack` of **4 branches** — **Dashboard (`/`), Rides (`/rides`), Charging (`/charging`), Analytics (`/analytics`)** — wrapped by `AppShell`.
- Top-level (non-shell) routes exist for: `/battery-analytics`, `/efficiency`, `/expenses(+add/edit)`, `/maintenance(+add/edit)`, `/reminders(+add/edit)`, `/documents(+add/preview)`, `/reports`, `/statistics`, `/profile`, `/bike(+edit)`, and nested detail pages `/rides/:id`, `/charging/:id`.
- **Detail screens receive objects via `state.extra`** (e.g. `ride = state.extra as Ride`) — brittle: deep-linking or process-death restoration will crash because `:id` is read but the non-nullable object is `required`. (`RideDetailsScreen(ride: ride!, …)`, `ChargeDetailsScreen(log: log!, …)`).
- **Route objects are not centrally named/typed** — raw string paths everywhere (`context.push('/rides/add')`).
- `customTransitionPage` = fade transition (easeInOutCirc) used inconsistently (only shell-branch pages).

## State Management
- **Riverpod with code generation** (`riverpod_annotation` + `riverpod_generator`). `hooks_riverpod` bridges widgets; `flutter_hooks` used for `useTextEditingController` + debounce timers.
- Providers live in `features/*/data/*_provider.dart` as `@riverpod class` notifiers exposing Drift `Stream`s → UI consumes `AsyncValue.when(...)`.
- Cross-provider reactivity: `Reminders` provider `ref.listen`s on `ridesProvider` to evaluate odometer-triggered notifications; `BatteryHealth` providers `watch` rides+charges.

## Dependency Injection
- **No dedicated DI container** — Riverpod itself is the service locator. `databaseProvider` is a `@Riverpod(keepAlive: true)` singleton returning `AppDatabase`; everything else reads it via `ref.watch/read(databaseProvider)`.

## Repositories
- A repository abstraction exists **only for bikes**: `bike_repository.dart` (interface) + `bike_repository_impl.dart`. All other features have **no repository layer** — providers query Drift tables directly (e.g. `dashboard_provider`, `rides_provider`, `report_generator_service` all import `app_database.dart`). So the "repository" pattern is aspirational/incomplete.

## Services
See §9. Notable: `NotificationService` (immediate local notifications only) and `ReportGeneratorService` (PDF/XLSX). `core/utils/report_generator.dart` is a second, static report helper (PDF/CSV via `share_plus`).

## Models
Freezed + json_serializable classes with `part '*.freezed.dart'`/`*.g.dart` — see §8.

## Networking
- **None.** No `http`, `dio`, REST, WebSocket. The only network-adjacent dependency is `connectivity_plus`, used solely to show an "offline" banner.

## Storage
- **Drift (SQLite)** — single source of truth, file `revolt_data.sqlite`, background isolate (`NativeDatabase.createInBackground`), `PRAGMA foreign_keys = ON` in `beforeOpen`.
- `path_provider` + `File` used for generated reports & picked files/photos (stored as path strings).
- **No SharedPreferences/Hive** — settings (e.g. theme toggle) are unpersisted.

## Theme
- `FlexColorScheme` `deepBlue`, M3, `GoogleFonts.outfit`, custom `TextTheme`, `VoltRadius`/`Elevations` tokens in `sizes.dart`. Light & dark variants defined; manual theme toggle is a stub (no persistence).

## Routing
Covered under **Navigation** (go_router).

## Error Handling
- UI-level: `ErrorRetryWidget` on `AsyncValue` error branches; try/catch with `SnackBar` on export actions.
- Domain validation: `ChargingAnomaly.checkAnomaly` (pure function) guards charge entries; odometer-monotonicity check in `rides_provider.addRide` throws `Exception`.
- **No global error zone / crash reporter**; `main()` catches and `debugPrint`s then runs app anyway.

---

# 4. Implemented Screens

| # | Screen (file) | Purpose | Status | Implemented | Missing / Known gaps | Depends on | Route |
|---|---|---|---|---|---|---|---|
| 1 | `dashboard_screen.dart` | Home summary | ✅ Complete | ODO, battery %, est. range (hard-coded 1.5 km/%), today/week/month distance, upcoming reminder card, 8-tile quick actions, animated numbers | Reminder "check" button has empty handler (`// mark as done`); battery = last manual log, not live | `dashboardDataProvider`, `currentBikeProvider` | `/` |
| 2 | `rides_screen.dart` | Ride log list | ✅ Complete | Month-grouped slivers, debounced search, filter chips (fav/eco/sport), dismiss-to-delete w/ UNDO, filter bottom-sheet (reset/apply only — sheet has no actual extra inputs) | Filter sheet is mostly empty ("Advanced Filters" placeholder) | `filteredRidesProvider`, `rideFilterStateProvider` | `/rides` |
| 3 | `ride_entry_form_screen.dart` | Add/edit ride | ✅ Complete | Form + photo picking (image_picker) | — (not fully re-read, referenced by tests) | `ridesProvider` | `/rides/add`, `/rides/edit` |
| 4 | `ride_details_screen.dart` | Ride detail | 🟡 Present | Renders ride passed via `extra` | Crashes if opened without `extra` (deep link) | — | `/rides/:id` |
| 5 | `charging_screen.dart` | Charge log list | ✅ Complete | `BatteryHealthDashboard` header, debounced search, location chips, dismiss-delete + UNDO | Filter sheet placeholder | `filteredChargeLogsProvider`, `chargeFilterStateProvider`, `batteryHealthProvider` | `/charging` |
| 6 | `charge_entry_form_screen.dart` | Add/edit charge | ✅ Complete | Validation incl. `ChargingAnomaly`; battery/kWh/speed sanity checks | Hard-coded battery capacity (3.24 kWh) & max charge speed (5 kW) | `chargingLogsProvider` | `/charging/add`, `/charging/edit` |
| 7 | `charge_details_screen.dart` | Charge detail | 🟡 Present | Renders log via `extra` | Same deep-link fragility | — | `/charging/:id` |
| 8 | `battery_health_dashboard.dart` | Cycles/efficiency/health card | ✅ Complete | Charge-cycle count, km/kWh, heuristic health % | Health = pure heuristic (100 − 0.01%/cycle), no real SOH data | `totalChargeCyclesProvider`, `powerEfficiencyProvider`, `batteryHealthEstimateProvider` | embedded widget |
| 9 | `expenses_screen.dart` | Expense list | ✅ Complete | List + entries | — | `expensesProvider` | `/expenses` |
| 10 | `expense_entry_form_screen.dart` | Add/edit expense | ✅ Complete | 12 categories, receipt photo | — | `expensesProvider` | `/expenses/add`, `/expenses/edit` |
| 11 | `maintenance_screen.dart` | Maintenance log | ✅ Complete | Component list, service reminders | — | `maintenanceLogsProvider` | `/maintenance` |
| 12 | `maintenance_entry_form_screen.dart` | Add/edit maintenance | ✅ Complete | 9 trackable component booleans, parts/labour/warranty | — | `maintenanceLogsProvider` | `/maintenance/add`, `/maintenance/edit` |
| 13 | `reminders_screen.dart` | Reminder list | ✅ Complete | Date/odometer targets, complete toggle | — | `remindersProvider` | `/reminders` |
| 14 | `reminder_add_edit_screen.dart` | Add/edit reminder | ✅ Complete | — | — | `remindersProvider` | `/reminders/add`, `/reminders/edit` |
| 15 | `documents_screen.dart` | Document vault | ✅ Complete | List, categories | — | `documentsProvider` | `/documents` |
| 16 | `document_add_screen.dart` | Add doc | ✅ Complete | file_picker + image_picker | — | `documentsProvider` | `/documents/add` |
| 17 | `document_preview_screen.dart` | View doc | 🟡 Present | flutter_pdfview for PDFs | Non-PDF preview minimal | — | `/documents/preview` |
| 18 | `analytics_screen.dart` | Analytics hub | ✅ Complete | Links to battery/efficiency, 3 charts, **static** PDF/CSV export buttons | Uses a *separate* static `ReportGeneratorService.generateAndSharePdf/Csv` (different from `features/reports` service) | charts + static report util | `/analytics` |
| 19 | `battery_analytics_screen.dart` | Battery charts | ✅ Complete | — | Heuristic only | battery providers | `/battery-analytics` |
| 20 | `efficiency_screen.dart` | Efficiency charts | ✅ Complete | — | — | efficiency service | `/efficiency` |
| 21 | `statistics_screen.dart` | Ownership stats | ✅ Complete | TCO, petrol savings, CO₂, longest/shortest/avg ride, monthly expense map | Hard-coded petrol ₹100/L, 40 km/L, CO₂ factors | `statisticsServiceProvider` | `/statistics` |
| 22 | `reports_screen.dart` | Report generator UI | ✅ Complete | Date-range pick, detailed toggle → PDF(X) via `ReportGeneratorService` | — | `reportGeneratorServiceProvider` | `/reports` |
| 23 | `bike_profile_screen.dart` | Vehicle profile | ✅ Complete | Specs display | — | `currentBikeProvider` + bikes repo | `/bike` |
| 24 | `bike_edit_screen.dart` | Bike editor | ✅ Complete | All spec fields + photo (image_picker) | Only a single "current bike" concept | bikes repo | `/bike/edit` |
| 25 | `profile_screen.dart` | Settings hub | 🟡 Partial | Static avatar/name ("Revolt Rider"), nav tiles to logs | **App Theme, Export Data, About items have empty `onTap`** (marked `// Future implementation`); no edit-profile, no sign-in | — | `/profile` |

**Screen count:** 25 screens/views + ~10 reusable widgets/charts.

---

# 5. BLE Integration Status

## Is BLE implemented? **NO.**

Evidence (exhaustive):
- **pubspec.yaml:** no `flutter_blue_plus`, `flutter_blue`, `flutter_reactive_ble`, `ble*`, or anything similar.
- **Dart source:** zero imports/usages of scan/connect/GATT/characteristic APIs (grep for `ble|bluetooth|gatt|characteristic|peripheral|scan` returned only coincidental substrings like "established" — no real matches).
- **AndroidManifest.xml:** contains **no `<uses-permission>` at all** — missing `BLUETOOTH`, `BLUETOOTH_SCAN`, `BLUETOOTH_CONNECT`, `ACCESS_FINE_LOCATION` (required for BLE scanning on Android), and even `INTERNET`.
- **iOS Info.plist:** no `NSBluetoothAlwaysUsageDescription` / `NSBluetoothPeripheralUsageDescription` keys.
- **No onboarding/pairing/device screens, no connection state model, no telemetry parser.**

## What placeholders exist?
- None that are BLE-shaped. The closest "live data" surfaces are dashboard Battery/Est-Range, which are populated from **manually entered** `batteryAfter`/`endBattery` log values, and an **est-range heuristic (`percent × 1.5 km`)**.
- The domain models contain fields that *could* be fed by live data (`averageSpeed`, `maxSpeed`, `estimatedRemainingRange`, `maxChargingPowerKw`, battery health) but are currently manual/heuristic.
- `workmanager` is in pubspec but **unused** — could have been intended for background BLE polling, but there's no code.

## What is required to integrate `revolt_ble_toolkit`? (state, not plan — see §14)
1. Add toolkit + BLE permissions to both platforms (Android 12+ runtime permissions; iOS usage strings + background modes).
2. New feature module (e.g. `features/ble/…` or `features/vehicle_link/…`) with its own repository + providers.
3. A mapping layer from BLE telemetry → existing Drift insertion paths (`Rides`, `ChargeLogs`) or new telemetry tables.
4. UI: scan/pair/connect screens + connection-state indicator + dashboard live tiles.
5. Replace heuristics (range, health) with real values where the toolkit supplies them, keeping heuristics as fallback when disconnected.

---

# 6. Business Logic

| Domain | Implemented? | How / Gaps |
|---|---|---|
| **Authentication** | ❌ No | No auth at all. `models/user.py` is dead Python code. App is single-user device-local. |
| **User** | ❌ No | No user entity in Drift schema; profile screen is hard-coded ("Revolt Rider"). |
| **Vehicle (Bike)** | 🟡 Yes (single) | `BikesTable` + repo + profile/edit screens. Conceptually one "current bike"; FK `bikeId` threads through rides/charges/expenses/maintenance/docs/reminders with cascade delete. |
| **Ride** | ✅ Yes | Full CRUD, odometer-monotonicity guard, favorites, duplicate, search/filter, distance & battery-delta helpers. |
| **Charging** | ✅ Yes | CRUD + strong input validation (`ChargingAnomaly`), battery-added & charge-speed derived props, photo paths, provider/power fields. |
| **Dashboard** | ✅ Yes | Aggregates across tables via a dummy `SELECT 1` watch on 6 tables → recompute; hard-coded petrol/CO₂/range assumptions documented inline. |
| **Telemetry** | ❌ No | No telemetry ingestion of any kind; only derived analytics from logs. |
| **Settings** | 🟡 Partial | Profile screen shell; theme toggle/export/about are no-ops. No settings persistence (no shared_prefs). |
| **History** | ✅ Yes | Implicitly the rides/charges/expenses/maintenance lists + month grouping + filters. |
| **Notifications** | 🟡 Partial | Immediate notifications fire when a newly logged ride crosses an odometer-target reminder (50 km proximity). **No scheduled/time-based notifications, no exact alarms, no background engine** — the service comment itself admits timezone scheduling was skipped. |
| **Reports/Analytics** | ✅ Yes | Statistics service, three chart widgets, battery/efficiency analytics, PDF/Excel/CSV export. |

---

# 7. UI Status

**Design language:** Consistent M3 + FlexColorScheme deepBlue + Outfit typography; "Volt" component family cards/FAB/app-bar/snackbars; `lucide_icons` throughout; `AnimatedNumber`, `SkeletonLoader`, `EmptyStateWidget`, `ErrorRetryWidget`, `OfflineBanner` shared primitives; responsive NavigationRail on tablet/desktop.

| Category | Screens / components |
|---|---|
| **Complete & polished** | Dashboard, Rides list + entry + details, Charging list + entry + details, Expenses, Maintenance, Reminders, Documents list/add, Bike profile/edit, Analytics hub, Battery analytics, Efficiency, Statistics, Reports |
| **Incomplete / placeholdery** | Profile screen (3 dead menu items), Rides/Charging "Advanced Filters" bottom sheets (title + reset/apply only), Document preview (PDF-only), Dashboard reminder "done" button (no-op) |
| **Missing entirely** | Any BLE/device screen (scan, pairing, connection status, live telemetry), Auth screens (login/signup), Onboarding, Theme-settings screen, Data-export settings UI (profile item dead), About screen |

---

# 8. Models

All app models are **Freezed immutable classes** with JSON support:

| Model | File | Key contents |
|---|---|---|
| `Ride` | `features/rides/domain/ride.dart` | id, date, start/end odometer, battery before/after, `RideMode` (eco/normal/sport), `RoadCondition` (smooth/average/bad), notes, photoPaths, times, speeds, weather, purpose, locations, tags, favorite, bikeId. Extensions: `distance`, `batteryConsumed` |
| `RideFilter` | `rides/domain/ride_filter.dart` | searchQuery, rideMode, roadCondition, dateRange, isFavorite |
| `ChargeLog` | `charging/domain/charge_log.dart` | id, date, duration, kwhAdded, cost, `PaymentMethod` (5), `LocationType` (home/public/work), start/end battery, times, chargerType/method, electricity price, provider, max power, photos, bikeId. Ext: `chargingSpeedKw`, `batteryAdded` |
| `ChargeFilter` | `charging/domain/charge_filter.dart` | searchQuery, locationType, dateRange |
| `ChargingAnomaly` | plain class | static validator returning `{message, isError}`; encodes RV400 assumptions (3.24 kWh, 5 kW max) |
| `Expense` | `expenses/domain/expense.dart` | `ExpenseCategory` (12 values), amount, notes, receipt photo, description, bikeId |
| `MaintenanceLog` | `maintenance/domain/maintenance_log.dart` | `MaintenanceComponent` (6), description, odo, cost, service-center/parts/labour/warranty/technician, next-service fields, 9 component booleans, bikeId |
| `Reminder` | `reminders/domain/reminder.dart` | title/body, targetDate XOR targetOdometer, isCompleted, isNotified, type, note, isActive, bikeId |
| `Bike` | `bikes/domain/bike.dart` | 20+ spec fields (brand/model/vin/motor, purchase, warranty, batteryCapacity, motorPower, claimedRange, topSpeed, tyres, photo) |
| `Document` | `documents/domain/document.dart` | name, category, filePath, uploadDate, notes, bikeId |
| `DashboardData` + `RecentActivity` | `dashboard/domain/*` | aggregated metrics incl. petrolSaved/co2Saved, latestBatteryPercentage; `ActivityType` enum |
| `StatisticsData` | plain class in `statistics_service.dart` | ownership-cost/savings/CO₂ + monthly expense map |
| **(non-app)** `User` | `models/user.py` | **Python SQLAlchemy ORM** (email, hashed_password, …) — orphaned backend artifact |

---

# 9. Services

| Service | File | What it actually does |
|---|---|---|
| `NotificationService` | `core/services/notifications/notification_service.dart` | Wraps `flutter_local_notifications`; **only `showImmediateNotification`** on channel `revolt_alerts`. Comment explicitly notes no `zonedSchedule`/timezone setup. |
| `StatisticsService` | `features/analytics/application/statistics_service.dart` | Computations over all tables: TCO, petrol savings (₹100/L, 40 km/L), CO₂ (2.3 kg/L vs 0.5 kg/kWh), ride stats, monthly expenses. |
| Battery analytics trio | `features/charging/data/battery_health_provider.dart` + `analytics/application/battery_analytics_service.dart` | charge cycles (ΣbatteryAdded/100), km/kWh efficiency, heuristic health (100 − 0.01%/cycle). |
| `EfficiencyService` | `features/analytics/application/efficiency_service.dart` | per-period distance/cost-per-km style aggregates. |
| `ReportGeneratorService` (Riverpod) | `features/reports/application/report_generator_service.dart` | Date-ranged **PDF** (pdf pkg) & **Excel** (syncfusion xlsio) with summary + detailed tables; writes to app docs dir. |
| `ReportGenerator` (static util) | `core/utils/report_generator.dart` | Parallel **PDF/CSV** quick-export used by Analytics screen via `share_plus`. Two overlapping implementations exist (see §12). |
| `OfflineBanner` logic | `shared/ui/offline_banner.dart` | `connectivity_plus` stream → banner (only non-local service consumer). |

**Absent services:** auth, remote API client, BLE/telemetry service, background scheduler (workmanager unused), settings storage, file-permission handler.

---

# 10. Integration Readiness (for `revolt_ble_toolkit`)

## Already prepared (surprisingly good)
- **Clean insertion seams:** every record goes through `notifier.addX()` / Drift insert; a BLE pipeline can call the exact same notifiers so the UI/watchers/migrations need zero changes.
- **Reactive plumbing:** all screens are stream-driven — push new rows, UI updates automatically.
- **Domain fields reserved:** models already carry fields that live data would populate (speed, range, power, battery after) without schema breakage.
- **Reactive triggers exist** (`Reminders` listening to rides) showing the codebase already patterns "react to new ride rows" — BLE-derived rides would flow through the same triggers.
- **Provider architecture** trivially accepts a new data source alongside manual entry.
- **Repository precedent** (`bike_repository`) demonstrates where a `BleVehicleRepository` interface would sit.

## Required changes
1. **pubspec:** add `revolt_ble_toolkit` (and transitive BLE plugin, e.g. flutter_blue_plus/reactive_ble).
2. **AndroidManifest:** add BLUETOOTH / BLUETOOTH_SCAN (`neverForLocation` as applicable) / BLUETOOTH_CONNECT / ACCESS_FINE_LOCATION (+ `uses-feature android.hardware.bluetooth_le`); likely `POST_NOTIFICATIONS` & `FOREGROUND_SERVICE` if background connection is wanted.
3. **iOS Info.plist:** `NSBluetoothAlwaysUsageDescription`, background modes `bluetooth-central` if needed.
4. **New feature module** `features/ble/` (data: toolkit wrapper repo + connection-state provider; domain: `VehicleSnapshot`/`TelemetryFrame` models; presentation: scan/pair/status screens).
5. **Router:** new routes for device onboarding/status.
6. **Schema decision:** either map telemetry into existing tables (rides auto-created with real odo/battery/speed) — easiest, no migration — or add a `telemetry_samples` table (schema v5 migration) for high-rate data with roll-ups into rides.
7. **Merge/reconciliation policy:** define how manual logs coexist with auto logs (e.g. `source: manual|ble` flag — would need a column + migration, or a separate table).
8. **Replace heuristics:** dashboard range (×1.5), battery health (heuristic), charge anomaly capacity constants should prefer actual bike specs/`claimedRange`/real SOH when a device is linked.

---

# 11. Missing Features

### Critical
- **BLE / vehicle connectivity end-to-end** (scan→pair→connect→read telemetry→stream into app) — *Large (weeks)*.
- **Platform permissions** (Android BLE + INTERNET, iOS Bluetooth strings) — *Small* (hours) but release-blocking even for non-BLE features on Android.

### High
- **Live connection state UI** + dashboard live battery/range tile — *S–M*.
- **Telemetry→log automation** (auto ride/charge creation; manual/BLE source flag + migration) — *M*.
- **Deep-link-safe detail routes** (stop passing objects through `state.extra`) — *S*.
- **No INTERNET permission / notification POST_NOTIFICATIONS** on Android — *S*.

### Medium
- **Profile screen completion** (Theme toggle + persistence, Export Data wiring, About) — *S*.
- **Advanced filter sheets** content (they're placeholders) — *S*.
- **Scheduled/time-based & background reminder notifications** (timezone pkg, exact alarms or workmanager activation) — *M*.
- **Document preview for non-PDF files** — *S*.
- **Multi-bike switching** (currently implicit single bike) — *M*.

### Low
- Auth/cloud-sync (out of current product scope as a local-first app) — *L if ever added*.
- Unified report service (dedupe the two implementations) — *S*.
- Theming beyond deepBlue, localization beyond `intl`, accessibility audit — *S–M* each.

---

# 12. Technical Debt

**Architecture problems**
- Repository pattern exists for exactly one feature (bikes); everything else couples providers directly to Drift. No consistent data-layer abstraction.
- Two overlapping report generators (`features/reports/...` vs `core/utils/report_generator.dart`).
- Duplicated widget sets: `core/widgets/` and `shared/ui/` contain near-identical `offline_banner`, `skeleton_loader`, `empty/error` widgets.
- `prof_screen` hard-codes the rider/bike identity instead of reading `Bike`/`currentBikeProvider`.
- `dashboard_provider` hack: `db.customSelect('SELECT 1', readsFrom:{…})` used as a change trigger, plus a manual `state=` seed inside `build()` — works but fragile.

**Performance issues**
- Analytics/statistics recompute by loading **entire tables** into memory (`db.select(...).get()`) — fine at logbook scale, O(n) growth unchecked.
- No pagination on long lists (full in-memory grouping by month).
- `BatteryHealth`/dashboard recompute on every row change of six tables.

**Code smells**
- `state.extra as Ride` / `as ChargeLog` force-casts + `!` deep-link crashes.
- Magic numbers everywhere: `1.5 km/%`, `3.24 kWh`, `5 kW`, `₹100/L`, `40 km/L`, `0.01%/cycle`, CO₂ constants — duplicated between dashboard & statistics service (they disagree slightly: 60 g/km vs petrol-based math).
- Unused dependencies declared: `workmanager`, `mockito` (no mocks found), `csv` is used only by static util, `lottie`/`shimmer` with no obvious usage sites, `flutter_pdfview` only for doc preview.
- `print`-style logging via `debugPrint`; no structured logging.
- `RideDetailsScreen`/`ChargeDetailsScreen` require non-null object but route signature suggests id-based fetch.

**Duplicated code**
- Widget/empty-state duplication core↔shared (see above).
- Petrol/CO₂ constants duplicated in dashboard_provider and statistics_service.
- Filter/search scaffold logic copy-pasted between rides_screen and charging_screen (could be a generic scaffold).

**Missing tests**
- 4 test files total: `database_test` (CRUD + cascade), one bike repository test, dashboard widget test, ride-entry widget test, plus one integration smoke test.
- Zero tests for: charging anomaly validator (pure function — ideal candidate), statistics/report services, reminders odometer engine, filters, most screens, any native/permission path.

**Other**
- `.obsidian/`, `Untitled.canvas`, `stitch_ui_documentation/`, `models/user.py` checked into the app repo — repo hygiene.
- `.cursorrules` itself lists known gaps ("Missing fields/tables…") — self-acknowledged debt.

---

# 13. Release Readiness

**Can it be released today? — NO.**

Exactly why:

1. **The app's stated premise (from `pubspec` description: "Production-grade…", from you: Revolt integration) includes vehicle/BLE connectivity — it has none.** As a pure manual logbook it's releasable; as a connected Revolt app it is not.
2. **Android manifest has zero permissions.** Consequences: BLE impossible; `connectivity_plus` and local notifications under-provisioned; `POST_NOTIFICATIONS` (API 33+) absent → notifications silently fail; camera/file picking flows lack permission guards.
3. **App identity is template-grade:** `android:label="revolt_data"`, default launcher icon, no versioned release config, no signing config present/visible.
4. **Deep-link/process-death crash vectors** on `/rides/:id` and `/charging/:id` (forced unwrap of `state.extra`).
5. **Profile screen ships dead menu items** ("Future implementation") — unfinished surface.
6. **Single-user, no onboarding/no first-run bike setup gate:** dashboard shows "My RV400"/battery 100 defaults before any data exists.
7. **Test/QA surface is minimal** (4 files) with no CI evidence beyond a `flutter_test` workflow file; no release-mode verification found.
8. **iOS Bluetooth strings absent** — App Store would reject the moment BLE is added.

Releasable as a **closed beta manual logbook** after items 2–6 (≈Small effort). Not releasable as the connected Revolt companion product.

---

# 14. Integration Plan — `revolt_ble_toolkit` (no implementation code)

**Phase 0 — Decide the data contract**
1. Ask the toolkit for its stream surface: connection state, scanned devices, and a typed telemetry frame (battery %, odometer, speed, charging state/power, faults, range, SOH).
2. Decide storage strategy: **Option A (recommended first): map telemetry into existing tables** — auto-create `Ride` rows when a trip ends (real odo/duration/speed/battery delta), update a "live snapshot" in state; **Option B: add `telemetry_samples` table (schema v5)** for high-rate data with roll-ups.

**Phase 1 — Platform enablement**
3. Add toolkit dependency; add Android permissions (`BLUETOOTH_SCAN/CONNECT`, location, `uses-feature ble`, plus `INTERNET`/`POST_NOTIFICATIONS` housekeeping); add iOS Bluetooth usage descriptions + `bluetooth-central` background mode if continuous connection is required.

**Phase 2 — Module skeleton (mirrors existing feature-first pattern)**
4. `features/ble/domain`: `BleDeviceInfo`, `ConnectionState` enum, `VehicleSnapshot` (Freezed).
5. `features/ble/data`: `BleVehicleRepository` interface + `RevoltBleRepository` impl wrapping the toolkit; `connectionStateProvider` (StreamProvider), `activeDeviceProvider`, `vehicleSnapshotProvider` (StreamProvider of telemetry).
6. Lifecycle handling: reconnect-on-resume, stop-scan timeouts, error → `AsyncValue` for UI banners.

**Phase 3 — UI**
7. Routes: `/device` (status), `/device/scan` (nearby Revolt bikes), pairing flow; connection dot in `AppShell`/dashboard; reuse `volt_card`/`volt_fab` vocabulary.
8. Dashboard: replace static battery card with `vehicleSnapshotProvider` when connected, fallback to last-logged value with a "last updated" caption; live range from toolkit instead of ×1.5 heuristic.

**Phase 4 — Automation**
9. Background/running trip detector (movement + odometer delta + battery drop) → on session end call `ridesProvider.addRide(...)` (validation reuses odometer guard — verify monotonicity against BLE odo).
10. Charging sessions similarly → `chargingLogsProvider.addChargeLog`; prefill kWh from toolkit energy if available, else derive.
11. Feed real SOH into `battery_health_dashboard`, demoting the heuristic to fallback.
12. Tag auto rows with `source = ble` (small column migration) so manual entries stay distinguishable; dedupe if a user also logs manually.

**Phase 5 — Resilience & notification loop**
13. Use `workmanager` (already declared) for connection maintenance/reminder evaluation in background; wire scheduled notifications properly (timezone pkg).
14. QA: permission-denied flows, airplane mode, phone restarted mid-ride, two bikes in range, background kill. Add tests around repositories using toolkit fakes (mockito is already a dev dep).

**Sequencing note:** Phases 3–4 each work as independent releases behind a feature flag; manual logbook remains fully functional with BLE off.

---

# 15. Final Score

| Dimension | Score /10 | Justification |
|---|---:|---|
| **Architecture** | 8 | Clean feature-first layering, stream-driven providers, documented seams. Docked for partial repository adoption + duplicated infra. |
| **Flutter (idiomatic use)** | 8 | Code-gen Riverpod, Freezed, Drift, hooks, M3 done right. Docked for `state.extra` routing anti-pattern. |
| **UI** | 8 | Cohesive, responsive, polished core; placeholder corners (profile, filter sheets) hold it back. |
| **Maintainability** | 7 | Consistent patterns and great internal docs; magic constants, dual report services, and duplicated widgets add friction. |
| **Testing** | 3 | Only 4 files; core business validators and services untested; no BLE/native-path tests possible yet. |
| **Readiness (release)** | 3 | Works as manual logbook; zero permissions, template identity, crash vectors block store release; core product feature (BLE) absent. |
| **Documentation** | 9 | Exceptional `stitch_ui_documentation/` dossier + inline comments; README is thin, hence not 10. |
| **Code Quality** | 7 | Mostly clean, lint-enabled, generated code kept separate; copy-paste between list screens and dead deps noted. |
| **Overall** | **6.6 / 10** | A genuinely well-built manual EV logbook whose headline feature — Revolt vehicle connectivity — is a clean-sheet integration waiting to happen. The architecture is ready for it; the product, as shipped today, is half of what it promises to be. |

---

*End of report. Generated read-only from repository state; no code was created or modified.*
