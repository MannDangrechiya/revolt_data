# 19 - Files Requiring Refactoring

This document highlights files where the UI is currently too intertwined with business or operational logic to be handed over to an automated UI tool like Stitch without high risk of breakage.

## The Problem
Stitch expects to generate "dumb" presentation widgets that accept parameters or watch providers. When a widget uses `ConsumerStatefulWidget` and handles its own `setState`, file picking logic, or system dialogs, replacing the `build` method often destroys the underlying logic.

## Files to Refactor Before Stitch Handoff

### 1. `lib/features/documents/presentation/document_add_screen.dart`
- **Issue:** Uses `setState` to manage the selected file. Calls `FilePicker.platform.pickFiles` directly inside an `onPressed` handler within the widget tree.
- **Required Refactor:** 
  - Move the File Picking logic into a `Notifier` or Riverpod Provider.
  - Convert the screen to a `ConsumerWidget` or `HookConsumerWidget`.
  - Let the UI simply read `ref.watch(selectedFileProvider)`.

### 2. `lib/features/documents/presentation/documents_screen.dart`
- **Issue:** Uses `showDialog` directly in the UI tree to confirm deletion.
- **Required Refactor:** Ensure the Stitch team knows they must re-implement this specific `showDialog` call on the new delete button, or move the confirmation logic into the provider layer (e.g., `ref.read(docsProvider).confirmAndDelete(context)`).

### 3. `lib/features/reminders/presentation/reminder_add_edit_screen.dart`
- **Issue:** Initializes `TextEditingController` instances inside `initState()` of a `ConsumerStatefulWidget`.
- **Required Refactor:** Convert to `HookConsumerWidget` and use `useTextEditingController()`. This normalizes the file with the rest of the application (like Rides and Charging), making it predictable for Stitch.

### 4. `lib/features/reports/presentation/reports_screen.dart`
- **Issue:** Uses `ConsumerStatefulWidget`.
- **Required Refactor:** Convert to `HookConsumerWidget`.

## Summary
The codebase is exceptionally clean and well-architected. However, standardizing the 5 files mentioned above to use `flutter_hooks` instead of `StatefulWidget` will guarantee a 100% smooth UI replacement process.
