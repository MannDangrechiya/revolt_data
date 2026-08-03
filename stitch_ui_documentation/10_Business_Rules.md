# 10 - Business Rules

This document outlines the core domain logic and business rules of the electric bike logbook application. 

**CRITICAL:** Under NO circumstances should these rules be modified during the UI redesign.

## 1. Battery & Range Calculations
- **Energy Added Rule:** When a user logs a charging session, the energy added to the battery is strictly calculated as `endPercentage - startPercentage`.
- **Cost Efficiency:** Electricity cost per percent of battery is `Total Cost / Energy Added`.
- **Ride Efficiency:** For a logged ride, the efficiency is calculated using the distance traveled and the battery percentage consumed. (Often converted to Wh/km based on the bike's total battery capacity).
- **Estimated Range:** Extrapolated dynamically based on recent rides' average efficiency multiplied by the current battery percentage.

## 2. Odometer & Maintenance Tracking
- **Sequential Odometer:** Maintenance logs and rides inherently increase the virtual odometer.
- **Service Reminders:** If a maintenance schedule is set (e.g., "Service every 3000 km"), a background process or dashboard check evaluates `Current Odometer >= Last Service Odometer + 3000`.
- **Validation:** You cannot log a ride with a negative distance, and you cannot log a charge where `startPercentage > endPercentage`.

## 3. Expense Categorization
- Expenses are strictly categorized (Insurance, Accessories, Service, Charging).
- **Dashboard Aggregation:** The Dashboard aggregates total spending by summing across these categories for the current month.

## 4. Offline-First Syncing
- All data modifications (Create, Update, Delete) MUST happen synchronously against the local Drift SQLite database.
- The UI MUST reflect changes immediately via Riverpod state updates (`AsyncValue.data`).
- There is no "pull to refresh" to fetch from a server; "pull to refresh" might only trigger a re-query of the local database if necessary, but Riverpod watchers should handle this automatically.

## 5. Exporting & Reporting
- When a user requests an export (CSV/PDF), the application must format the dates in ISO8601 or the local device format without shifting timezones.
- The exported file is generated in the device's temporary directory and then handed off to the OS via `share_plus`.

## Stitch Constraint
The UI replacement must only act as a "dumb terminal" that calls the `Notifier` methods and displays the resulting `AsyncValue` data. All calculations (efficiency, sums, sorting) occur in the data/domain layer and must not be replicated or altered in the widget layer.
