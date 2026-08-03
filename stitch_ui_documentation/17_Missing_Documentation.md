# 17 - Missing Documentation

During the verification audit, the following elements were found in the source code but were omitted or under-documented in Phases 1-15.

## 1. Modals & Overlays (Critical for Stitch)
The documentation implied forms were standalone screens. However, the audit reveals heavy usage of **Modal Bottom Sheets** across the app:
- `features/rides/presentation/rides_screen.dart` -> Calls `showModalBottomSheet()` (Lines 148, 262) for filters or quick actions.
- `features/charging/presentation/charging_screen.dart` -> Calls `showModalBottomSheet()` (Line 213).
- `features/maintenance/presentation/maintenance_screen.dart` -> Calls `showModalBottomSheet()` (Line 31).
- `features/expenses/presentation/expenses_screen.dart` -> Calls `showModalBottomSheet()` (Line 32).
- `features/documents/presentation/document_add_screen.dart` -> Calls `showModalBottomSheet()` (Line 146).

*Impact for Stitch:* The UI redesign must account for these overlays. They are not just full-page routes; they require specific modal wrapper styling.

## 2. StatefulWidgets (`setState`) vs Hooks
The `05_State_Management.md` document stated the app exclusively uses `flutter_hooks`. 
**Missing Detail:** 
The following screens bypass `flutter_hooks` and use `ConsumerStatefulWidget`, initializing `TextEditingController`s manually and using `setState`:
- `ReportsScreen` (`reports_screen.dart:9`)
- `ReminderAddEditScreen` (`reminder_add_edit_screen.dart:10`)
- `RemindersScreen` (`reminders_screen.dart:13`)
- `DocumentAddScreen` (`document_add_screen.dart:14`)
- `DocumentsScreen` (`documents_screen.dart:13`)

*Impact for Stitch:* These screens contain mixed logic. Standard UI replacement is riskier here because `setState` is tied directly to the widget's lifecycle.

## 3. System Dialogs (Permissions & Deletions)
- `documents_screen.dart` uses `showDialog<bool>` on line 157 for a destructive action confirmation (Delete Document). This was not mapped as a reusable UI component.
- `document_add_screen.dart` heavily utilizes `FilePicker.platform.pickFiles()` wrapping it in a `try/catch` with `ScaffoldMessenger.of(context).showSnackBar` on error (lines 58-74).

## 4. Assets & Animations
- **Hidden Assets:** There are NO bundled assets, SVGs, or custom animations in this project. The app is highly functional, relying entirely on Material/Flex components and font icons (`lucide_icons`).

## Conclusion
The undocumented elements primarily revolve around **imperative UI triggers** (`showModalBottomSheet`, `showDialog`, `setState`). Stitch must be able to wire buttons to these imperative Flutter functions.
