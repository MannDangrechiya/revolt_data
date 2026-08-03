# 18 - UI Safety Checklist

This checklist categorizes every Dart file in the project into strict safety tiers. Stitch automated systems or developers must respect these boundaries.

## Categorization Key
- 🟢 **SAFE FOR STITCH:** Pure UI. Can be rewritten freely.
- 🟡 **SAFE AFTER REVIEW:** UI that contains hooks or parameters. Redesign is fine, but the data binding must be preserved exactly.
- 🟠 **LOGIC + UI MIXED:** `StatefulWidget`s mixing local state/callbacks with UI. Needs extreme care.
- 🔴 **DO NOT TOUCH:** Pure domain, data, or application logic.
- 🚨 **CRITICAL / HIGH RISK:** Core entry points and system configurations.

## `lib/app/`
- `view/app_shell.dart` -> 🟡 SAFE AFTER REVIEW (Must maintain `navigationShell` methods).

## `lib/core/`
- `database/*` -> 🔴 DO NOT TOUCH
- `router.dart` -> 🚨 CRITICAL (Do not break GoRouter paths)
- `theme/*` -> 🟢 SAFE FOR STITCH
- `widgets/*` -> 🟢 SAFE FOR STITCH

## `lib/features/`
### Rides
- `domain/*`, `data/*` -> 🔴 DO NOT TOUCH
- `presentation/rides_screen.dart` -> 🟡 SAFE AFTER REVIEW
- `presentation/ride_details_screen.dart` -> 🟢 SAFE FOR STITCH
- `presentation/ride_entry_form_screen.dart` -> 🟡 SAFE AFTER REVIEW (Heavy Hook usage)

### Charging
- `domain/*`, `data/*` -> 🔴 DO NOT TOUCH
- `presentation/charging_screen.dart` -> 🟡 SAFE AFTER REVIEW
- `presentation/charge_details_screen.dart` -> 🟢 SAFE FOR STITCH
- `presentation/charge_entry_form_screen.dart` -> 🟡 SAFE AFTER REVIEW 

### Dashboard, Analytics, Bikes, Expenses, Maintenance
- `presentation/*_screen.dart` -> 🟡 SAFE AFTER REVIEW (Hooks present)
- `presentation/widgets/*` -> 🟢 SAFE FOR STITCH

### Documents & Reminders (The Outliers)
- `documents/presentation/document_add_screen.dart` -> 🟠 LOGIC + UI MIXED (Uses `setState`, `FilePicker`)
- `documents/presentation/documents_screen.dart` -> 🟠 LOGIC + UI MIXED 
- `reminders/presentation/reminder_add_edit_screen.dart` -> 🟠 LOGIC + UI MIXED 
- `reminders/presentation/reminders_screen.dart` -> 🟠 LOGIC + UI MIXED 
- `reports/presentation/reports_screen.dart` -> 🟠 LOGIC + UI MIXED 

## `lib/shared/ui/`
- All files (e.g., `volt_card.dart`, `volt_fab.dart`) -> 🟢 SAFE FOR STITCH

## `lib/`
- `main.dart` -> 🚨 HIGH RISK
- `app.dart` -> 🚨 HIGH RISK
