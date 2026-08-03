# 02 - Application Flow

## 1. App Startup & Initialization
- **Entry Point:** `main.dart` -> `main()` function.
- **Initialization Sequence:**
  1. `WidgetsFlutterBinding.ensureInitialized()` is called.
  2. Device orientation is locked to portrait using `SystemChrome.setPreferredOrientations`.
  3. System UI (status bar) is made transparent with dark icons.
  4. Local Notifications (`FlutterLocalNotificationsPlugin`) are initialized for iOS/Android.
  5. The root widget `AppWidget` is launched, wrapped in a `ProviderScope` (Riverpod).
- **Graceful Failure:** If any initialization steps fail, the error is logged, and the app still attempts to run the `AppWidget` in an error-resilient state.

## 2. Global Services & Providers (Riverpod)
- Upon launching `AppWidget`, global Riverpod providers begin to load lazily as they are accessed.
- **Database Initialization:** The local SQLite database (via Drift) is initialized the first time a data provider requests it. There is no splash screen blocking startup for DB sync.

## 3. Navigation & Routing (GoRouter)
- **Root Router:** `AppWidget` uses `MaterialApp.router` powered by `GoRouter`.
- **Initial Route:** The app starts at `/` (Dashboard).
- **App Shell (Bottom Navigation):** The primary view is wrapped in an `AppShell` (a `StatefulShellRoute`). This persistent shell provides bottom navigation and maintains the state of each tab separately:
  1. **Dashboard** (`/`)
  2. **Rides** (`/rides`)
  3. **Charging** (`/charging`)
  4. **Analytics** (`/analytics`)

## 4. Offline Handling & Connectivity
- The application is fundamentally a **Local-First / Offline-First** application.
- There is no Firebase or remote Auth block.
- **Offline Banner:** The `AppShell` includes an `OfflineBanner` widget which listens to device connectivity (`connectivity_plus`). If the user goes offline, a banner appears reading "You are offline. Changes are saved locally."
- Data operations proceed normally offline by interacting directly with the local Drift database. 

## 5. Session & Authentication
- **Authentication:** No explicit sign-in/sign-out flow exists in the traditional sense (no Firebase Auth).
- **Profile:** User identity/bike profiles are stored locally in the database.
- **Permissions:** 
  - Local Notifications permission is requested.
  - File reading/writing permission (for exports/imports) may be requested dynamically by `file_picker`.
  - Camera/Gallery permission via `image_picker`.

## 6. Deep Links & Error Handling
- **Deep Links:** Handled natively by GoRouter, mostly for internal page-to-page jumps (e.g., `/rides/:id`).
- **Error Handling:** General exceptions in `main()` are caught and logged. Specific view-level errors are handled by custom `ErrorWidget` and Riverpod `AsyncValue.error` states.

## 7. Typical User Flow (Example)
1. User opens the app and lands on the **Dashboard** (`/`).
2. User taps the floating FAB or navigates to **Rides** (`/rides`) to log a new trip.
3. Form (`/rides/add`) is filled out.
4. Data is validated and submitted via the `RidesProvider`.
5. The local Drift DB is updated.
6. The `RidesScreen` automatically refreshes due to Riverpod state observation.

## 8. Background Processes & Lifecycle
- `workmanager` is defined in `pubspec.yaml` but is not heavily utilized or blocking the main isolate on startup.
- Lifecycle is standard Flutter lifecycle. State is preserved across tabs using `StatefulShellBranch`.
