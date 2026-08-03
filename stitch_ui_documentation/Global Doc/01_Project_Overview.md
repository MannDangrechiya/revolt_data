# 01 - Project Overview

## Application Summary
**Name:** Revolt Data / VoltLog Engineering
**Description:** Production-grade electric bike logbook app with premium features.
**Platform:** Flutter (Targeting iOS and Android, primarily Mobile).

## High-Level Architecture
The application follows a **Feature-Driven (Domain-Driven) Architecture**. 
Code is primarily split into:
- `lib/core/`: Application-wide configuration (Router, Theme, Database, Services, core widgets).
- `lib/features/`: Independent vertical slices of the application.
- `lib/shared/`: Reusable UI components and widgets.

## Core Technologies & Dependencies
The project relies on a modern, robust Flutter stack:
- **State Management & Dependency Injection:** `hooks_riverpod` (v3.3.1), `flutter_hooks`, `riverpod_annotation`
- **Routing:** `go_router` (v17.3.0) with nested navigation (`StatefulShellRoute`).
- **Local Database:** `drift` (v2.17.0) with `sqlite3_flutter_libs`.
- **UI & Theming:** `flex_color_scheme` (v8.4.0), `google_fonts`, `lucide_icons`.
- **Code Generation:** `freezed`, `json_serializable`, `drift_dev`, `riverpod_generator`.
- **Background Tasks:** `workmanager`.
- **Local Notifications:** `flutter_local_notifications`.
- **Charts:** `fl_chart`.
- **File & Media:** `image_picker`, `file_picker`, `flutter_pdfview`, `share_plus`.
- **Data Export:** `csv`, `syncfusion_flutter_xlsio`, `pdf`.

## UI Replacement Constraints
- **Goal:** Redesign the presentation layer using Stitch while keeping 100% of the business logic.
- **Rule of Thumb:**
  - `presentation/` folders within features can be modified/replaced.
  - `shared/ui/` components can be replaced.
  - `core/theme/` and `core/router.dart` can be adapted to support new UI needs.
  - **NEVER TOUCH:** `domain/`, `data/`, `application/`, providers, state controllers, database definitions, and logic handling routes/callbacks.

## Directory Structure Overview
```
lib/
├── app.dart                   # Root AppWidget (MaterialApp.router)
├── main.dart                  # Entry point, initialization (system UI, notifications)
├── core/
│   ├── database/              # Drift configurations
│   ├── router.dart            # GoRouter configurations
│   ├── services/              # Background/global services
│   ├── theme/                 # AppTheme (FlexColorScheme)
│   └── widgets/               # Core utility widgets
├── features/
│   ├── analytics/             # Battery, Efficiency, Statistics
│   ├── bikes/                 # Bike Profiles, Edit
│   ├── charging/              # Charge logs
│   ├── dashboard/             # Main summary/home screen
│   ├── documents/             # Docs management, preview
│   ├── expenses/              # Expense tracking
│   ├── maintenance/           # Maintenance logs
│   ├── reminders/             # Notifications and reminders
│   ├── reports/               # Exportable reports
│   ├── rides/                 # Ride logging
│   └── settings/              # User profile
└── shared/
    ├── components/            # Higher-order reusable parts
    └── ui/                    # Base UI library (VoltCard, VoltFab, etc.)
```
