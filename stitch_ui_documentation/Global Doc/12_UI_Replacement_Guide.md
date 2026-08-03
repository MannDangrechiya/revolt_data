# 12 - UI Replacement Guide

This is the definitive migration plan for the Stitch UI redesign.

## File Classification Key
- ✅ **UI ONLY:** Safe to completely rewrite.
- 🔒 **Logic ONLY:** MUST NOT BE TOUCHED.
- ⚠️ **Mixed:** Proceed with extreme caution. Hook wiring happens here.

## 1. Global & Core Files
- `lib/main.dart` -> ⚠️ Mixed (App initialization vs System UI).
- `lib/app.dart` -> ⚠️ Mixed (MaterialApp vs Theme definitions).
- `lib/core/router.dart` -> ⚠️ Mixed (Routing logic vs Transitions).
- `lib/core/database/*` -> 🔒 Logic ONLY.
- `lib/core/theme/*` -> ✅ UI ONLY.
- `lib/shared/ui/*` -> ✅ UI ONLY.

## 2. Feature: Dashboard
- `features/dashboard/presentation/dashboard_screen.dart` -> ✅ UI ONLY.
- **Action Plan:** Completely redesign the view. Reconnect `ref.watch(ridesProvider)` and others at the top of the `build` method.

## 3. Feature: Rides
- `features/rides/domain/*` -> 🔒 Logic ONLY.
- `features/rides/data/*` -> 🔒 Logic ONLY.
- `features/rides/presentation/rides_screen.dart` -> ✅ UI ONLY.
- `features/rides/presentation/ride_entry_form_screen.dart` -> ⚠️ Mixed. (Form controllers and validation logic must be carefully extracted and re-applied to new text fields).
- `features/rides/presentation/ride_details_screen.dart` -> ✅ UI ONLY.

## 4. Feature: Charging
- `features/charging/domain/*` -> 🔒 Logic ONLY.
- `features/charging/data/*` -> 🔒 Logic ONLY.
- `features/charging/presentation/charging_screen.dart` -> ✅ UI ONLY.
- `features/charging/presentation/charge_entry_form_screen.dart` -> ⚠️ Mixed.

## 5. Feature: Analytics & Reports
- `features/analytics/presentation/*` -> ✅ UI ONLY. (Redesign charts using `fl_chart` with new theming).
- `features/reports/application/*` -> 🔒 Logic ONLY. (PDF/CSV generation logic must remain untouched).

## 6. Migration Strategy for Forms (Crucial)
When replacing form screens (`*entry_form_screen.dart`):
1. Copy the `useTextEditingController` and `useState` hooks exactly.
2. Copy the `onSaved` or `onSubmit` methods exactly (where `ref.read(provider.notifier).add(...)` is called).
3. Replace the `Scaffold`, `Form`, `TextFormField`, and `Buttons` with the new Stitch designs.
4. Re-attach the exact same controllers and `onPressed` callbacks to the new Stitch UI elements.

## 7. Repositories and APIs that MUST REMAIN
- `AppDatabase` (Drift singleton)
- All classes annotated with `@riverpod` or `@Riverpod()`
- All `.freezed.dart` and `.g.dart` generated files. 
- You do not need to re-run `build_runner` if you are only touching the Presentation layer.
