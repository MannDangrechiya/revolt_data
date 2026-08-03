# 14 - Risk Assessment

This document highlights the primary technical risks involved in stripping out the existing Flutter UI and replacing it with Stitch, while maintaining the business logic.

## 1. Form Controller Disconnection (High Risk)
- **The Risk:** In Flutter, `TextEditingController` and `FormState` are deeply intertwined with the UI tree. If the Stitch UI fails to attach the exact same controllers or triggers to the Riverpod notifiers, data will not save.
- **Mitigation:** Ensure the new UI components expose `controller` properties and `onSaved` / `onChanged` callbacks that perfectly mirror the original `TextFormField` parameters.

## 2. Asynchronous State Mismatches (Medium Risk)
- **The Risk:** Riverpod provides `AsyncValue` (Loading, Error, Data). If the Stitch UI only builds the "Data" state and forgets to handle "Loading" or "Error", the app might show a blank screen or crash if a database read is slow.
- **Mitigation:** Wrap all data-driven UI in `asyncValue.when(...)` or ensure Stitch components explicitly handle `isLoading` and `errorText` props.

## 3. GoRouter Context Loss (Medium Risk)
- **The Risk:** `go_router` heavily relies on `BuildContext`. If the UI redesign inadvertently removes the top-level `MaterialApp.router` or breaks the `StatefulShellRoute` nesting, bottom navigation state will be destroyed on tab switches.
- **Mitigation:** Do not modify `router.dart` unless absolutely necessary. When redesigning the `AppShell`, ensure the `navigationShell` is passed down and used exactly as before.

## 4. Theme Inheritance (Low Risk)
- **The Risk:** Hardcoding colors in the new UI instead of using `Theme.of(context)`. If the user toggles Dark Mode, hardcoded white backgrounds will blind them.
- **Mitigation:** Force Stitch generation to use semantic theme tokens (e.g., `Theme.of(context).colorScheme.surface`) rather than hex codes.

## 5. Local File System & Permissions (Low Risk)
- **The Risk:** UI changes in the `DocumentsScreen` or `ReportsScreen` might break the invocation of OS permission dialogs or the `file_picker`.
- **Mitigation:** Extract the actual method calls (e.g., `_pickFile()`) into the Hook widget or Notifier, keeping the UI button as a simple `onPressed: _pickFile`.
