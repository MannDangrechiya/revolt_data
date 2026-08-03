# 13 - Stitch UI Blueprint

This document acts as the creative and structural brief for building the new UI in Stitch. It defines the layout structures without using Flutter-specific code.

## Global Layout Principles
- **Scaffold:** Every main screen uses a top-level container (Scaffold) with a unified background color.
- **Safe Areas:** Content must respect device notches and bottom swipe indicators.
- **Responsive Behavior:** The app is strictly Mobile Portrait. Layouts should stretch vertically using Flex/ScrollViews and horizontally using 16px to 20px padding.

## 1. The App Shell (Navigation Bar)
- **Layout:** Fixed at the bottom of the screen.
- **Components:** 4 evenly spaced interactive zones (icons + optional labels).
- **Interactions:** Tap changes the active tab and switches the main content area without full page reload.
- **Design Note:** Use a subtle top border or shadow to separate it from the content. Apply a distinct active color (e.g., Deep Blue) to the selected tab icon.

## 2. Dashboard Screen
- **Hierarchy:** 
  1. **Header:** Welcome text and quick stats (Total Distance, Avg Efficiency).
  2. **Hero Section:** A prominent, visually striking card (or carousel) displaying the Bike Profile and current Battery Estimate.
  3. **Recent Activity List:** A vertical scrollable list of the 3 most recent rides and 1 most recent charge.
- **Interactions:** Tapping a recent activity item navigates to its detail view. Tapping the FAB navigates to the "Add Ride" form.

## 3. List Screens (Rides, Charging, Maintenance)
- **Layout:** Standard vertical `ListView`.
- **Spacing:** 12px vertical gap between items.
- **Components:**
  - **Item Card:** A container with a slight shadow, rounded corners.
  - **Left slot:** Icon representing the entity (e.g., a plug for charging, a bike for ride).
  - **Middle slot:** Main title (Date/Time) and subtitle (Distance or Cost).
  - **Right slot:** Trailing metric (e.g., +40%, -£5) or a chevron icon.
- **Empty State:** If the list is empty, display a large central illustration or icon with "No records found" and a prominent "Add New" button.

## 4. Forms (Add / Edit)
- **Layout:** Vertical scrollable form with a fixed submit button at the bottom.
- **Spacing:** 24px between input groups.
- **Components:**
  - **Labels:** Small, semi-bold text above inputs.
  - **Inputs:** Large, accessible text fields with clear borders and hint text.
  - **Date Pickers:** Read-only text fields that trigger a bottom sheet or native date dialog on tap.
- **Interactions:** Submit button should show a loading state (spinner) while saving to the local database, followed by a success Snackbar and a navigation Pop.

## 5. Analytics & Charts
- **Layout:** Tabbed or vertically stacked sections.
- **Components:**
  - **Bar/Line Charts:** High-contrast lines on dark/light backgrounds. Ensure labels (X/Y axis) are small but legible.
  - **Summary Cards:** 2x2 grid of square cards below charts showing "Max", "Min", "Average", "Total".

## Accessibility & Expected User Actions
- **Touch Targets:** All buttons and list items must be at least 48x48 logical pixels.
- **Contrast:** Ensure text on colored cards meets WCAG AA contrast standards.
- **Loading:** Use skeleton loaders for initial database queries instead of blocking spinners to make the app feel instantly responsive.
