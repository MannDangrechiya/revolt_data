import 'package:drift/drift.dart';

import '../../features/rides/domain/ride.dart';
import '../../features/charging/domain/charge_log.dart';
import '../../features/expenses/domain/expense.dart';
import '../../features/maintenance/domain/maintenance_log.dart';
import '../../features/reminders/domain/reminder.dart';
import '../../features/bikes/domain/bike.dart';
import '../../features/documents/domain/document.dart';
import 'app_database.dart';

extension RideDataMapper on RidesTableData {
  Ride toDomain() {
    return Ride(
      id: id,
      date: date,
      startOdometer: startOdometer,
      endOdometer: endOdometer,
      batteryBefore: batteryBefore,
      batteryAfter: batteryAfter,
      rideMode: rideMode,
      roadCondition: roadCondition,
      notes: notes,
      photoPaths: photoPaths,
    );
  }
}

extension RideMapper on Ride {
  RidesTableCompanion toCompanion() {
    return RidesTableCompanion(
      id: Value(id),
      date: Value(date),
      startOdometer: Value(startOdometer),
      endOdometer: Value(endOdometer),
      batteryBefore: Value(batteryBefore),
      batteryAfter: Value(batteryAfter),
      rideMode: Value(rideMode),
      roadCondition: Value(roadCondition),
      notes: Value(notes),
      photoPaths: Value(photoPaths),
    );
  }
}

extension ChargeLogDataMapper on ChargeLogsTableData {
  ChargeLog toDomain() {
    return ChargeLog(
      id: id,
      date: date,
      durationMinutes: durationMinutes,
      kwhAdded: kwhAdded,
      cost: cost,
      paymentMethod: paymentMethod,
      locationType: locationType,
      startBattery: startBattery,
      endBattery: endBattery,
      locationName: locationName,
      notes: notes,
    );
  }
}

extension ChargeLogMapper on ChargeLog {
  ChargeLogsTableCompanion toCompanion() {
    return ChargeLogsTableCompanion(
      id: Value(id),
      date: Value(date),
      durationMinutes: Value(durationMinutes),
      kwhAdded: Value(kwhAdded),
      cost: Value(cost),
      paymentMethod: Value(paymentMethod),
      locationType: Value(locationType),
      startBattery: Value(startBattery),
      endBattery: Value(endBattery),
      locationName: Value(locationName),
      notes: Value(notes),
    );
  }
}

extension ExpenseDataMapper on ExpensesTableData {
  Expense toDomain() {
    return Expense(
      id: id,
      date: date,
      category: category,
      amount: amount,
      notes: notes,
      receiptPhotoPath: receiptPhotoPath,
    );
  }
}

extension ExpenseMapper on Expense {
  ExpensesTableCompanion toCompanion() {
    return ExpensesTableCompanion(
      id: Value(id),
      date: Value(date),
      category: Value(category),
      amount: Value(amount),
      notes: Value(notes),
      receiptPhotoPath: Value(receiptPhotoPath),
    );
  }
}

extension MaintenanceLogDataMapper on MaintenanceLogsTableData {
  MaintenanceLog toDomain() {
    return MaintenanceLog(
      id: id,
      date: date,
      component: component,
      description: description,
      odometerReading: odometerReading,
      cost: cost,
    );
  }
}

extension MaintenanceLogMapper on MaintenanceLog {
  MaintenanceLogsTableCompanion toCompanion() {
    return MaintenanceLogsTableCompanion(
      id: Value(id),
      date: Value(date),
      component: Value(component),
      description: Value(description),
      odometerReading: Value(odometerReading),
      cost: Value(cost),
    );
  }
}

extension ReminderDataMapper on RemindersTableData {
  Reminder toDomain() {
    return Reminder(
      id: id,
      title: title,
      body: body,
      targetDate: targetDate,
      targetOdometer: targetOdometer,
      isCompleted: isCompleted,
      isNotified: isNotified,
      type: type,
      note: note,
      isActive: isActive,
      bikeId: bikeId,
    );
  }
}

extension ReminderMapper on Reminder {
  RemindersTableCompanion toCompanion() {
    return RemindersTableCompanion(
      id: Value(id),
      title: Value(title),
      body: Value(body),
      targetDate: Value(targetDate),
      targetOdometer: Value(targetOdometer),
      isCompleted: Value(isCompleted),
      isNotified: Value(isNotified),
      type: Value(type),
      note: Value(note),
      isActive: Value(isActive),
      bikeId: Value(bikeId),
    );
  }
}

extension BikeDataMapper on BikesTableData {
  Bike toDomain() {
    return Bike(
      id: id,
      name: name,
      brand: brand,
      model: model,
      variant: variant,
      color: color,
      registrationNumber: registrationNumber,
      vin: vin,
      motorNumber: motorNumber,
      purchaseDate: purchaseDate,
      purchasePrice: purchasePrice,
      dealer: dealer,
      insurance: insurance,
      warranty: warranty,
      batteryWarranty: batteryWarranty,
      batteryCapacity: batteryCapacity,
      motorPower: motorPower,
      claimedRange: claimedRange,
      topSpeed: topSpeed,
      tyreInfo: tyreInfo,
      customNotes: customNotes,
      photoPath: photoPath,
    );
  }
}

extension BikeMapper on Bike {
  BikesTableCompanion toCompanion() {
    return BikesTableCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      name: Value(name),
      brand: Value(brand),
      model: Value(model),
      variant: Value(variant),
      color: Value(color),
      registrationNumber: Value(registrationNumber),
      vin: Value(vin),
      motorNumber: Value(motorNumber),
      purchaseDate: Value(purchaseDate),
      purchasePrice: Value(purchasePrice),
      dealer: Value(dealer),
      insurance: Value(insurance),
      warranty: Value(warranty),
      batteryWarranty: Value(batteryWarranty),
      batteryCapacity: Value(batteryCapacity),
      motorPower: Value(motorPower),
      claimedRange: Value(claimedRange),
      topSpeed: Value(topSpeed),
      tyreInfo: Value(tyreInfo),
      customNotes: Value(customNotes),
      photoPath: Value(photoPath),
    );
  }
}

extension DocumentDataMapper on DocumentsTableData {
  Document toDomain() {
    return Document(
      id: id,
      name: name,
      category: category,
      filePath: filePath,
      uploadDate: uploadDate,
      notes: notes,
      bikeId: bikeId,
    );
  }
}

extension DocumentMapper on Document {
  DocumentsTableCompanion toCompanion() {
    return DocumentsTableCompanion(
      id: id != null ? Value(id!) : const Value.absent(),
      name: Value(name),
      category: Value(category),
      filePath: Value(filePath),
      uploadDate: Value(uploadDate),
      notes: Value(notes),
      bikeId: Value(bikeId),
    );
  }
}
