# 06 - API Documentation

## Overview
This application is a **100% Local-First** application. It does not communicate with external REST APIs, GraphQL endpoints, or Firebase Cloud Firestore for its core business logic. 

Therefore, traditional HTTP API documentation (Endpoints, Headers, JWTs) does not apply. 

## Internal "API" (Local Database Layer)
Instead of HTTP requests, the application's "API" is its local SQLite database managed by **Drift**. 
The UI layer NEVER calls the database directly. It calls the Riverpod Providers, which in turn call the Data Repositories/DAOs.

### 1. Rides "API"
- **Fetch All:** `SELECT * FROM rides ORDER BY date DESC` (Mapped through `ridesProvider`).
- **Insert:** `INSERT INTO rides (distance, duration, date, ...) VALUES (...)`
- **Delete:** `DELETE FROM rides WHERE id = ?`

### 2. Charging "API"
- **Fetch All:** `SELECT * FROM charge_logs ORDER BY date DESC`
- **Insert:** `INSERT INTO charge_logs (cost, battery_added, date, ...) VALUES (...)`

### 3. Analytics "API" (Computed Data)
- The analytics screens rely on aggressive local data aggregation.
- The Repositories perform SQL aggregations (e.g., `SUM(cost)`, `AVG(efficiency)`) locally.

### 4. Third-Party Integrations (Non-HTTP)
While there are no REST APIs, the app interacts with system APIs:
- **Share/Export:** `share_plus` interacts with the OS share sheet to export `.csv` or `.pdf` files.
- **File System:** `path_provider` interacts with the OS file system to save reports.
- **Notifications:** `flutter_local_notifications` schedules local OS-level alarms/reminders.

## Error Handling & Loading States
Because the app relies on a local SQLite database, "API" calls (DB queries) are nearly instantaneous. However, Riverpod still wraps these in `AsyncValue` to handle potential disk I/O latency.
- **Loading:** Always handled by `AsyncValue.loading`.
- **Error:** Handled by `AsyncValue.error` (usually disk full, or corrupted SQLite file).

## Retries and Caching
- **Caching:** Not applicable. The local database IS the cache and the source of truth.
- **Retries:** Not applicable. If a local DB write fails, it is a hard device error.
