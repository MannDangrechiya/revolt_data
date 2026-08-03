# 03 - Screen Inventory

This document provides a comprehensive inventory of every screen defined in the routing layer, its purpose, state dependencies, and navigation points.

## 1. App Shell (Bottom Navigation)
- **Screen Name:** `AppShell`
- **Route:** Shell wrapping `/`, `/rides`, `/charging`, `/analytics`
- **Purpose:** Provides the main bottom navigation bar (Stateful navigation).
- **Widgets Used:** `OfflineBanner`, `NavigationBar` or custom bottom bar.
- **Dependencies:** `GoRouter` state.

## 2. Dashboard
- **Screen Name:** `DashboardScreen`
- **Route:** `/`
- **Purpose:** Landing page summarizing recent activity, quick stats.
- **Entry Point:** App launch.
- **Exit Points:** Taps on recent rides, charging, or FAB to add new entries.
- **Provider / State:** Likely reads from multiple providers (Rides, Charging, Maintenance).
- **Widgets Used:** `SectionHeader`, `VoltCard`, `StatTile`.

## 3. Rides
- **Screen Name:** `RidesScreen`
- **Route:** `/rides`
- **Purpose:** List all recorded bike rides.
- **Provider:** `ridesProvider` (Riverpod).
- **Exit Points:** `/rides/add`, `/rides/:id`
- **Empty State:** Yes (No rides recorded).

- **Screen Name:** `RideEntryFormScreen`
- **Route:** `/rides/add`, `/rides/edit`
- **Purpose:** Form to add or edit a ride log.
- **Provider:** `ridesProvider.notifier` (add/update methods).
- **Widgets Used:** Forms, `TextFields`, Date Pickers.
- **Validation:** Standard form validation (distance, date).

- **Screen Name:** `RideDetailsScreen`
- **Route:** `/rides/:id`
- **Purpose:** Deep dive into a specific ride's data.

## 4. Charging
- **Screen Name:** `ChargingScreen`
- **Route:** `/charging`
- **Purpose:** List all battery charging sessions.
- **Provider:** `chargingProvider` or similar.

- **Screen Name:** `ChargeEntryFormScreen`
- **Route:** `/charging/add`, `/charging/edit`
- **Purpose:** Form to add/edit charging cost, battery percentage.

- **Screen Name:** `ChargeDetailsScreen`
- **Route:** `/charging/:id`
- **Purpose:** Specific charging session details.

## 5. Analytics & Statistics
- **Screen Name:** `AnalyticsScreen`
- **Route:** `/analytics`
- **Purpose:** Main hub for charts and data summaries.

- **Screen Name:** `BatteryAnalyticsScreen`
- **Route:** `/battery-analytics`
- **Widgets Used:** `fl_chart` (LineChart/BarChart).

- **Screen Name:** `EfficiencyScreen`
- **Route:** `/efficiency`
- **Purpose:** Range and wh/km efficiency tracking.

- **Screen Name:** `StatisticsScreen`
- **Route:** `/statistics`

## 6. Expenses & Maintenance
- **Screen Name:** `ExpensesScreen`
- **Route:** `/expenses`
- **Purpose:** Track insurance, accessories, etc.
- **Provider:** `expensesProvider`.

- **Screen Name:** `ExpenseEntryFormScreen`
- **Route:** `/expenses/add`, `/expenses/edit`

- **Screen Name:** `MaintenanceScreen`
- **Route:** `/maintenance`
- **Purpose:** Track bike servicing.
- **Provider:** `maintenanceProvider`.

- **Screen Name:** `MaintenanceEntryFormScreen`
- **Route:** `/maintenance/add`, `/maintenance/edit`

## 7. Documents & Reminders
- **Screen Name:** `DocumentsScreen`
- **Route:** `/documents`
- **Purpose:** Store PDFs/images of receipts and insurance.
- **Provider:** `documentsProvider`.

- **Screen Name:** `DocumentAddScreen`
- **Route:** `/documents/add`
- **Permissions Required:** Storage/Camera/Files.

- **Screen Name:** `DocumentPreviewScreen`
- **Route:** `/documents/preview`
- **Widgets Used:** `flutter_pdfview`, Image Viewers.

- **Screen Name:** `RemindersScreen`
- **Route:** `/reminders`
- **Purpose:** Upcoming service/insurance reminders.

- **Screen Name:** `ReminderAddEditScreen`
- **Route:** `/reminders/add`, `/reminders/edit`
- **Dependencies:** `flutter_local_notifications`.

## 8. Settings & Profile
- **Screen Name:** `ProfileScreen`
- **Route:** `/profile`
- **Purpose:** User settings, theme toggle, export data.

- **Screen Name:** `BikeProfileScreen`
- **Route:** `/bike`
- **Purpose:** View current bike specifications.

- **Screen Name:** `BikeEditScreen`
- **Route:** `/bike/edit`
- **Purpose:** Edit bike name, battery capacity, make/model.

## 9. Reports (Exporting)
- **Screen Name:** `ReportsScreen`
- **Route:** `/reports`
- **Purpose:** Generate CSV/PDF/Excel exports of logs.
- **Dependencies:** `csv`, `pdf`, `syncfusion_flutter_xlsio`, `share_plus`.
