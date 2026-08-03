# 07 - Data Models

This document outlines the core domain entities. These models are defined using `freezed` (for immutable data classes) and `drift` (for the database schema). The UI layer will receive instances of these models via Riverpod providers.

## 1. Ride (`features/rides/domain/ride.dart`)
Represents a logged bike trip.
- **Fields:**
  - `id` (String / UUID, Required)
  - `date` (DateTime, Required)
  - `distanceKm` (double, Required)
  - `durationMinutes` (int, Required)
  - `batteryUsedPercent` (int, Nullable)
  - `notes` (String, Nullable)
- **Relationships:** Belongs to a Bike (implied if single-bike app).

## 2. ChargeLog (`features/charging/domain/charge_log.dart`)
Represents a battery charging session.
- **Fields:**
  - `id` (String, Required)
  - `date` (DateTime, Required)
  - `startPercentage` (int, Required)
  - `endPercentage` (int, Required)
  - `cost` (double, Nullable) - Electricity cost.
  - `location` (String, Nullable)
- **Computed (in UI/Logic):** `energyAdded = endPercentage - startPercentage`.

## 3. Expense (`features/expenses/domain/expense.dart`)
Represents money spent on the bike (e.g., insurance, accessories).
- **Fields:**
  - `id` (String, Required)
  - `date` (DateTime, Required)
  - `amount` (double, Required)
  - `category` (Enum: Insurance, Accessory, Fine, Other, Required)
  - `description` (String, Nullable)

## 4. MaintenanceLog (`features/maintenance/domain/maintenance_log.dart`)
Represents service or repairs done on the bike.
- **Fields:**
  - `id` (String, Required)
  - `date` (DateTime, Required)
  - `odometerReading` (int, Required)
  - `serviceType` (String, Required)
  - `cost` (double, Required)
  - `mechanicName` (String, Nullable)

## 5. Reminder (`features/reminders/domain/reminder.dart`)
Represents an upcoming task (e.g., "Renew Insurance").
- **Fields:**
  - `id` (String, Required)
  - `title` (String, Required)
  - `dueDate` (DateTime, Required)
  - `isCompleted` (bool, Required, Default: false)
  - `notifyMe` (bool, Required)

## 6. Document (`features/documents/domain/document.dart`)
Represents a digital scan/photo of paperwork.
- **Fields:**
  - `id` (String, Required)
  - `title` (String, Required)
  - `filePath` (String, Required) - Local path to the file.
  - `type` (Enum: PDF, Image, Required)
  - `addedDate` (DateTime, Required)

## Serialization & Deserialization
Because the app uses `freezed` and `json_serializable`, all models possess `.fromJson()` and `.toJson()` methods. However, primarily they are converted to/from Drift companion classes by the Data Layer before hitting the UI.

**Rule:** UI components should purely read these Freezed classes. Never attempt to mutate a model directly in the UI. Always call the corresponding Riverpod `Provider.notifier.updateXXX()` method.
