# 05 - State Management

This document details the state management architecture for the application, which MUST remain exactly as is when redesigning the UI.

## Overview
The application uses **Riverpod** (via `hooks_riverpod` and `riverpod_annotation`) as the primary state management and dependency injection solution. `flutter_hooks` is used in the widget layer for managing local UI state (like `TextEditingController`s or `AnimationController`s).

## Core Concepts (Do Not Modify)

### 1. Code Generation (`@riverpod`)
Most providers are generated using the `@riverpod` annotation. You will see `.g.dart` files throughout the `features/` folders. 
- **Rule:** When replacing UI, you will consume these providers using `ref.watch()`, `ref.read()`, or `ref.listen()`. Do not change the underlying classes annotated with `@riverpod` or `@Riverpod(keepAlive: true)`.

### 2. Provider Types Used
- **FutureProvider (AsyncNotifier):** Used heavily for fetching lists of data from the Drift database (e.g., fetching all rides). State is exposed as an `AsyncValue` (`data`, `loading`, `error`).
- **Notifier (Sync):** Used for managing in-memory states, such as selected filters or current tabs.

### 3. Key Global Providers
- `databaseProvider`: Provides the singleton instance of the Drift database (`AppDatabase`).
- `sharedPreferencesProvider`: Provides access to local key-value storage.

### 4. Feature-Specific Providers
Below is a map of the expected providers powering the screens. 
*(Note: File paths typically follow `lib/features/{feature}/data/{feature}_provider.dart`)*

#### Rides (`ridesProvider`)
- **State:** `AsyncValue<List<Ride>>`
- **Actions Exposed:** `addRide()`, `updateRide()`, `deleteRide()`.
- **Consumer:** `RidesScreen`, `DashboardScreen`.

#### Charging (`chargingProvider`)
- **State:** `AsyncValue<List<ChargeLog>>`
- **Actions Exposed:** `addCharge()`, `updateCharge()`, `deleteCharge()`.
- **Consumer:** `ChargingScreen`, `BatteryAnalyticsScreen`.

#### Maintenance (`maintenanceProvider`)
- **State:** `AsyncValue<List<MaintenanceLog>>`
- **Actions Exposed:** `addLog()`, `updateLog()`, `deleteLog()`.

#### Expenses (`expensesProvider`)
- **State:** `AsyncValue<List<Expense>>`
- **Actions Exposed:** `addExpense()`, `updateExpense()`, `deleteExpense()`.

#### Settings / Profile (`profileProvider`)
- **State:** `AsyncValue<UserProfile>`
- **Actions Exposed:** `updateTheme()`, `updateBikeName()`, `exportData()`.

## 5. UI Layer Consumption (Hooks + Riverpod)
Screens are typically implemented as `HookConsumerWidget`.
```dart
class MyScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Riverpod State
    final ridesAsync = ref.watch(ridesProvider);
    
    // 2. Local Hook State
    final scrollController = useScrollController();
    
    return ridesAsync.when(...);
  }
}
```
**Stitch Constraint:** When redesigning the UI, the new widgets MUST inherit from `ConsumerWidget` or `HookConsumerWidget` and use the EXACT SAME `ref.watch` calls to tap into the logic.
