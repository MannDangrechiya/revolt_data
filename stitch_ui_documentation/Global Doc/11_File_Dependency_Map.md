# 11 - File Dependency Map

This document outlines the architectural boundaries of the application. It dictates which directories are safe to modify for UI replacement and which must remain untouched.

## 1. Safe for UI Replacement (UI Layer)
These files depend ON the Logic Layer, but nothing in the Logic Layer depends on them. They are 100% safe to replace.
- **`lib/shared/ui/`**: All custom components (`VoltCard`, `VoltFab`, etc.).
- **`lib/features/*/presentation/`**: All screens, bottom sheets, dialogs, and widgets specific to a feature.
- **`lib/app/view/`**: The `AppShell` and root UI wrappers.
- **`lib/core/theme/`**: Theme data, colors, fonts.

## 2. Mixed / Caution Required (Routing & Entry)
These files act as the glue between UI and Logic. They can be modified, but extreme care must be taken not to break the connections.
- **`lib/core/router.dart`**: You may change transitions or wrap paths in new UI shells, but DO NOT change the URL paths or remove expected `extra` parameters.
- **`lib/main.dart`**: You may modify system UI overlays, but do not touch the initialization sequence for Drift or Notifications.
- **`lib/app.dart`**: You can change the `MaterialApp.router` configuration (like title or theme), but keep the router delegate.

## 3. MUST NEVER BE TOUCHED (Logic & Data Layer)
These files form the core of the application. The UI depends on them. Modifying them risks breaking data persistence, API contracts, or business rules.
- **`lib/features/*/domain/`**: Freezed models (e.g., `ride.dart`).
- **`lib/features/*/data/`**: Riverpod providers and Data Access Objects (DAOs).
- **`lib/features/*/application/`**: Services (like PDF/CSV generation).
- **`lib/core/database/`**: Drift tables, migrations, and database singletons.
- **`lib/core/services/`**: Notification hooks, background syncs.

## Dependency Flow Diagram (Conceptual)
```text
[ Presentation Layer (Safe to Replace) ]
       |                  |
       v                  v
[ State Layer (Hooks/Riverpod) (NEVER TOUCH) ]
       |                  |
       v                  v
[ Domain Models ]    [ Data Layer (Drift) ] (NEVER TOUCH)
```
