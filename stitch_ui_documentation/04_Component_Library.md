# 04 - Component Library

This document outlines all reusable UI widgets found in `lib/shared/ui/`. These widgets must be conceptually preserved or perfectly replicated in the new Stitch UI layer.

## 1. VoltCard
- **Name:** `VoltCard` (`volt_card.dart`)
- **Purpose:** Base container for any list item, dashboard segment, or settings block.
- **Properties:** Usually takes `child`, `padding`, `onTap`, and optional `elevation`.
- **Reusability Score:** HIGH (Used globally across all features).

## 2. VoltFab
- **Name:** `VoltFab` (`volt_fab.dart`)
- **Purpose:** Custom Floating Action Button with specific brand styling or expansion logic.
- **Properties:** `icon`, `onPressed`, `label` (if extended).
- **Reusability Score:** HIGH.

## 3. StatTile
- **Name:** `StatTile` (`stat_tile.dart`)
- **Purpose:** Used on the dashboard and analytics screens to display a numerical statistic with an icon.
- **Properties:** `title`, `value`, `icon`, `trend` (up/down indicator), `color`.
- **Reusability Score:** HIGH.

## 4. SectionHeader
- **Name:** `SectionHeader` (`section_header.dart`)
- **Purpose:** Consistent typographic header for groups of content (e.g., "Recent Rides", "This Week").
- **Properties:** `title`, `actionText`, `onActionPressed`.
- **Reusability Score:** MEDIUM.

## 5. OfflineBanner
- **Name:** `OfflineBanner` (`offline_banner.dart`)
- **Purpose:** Displays a small red/orange banner when the device loses network connectivity.
- **Dependencies:** `connectivity_plus` stream.
- **State Management:** Listens to connectivity changes independently.
- **Reusability Score:** LOW (Used exactly once in the AppShell).

## 6. SkeletonLoader
- **Name:** `SkeletonLoader` (`skeleton_loader.dart`)
- **Purpose:** Displays a shimmer effect while waiting for Drift data (though Drift is fast, it's used for async states).
- **Dependencies:** `shimmer` package.
- **Reusability Score:** MEDIUM.

## 7. Empty State
- **Name:** `EmptyState` (`empty_state.dart`)
- **Purpose:** Shown when a list (e.g., Rides, Expenses) returns 0 results.
- **Properties:** `title`, `subtitle`, `icon`, `actionButton`.
- **Reusability Score:** HIGH.

## 8. Error Widget
- **Name:** `CustomErrorWidget` or `AppErrorWidget` (`error_widget.dart`)
- **Purpose:** Replaces the red screen of death for Flutter rendering errors or Riverpod `.error` states.
- **Properties:** `errorMessage`, `onRetry`.
- **Reusability Score:** MEDIUM.

## 9. VoltAppBar
- **Name:** `VoltAppBar` (`volt_app_bar.dart`)
- **Purpose:** Standardized `AppBar` that handles theme switching or consistent brand logos/titles.
- **Reusability Score:** HIGH.

## 10. VoltSnackbars
- **Name:** `VoltSnackbars` (`volt_snackbars.dart`)
- **Purpose:** Static helper methods to show success, error, and info snackbars with consistent styling.
- **Properties:** `message`, `context`, `type`.
- **Reusability Score:** HIGH.
