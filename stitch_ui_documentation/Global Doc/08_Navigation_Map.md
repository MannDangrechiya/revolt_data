# 08 - Navigation Map

This document maps out the entire `go_router` navigation tree. The UI replacement must hook into these exact routes.

## Application Root
The app uses a `StatefulShellRoute` to maintain the bottom navigation bar state.

### Bottom Navigation Tabs (Stateful Branches)
1. **Dashboard**
   - Path: `/`
   - Destination: `DashboardScreen`
2. **Rides**
   - Path: `/rides`
   - Destination: `RidesScreen`
3. **Charging**
   - Path: `/charging`
   - Destination: `ChargingScreen`
4. **Analytics**
   - Path: `/analytics`
   - Destination: `AnalyticsScreen`

## Nested Routes (Feature Flows)

### Rides Flow
- **List:** `/rides` 
- **Add:** `/rides/add` -> `RideEntryFormScreen` (Pushed over `/rides`)
- **Edit:** `/rides/edit` -> `RideEntryFormScreen(ride: ride)`
- **Details:** `/rides/:id` -> `RideDetailsScreen`

### Charging Flow
- **List:** `/charging`
- **Add:** `/charging/add` -> `ChargeEntryFormScreen`
- **Edit:** `/charging/edit`
- **Details:** `/charging/:id` -> `ChargeDetailsScreen`

### Expenses Flow
- **List:** `/expenses` -> `ExpensesScreen`
- **Add:** `/expenses/add` -> `ExpenseEntryFormScreen`
- **Edit:** `/expenses/edit`

### Maintenance Flow
- **List:** `/maintenance` -> `MaintenanceScreen`
- **Add:** `/maintenance/add` -> `MaintenanceEntryFormScreen`
- **Edit:** `/maintenance/edit`

### Reminders Flow
- **List:** `/reminders` -> `RemindersScreen`
- **Add:** `/reminders/add` -> `ReminderAddEditScreen`
- **Edit:** `/reminders/edit`

### Documents Flow
- **List:** `/documents` -> `DocumentsScreen`
- **Add:** `/documents/add` -> `DocumentAddScreen`
- **Preview:** `/documents/preview` -> `DocumentPreviewScreen`

### Analytics Deep Dives
- **Battery:** `/battery-analytics` -> `BatteryAnalyticsScreen`
- **Efficiency:** `/efficiency` -> `EfficiencyScreen`
- **Statistics:** `/statistics` -> `StatisticsScreen`
- **Reports (Export):** `/reports` -> `ReportsScreen`

### Profile & Settings Flow
- **User Profile:** `/profile` -> `ProfileScreen`
- **Bike Profile:** `/bike` -> `BikeProfileScreen`
- **Edit Bike:** `/bike/edit` -> `BikeEditScreen`

## Navigation Methods (Stitch Constraints)
When building UI in Stitch, ensure navigation actions trigger standard GoRouter calls:
- **Go To Tab:** `context.go('/rides')` (Switches tab, clears stack).
- **Push Screen:** `context.push('/rides/add')` (Adds to stack, shows back button).
- **Pop:** `context.pop()` (Returns to previous screen).
- **Passing Objects:** Use `extra` for passing models (e.g., `context.push('/rides/edit', extra: myRide)`). Note: Avoid relying solely on `extra` for web URLs, but it is fine for this local mobile app.
