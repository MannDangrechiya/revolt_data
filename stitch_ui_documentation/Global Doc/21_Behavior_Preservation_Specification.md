# 21 - Behavior Preservation Specification

This specification acts as the definitive contract for preserving the app's exact runtime behaviors during the Stitch UI rebuild. The new UI layer must implement every behavior listed below precisely as described.

## 1. Global Behaviors

### 1.1 Offline Resilience (The Offline Banner)
- **Behavior:** The application must constantly monitor network connectivity. When the device loses internet access, a visible banner must appear indicating offline status (currently: "You are offline. Changes are saved locally.").
- **Preservation Contract:** The Stitch UI must retain a global listener (e.g., `Connectivity().onConnectivityChanged`) within the `AppShell` and conditionally render the offline indicator without blocking user interaction.

### 1.2 The "Immediate Save" Illusion (Drift / Riverpod)
- **Behavior:** Because data saves to a local SQLite database (Drift), there are rarely long network loading spinners. When a user submits a form (e.g., Adds a Ride), the screen pops immediately, and the list updates instantly.
- **Preservation Contract:** Stitch forms must immediately `context.pop()` upon successful provider mutation. Do not introduce artificial loading delays or mock network requests. 

## 2. Navigation & Routing Behaviors

### 2.1 Tab Persistence (AppShell)
- **Behavior:** The application uses `StatefulShellRoute`. Switching from the Dashboard tab to the Rides tab, and back to the Dashboard, must preserve the exact scroll position and state of the Dashboard.
- **Preservation Contract:** Do not replace `StatefulShellRoute` with standard push/pop navigation on the bottom bar. The Stitch layout must pass down the `navigationShell` and call `navigationShell.goBranch(index)`.

### 2.2 Modal Overlays (Bottom Sheets & Dialogs)
- **Behavior:** Many secondary actions (filters, document additions, maintenance details) are triggered via `showModalBottomSheet()` or `showDialog()`.
- **Preservation Contract:** Stitch must map these overlay interactions correctly. A button tap must trigger the modal logic, not navigate to a full-screen route, to preserve context.

## 3. Form & Input Behaviors

### 3.1 Hook Controller Preservation
- **Behavior:** Forms rely on `useTextEditingController` to bind text input to state.
- **Preservation Contract:** If Stitch generates new Input widgets, they MUST accept an external `TextEditingController`. Do not let Stitch generate its own internal state strings for inputs.

### 3.2 Form Validation Gatekeeping
- **Behavior:** Forms cannot be submitted unless `_formKey.currentState!.validate()` returns true.
- **Preservation Contract:** The "Submit/Save" button in the new UI must trigger this exact validation check before calling any Riverpod provider actions.

### 3.3 File System Hardware Hooks
- **Behavior:** Tapping "Add Document" triggers the OS native File Picker / Camera.
- **Preservation Contract:** This imperative logic (`FilePicker.platform.pickFiles`) must remain wired to the exact button `onPressed` callback in the new UI. 

## 4. State Rendering Behaviors (Riverpod AsyncValue)

### 4.1 Skeleton Loaders
- **Behavior:** When a provider is in `AsyncValue.loading`, the UI displays a shimmer/skeleton loader rather than a standard circular progress indicator.
- **Preservation Contract:** The Stitch UI must map its "Loading" state variants directly to `skeleton_loader.dart` (or its Stitch equivalent). Blank screens during loading are a violation.

### 4.2 Empty States
- **Behavior:** When `AsyncValue.data` returns an empty list `[]`, a specific "Empty State" widget is shown with an actionable "Add New" button.
- **Preservation Contract:** The Stitch UI must handle list lengths of `0` by rendering an explicit empty state. It must not just show a blank white scroll view.

### 4.3 Error States
- **Behavior:** If `AsyncValue.error` occurs (e.g., local database corruption), an Error Widget with a "Retry" button is displayed.
- **Preservation Contract:** Stitch must map `.error` states to a user-friendly error component.

## 5. Domain Logic Preservation

### 5.1 No UI-Side Math
- **Behavior:** Calculations like "Estimated Remaining Range" or "Battery Efficiency" are processed by the Data/Domain layer and served to the UI as raw strings or numbers.
- **Preservation Contract:** Stitch MUST NOT implement its own math or logic inside the UI files. It must act strictly as a "dumb terminal" displaying the data provided by Riverpod.
