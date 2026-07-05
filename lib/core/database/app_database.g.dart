// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $RidesTableTable extends RidesTable
    with TableInfo<$RidesTableTable, RidesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RidesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _startOdometerMeta =
      const VerificationMeta('startOdometer');
  @override
  late final GeneratedColumn<double> startOdometer = GeneratedColumn<double>(
      'start_odometer', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _endOdometerMeta =
      const VerificationMeta('endOdometer');
  @override
  late final GeneratedColumn<double> endOdometer = GeneratedColumn<double>(
      'end_odometer', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _batteryBeforeMeta =
      const VerificationMeta('batteryBefore');
  @override
  late final GeneratedColumn<int> batteryBefore = GeneratedColumn<int>(
      'battery_before', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _batteryAfterMeta =
      const VerificationMeta('batteryAfter');
  @override
  late final GeneratedColumn<int> batteryAfter = GeneratedColumn<int>(
      'battery_after', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<RideMode, int> rideMode =
      GeneratedColumn<int>('ride_mode', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<RideMode>($RidesTableTable.$converterrideMode);
  @override
  late final GeneratedColumnWithTypeConverter<RoadCondition, int>
      roadCondition = GeneratedColumn<int>('road_condition', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<RoadCondition>(
              $RidesTableTable.$converterroadCondition);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String> photoPaths =
      GeneratedColumn<String>('photo_paths', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue: const Constant(''))
          .withConverter<List<String>>($RidesTableTable.$converterphotoPaths);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        date,
        startOdometer,
        endOdometer,
        batteryBefore,
        batteryAfter,
        rideMode,
        roadCondition,
        notes,
        photoPaths
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rides_table';
  @override
  VerificationContext validateIntegrity(Insertable<RidesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('start_odometer')) {
      context.handle(
          _startOdometerMeta,
          startOdometer.isAcceptableOrUnknown(
              data['start_odometer']!, _startOdometerMeta));
    } else if (isInserting) {
      context.missing(_startOdometerMeta);
    }
    if (data.containsKey('end_odometer')) {
      context.handle(
          _endOdometerMeta,
          endOdometer.isAcceptableOrUnknown(
              data['end_odometer']!, _endOdometerMeta));
    } else if (isInserting) {
      context.missing(_endOdometerMeta);
    }
    if (data.containsKey('battery_before')) {
      context.handle(
          _batteryBeforeMeta,
          batteryBefore.isAcceptableOrUnknown(
              data['battery_before']!, _batteryBeforeMeta));
    } else if (isInserting) {
      context.missing(_batteryBeforeMeta);
    }
    if (data.containsKey('battery_after')) {
      context.handle(
          _batteryAfterMeta,
          batteryAfter.isAcceptableOrUnknown(
              data['battery_after']!, _batteryAfterMeta));
    } else if (isInserting) {
      context.missing(_batteryAfterMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RidesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RidesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      startOdometer: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}start_odometer'])!,
      endOdometer: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}end_odometer'])!,
      batteryBefore: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}battery_before'])!,
      batteryAfter: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}battery_after'])!,
      rideMode: $RidesTableTable.$converterrideMode.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ride_mode'])!),
      roadCondition: $RidesTableTable.$converterroadCondition.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.int, data['${effectivePrefix}road_condition'])!),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      photoPaths: $RidesTableTable.$converterphotoPaths.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}photo_paths'])!),
    );
  }

  @override
  $RidesTableTable createAlias(String alias) {
    return $RidesTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<RideMode, int, int> $converterrideMode =
      const EnumIndexConverter<RideMode>(RideMode.values);
  static JsonTypeConverter2<RoadCondition, int, int> $converterroadCondition =
      const EnumIndexConverter<RoadCondition>(RoadCondition.values);
  static TypeConverter<List<String>, String> $converterphotoPaths =
      const StringListConverter();
}

class RidesTableData extends DataClass implements Insertable<RidesTableData> {
  final String id;
  final DateTime date;
  final double startOdometer;
  final double endOdometer;
  final int batteryBefore;
  final int batteryAfter;
  final RideMode rideMode;
  final RoadCondition roadCondition;
  final String? notes;
  final List<String> photoPaths;
  const RidesTableData(
      {required this.id,
      required this.date,
      required this.startOdometer,
      required this.endOdometer,
      required this.batteryBefore,
      required this.batteryAfter,
      required this.rideMode,
      required this.roadCondition,
      this.notes,
      required this.photoPaths});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<DateTime>(date);
    map['start_odometer'] = Variable<double>(startOdometer);
    map['end_odometer'] = Variable<double>(endOdometer);
    map['battery_before'] = Variable<int>(batteryBefore);
    map['battery_after'] = Variable<int>(batteryAfter);
    {
      map['ride_mode'] =
          Variable<int>($RidesTableTable.$converterrideMode.toSql(rideMode));
    }
    {
      map['road_condition'] = Variable<int>(
          $RidesTableTable.$converterroadCondition.toSql(roadCondition));
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    {
      map['photo_paths'] = Variable<String>(
          $RidesTableTable.$converterphotoPaths.toSql(photoPaths));
    }
    return map;
  }

  RidesTableCompanion toCompanion(bool nullToAbsent) {
    return RidesTableCompanion(
      id: Value(id),
      date: Value(date),
      startOdometer: Value(startOdometer),
      endOdometer: Value(endOdometer),
      batteryBefore: Value(batteryBefore),
      batteryAfter: Value(batteryAfter),
      rideMode: Value(rideMode),
      roadCondition: Value(roadCondition),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      photoPaths: Value(photoPaths),
    );
  }

  factory RidesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RidesTableData(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      startOdometer: serializer.fromJson<double>(json['startOdometer']),
      endOdometer: serializer.fromJson<double>(json['endOdometer']),
      batteryBefore: serializer.fromJson<int>(json['batteryBefore']),
      batteryAfter: serializer.fromJson<int>(json['batteryAfter']),
      rideMode: $RidesTableTable.$converterrideMode
          .fromJson(serializer.fromJson<int>(json['rideMode'])),
      roadCondition: $RidesTableTable.$converterroadCondition
          .fromJson(serializer.fromJson<int>(json['roadCondition'])),
      notes: serializer.fromJson<String?>(json['notes']),
      photoPaths: serializer.fromJson<List<String>>(json['photoPaths']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<DateTime>(date),
      'startOdometer': serializer.toJson<double>(startOdometer),
      'endOdometer': serializer.toJson<double>(endOdometer),
      'batteryBefore': serializer.toJson<int>(batteryBefore),
      'batteryAfter': serializer.toJson<int>(batteryAfter),
      'rideMode': serializer
          .toJson<int>($RidesTableTable.$converterrideMode.toJson(rideMode)),
      'roadCondition': serializer.toJson<int>(
          $RidesTableTable.$converterroadCondition.toJson(roadCondition)),
      'notes': serializer.toJson<String?>(notes),
      'photoPaths': serializer.toJson<List<String>>(photoPaths),
    };
  }

  RidesTableData copyWith(
          {String? id,
          DateTime? date,
          double? startOdometer,
          double? endOdometer,
          int? batteryBefore,
          int? batteryAfter,
          RideMode? rideMode,
          RoadCondition? roadCondition,
          Value<String?> notes = const Value.absent(),
          List<String>? photoPaths}) =>
      RidesTableData(
        id: id ?? this.id,
        date: date ?? this.date,
        startOdometer: startOdometer ?? this.startOdometer,
        endOdometer: endOdometer ?? this.endOdometer,
        batteryBefore: batteryBefore ?? this.batteryBefore,
        batteryAfter: batteryAfter ?? this.batteryAfter,
        rideMode: rideMode ?? this.rideMode,
        roadCondition: roadCondition ?? this.roadCondition,
        notes: notes.present ? notes.value : this.notes,
        photoPaths: photoPaths ?? this.photoPaths,
      );
  RidesTableData copyWithCompanion(RidesTableCompanion data) {
    return RidesTableData(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      startOdometer: data.startOdometer.present
          ? data.startOdometer.value
          : this.startOdometer,
      endOdometer:
          data.endOdometer.present ? data.endOdometer.value : this.endOdometer,
      batteryBefore: data.batteryBefore.present
          ? data.batteryBefore.value
          : this.batteryBefore,
      batteryAfter: data.batteryAfter.present
          ? data.batteryAfter.value
          : this.batteryAfter,
      rideMode: data.rideMode.present ? data.rideMode.value : this.rideMode,
      roadCondition: data.roadCondition.present
          ? data.roadCondition.value
          : this.roadCondition,
      notes: data.notes.present ? data.notes.value : this.notes,
      photoPaths:
          data.photoPaths.present ? data.photoPaths.value : this.photoPaths,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RidesTableData(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('startOdometer: $startOdometer, ')
          ..write('endOdometer: $endOdometer, ')
          ..write('batteryBefore: $batteryBefore, ')
          ..write('batteryAfter: $batteryAfter, ')
          ..write('rideMode: $rideMode, ')
          ..write('roadCondition: $roadCondition, ')
          ..write('notes: $notes, ')
          ..write('photoPaths: $photoPaths')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, startOdometer, endOdometer,
      batteryBefore, batteryAfter, rideMode, roadCondition, notes, photoPaths);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RidesTableData &&
          other.id == this.id &&
          other.date == this.date &&
          other.startOdometer == this.startOdometer &&
          other.endOdometer == this.endOdometer &&
          other.batteryBefore == this.batteryBefore &&
          other.batteryAfter == this.batteryAfter &&
          other.rideMode == this.rideMode &&
          other.roadCondition == this.roadCondition &&
          other.notes == this.notes &&
          other.photoPaths == this.photoPaths);
}

class RidesTableCompanion extends UpdateCompanion<RidesTableData> {
  final Value<String> id;
  final Value<DateTime> date;
  final Value<double> startOdometer;
  final Value<double> endOdometer;
  final Value<int> batteryBefore;
  final Value<int> batteryAfter;
  final Value<RideMode> rideMode;
  final Value<RoadCondition> roadCondition;
  final Value<String?> notes;
  final Value<List<String>> photoPaths;
  final Value<int> rowid;
  const RidesTableCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.startOdometer = const Value.absent(),
    this.endOdometer = const Value.absent(),
    this.batteryBefore = const Value.absent(),
    this.batteryAfter = const Value.absent(),
    this.rideMode = const Value.absent(),
    this.roadCondition = const Value.absent(),
    this.notes = const Value.absent(),
    this.photoPaths = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RidesTableCompanion.insert({
    required String id,
    required DateTime date,
    required double startOdometer,
    required double endOdometer,
    required int batteryBefore,
    required int batteryAfter,
    required RideMode rideMode,
    required RoadCondition roadCondition,
    this.notes = const Value.absent(),
    this.photoPaths = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        date = Value(date),
        startOdometer = Value(startOdometer),
        endOdometer = Value(endOdometer),
        batteryBefore = Value(batteryBefore),
        batteryAfter = Value(batteryAfter),
        rideMode = Value(rideMode),
        roadCondition = Value(roadCondition);
  static Insertable<RidesTableData> custom({
    Expression<String>? id,
    Expression<DateTime>? date,
    Expression<double>? startOdometer,
    Expression<double>? endOdometer,
    Expression<int>? batteryBefore,
    Expression<int>? batteryAfter,
    Expression<int>? rideMode,
    Expression<int>? roadCondition,
    Expression<String>? notes,
    Expression<String>? photoPaths,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (startOdometer != null) 'start_odometer': startOdometer,
      if (endOdometer != null) 'end_odometer': endOdometer,
      if (batteryBefore != null) 'battery_before': batteryBefore,
      if (batteryAfter != null) 'battery_after': batteryAfter,
      if (rideMode != null) 'ride_mode': rideMode,
      if (roadCondition != null) 'road_condition': roadCondition,
      if (notes != null) 'notes': notes,
      if (photoPaths != null) 'photo_paths': photoPaths,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RidesTableCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? date,
      Value<double>? startOdometer,
      Value<double>? endOdometer,
      Value<int>? batteryBefore,
      Value<int>? batteryAfter,
      Value<RideMode>? rideMode,
      Value<RoadCondition>? roadCondition,
      Value<String?>? notes,
      Value<List<String>>? photoPaths,
      Value<int>? rowid}) {
    return RidesTableCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      startOdometer: startOdometer ?? this.startOdometer,
      endOdometer: endOdometer ?? this.endOdometer,
      batteryBefore: batteryBefore ?? this.batteryBefore,
      batteryAfter: batteryAfter ?? this.batteryAfter,
      rideMode: rideMode ?? this.rideMode,
      roadCondition: roadCondition ?? this.roadCondition,
      notes: notes ?? this.notes,
      photoPaths: photoPaths ?? this.photoPaths,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (startOdometer.present) {
      map['start_odometer'] = Variable<double>(startOdometer.value);
    }
    if (endOdometer.present) {
      map['end_odometer'] = Variable<double>(endOdometer.value);
    }
    if (batteryBefore.present) {
      map['battery_before'] = Variable<int>(batteryBefore.value);
    }
    if (batteryAfter.present) {
      map['battery_after'] = Variable<int>(batteryAfter.value);
    }
    if (rideMode.present) {
      map['ride_mode'] = Variable<int>(
          $RidesTableTable.$converterrideMode.toSql(rideMode.value));
    }
    if (roadCondition.present) {
      map['road_condition'] = Variable<int>(
          $RidesTableTable.$converterroadCondition.toSql(roadCondition.value));
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (photoPaths.present) {
      map['photo_paths'] = Variable<String>(
          $RidesTableTable.$converterphotoPaths.toSql(photoPaths.value));
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RidesTableCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('startOdometer: $startOdometer, ')
          ..write('endOdometer: $endOdometer, ')
          ..write('batteryBefore: $batteryBefore, ')
          ..write('batteryAfter: $batteryAfter, ')
          ..write('rideMode: $rideMode, ')
          ..write('roadCondition: $roadCondition, ')
          ..write('notes: $notes, ')
          ..write('photoPaths: $photoPaths, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChargeLogsTableTable extends ChargeLogsTable
    with TableInfo<$ChargeLogsTableTable, ChargeLogsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChargeLogsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _durationMinutesMeta =
      const VerificationMeta('durationMinutes');
  @override
  late final GeneratedColumn<double> durationMinutes = GeneratedColumn<double>(
      'duration_minutes', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _kwhAddedMeta =
      const VerificationMeta('kwhAdded');
  @override
  late final GeneratedColumn<double> kwhAdded = GeneratedColumn<double>(
      'kwh_added', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _costMeta = const VerificationMeta('cost');
  @override
  late final GeneratedColumn<double> cost = GeneratedColumn<double>(
      'cost', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<PaymentMethod, int>
      paymentMethod = GeneratedColumn<int>('payment_method', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<PaymentMethod>(
              $ChargeLogsTableTable.$converterpaymentMethod);
  @override
  late final GeneratedColumnWithTypeConverter<LocationType, int> locationType =
      GeneratedColumn<int>('location_type', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<LocationType>(
              $ChargeLogsTableTable.$converterlocationType);
  static const VerificationMeta _startBatteryMeta =
      const VerificationMeta('startBattery');
  @override
  late final GeneratedColumn<int> startBattery = GeneratedColumn<int>(
      'start_battery', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _endBatteryMeta =
      const VerificationMeta('endBattery');
  @override
  late final GeneratedColumn<int> endBattery = GeneratedColumn<int>(
      'end_battery', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _locationNameMeta =
      const VerificationMeta('locationName');
  @override
  late final GeneratedColumn<String> locationName = GeneratedColumn<String>(
      'location_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        date,
        durationMinutes,
        kwhAdded,
        cost,
        paymentMethod,
        locationType,
        startBattery,
        endBattery,
        locationName,
        notes
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'charge_logs_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<ChargeLogsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('duration_minutes')) {
      context.handle(
          _durationMinutesMeta,
          durationMinutes.isAcceptableOrUnknown(
              data['duration_minutes']!, _durationMinutesMeta));
    } else if (isInserting) {
      context.missing(_durationMinutesMeta);
    }
    if (data.containsKey('kwh_added')) {
      context.handle(_kwhAddedMeta,
          kwhAdded.isAcceptableOrUnknown(data['kwh_added']!, _kwhAddedMeta));
    } else if (isInserting) {
      context.missing(_kwhAddedMeta);
    }
    if (data.containsKey('cost')) {
      context.handle(
          _costMeta, cost.isAcceptableOrUnknown(data['cost']!, _costMeta));
    } else if (isInserting) {
      context.missing(_costMeta);
    }
    if (data.containsKey('start_battery')) {
      context.handle(
          _startBatteryMeta,
          startBattery.isAcceptableOrUnknown(
              data['start_battery']!, _startBatteryMeta));
    } else if (isInserting) {
      context.missing(_startBatteryMeta);
    }
    if (data.containsKey('end_battery')) {
      context.handle(
          _endBatteryMeta,
          endBattery.isAcceptableOrUnknown(
              data['end_battery']!, _endBatteryMeta));
    } else if (isInserting) {
      context.missing(_endBatteryMeta);
    }
    if (data.containsKey('location_name')) {
      context.handle(
          _locationNameMeta,
          locationName.isAcceptableOrUnknown(
              data['location_name']!, _locationNameMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChargeLogsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChargeLogsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      durationMinutes: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}duration_minutes'])!,
      kwhAdded: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}kwh_added'])!,
      cost: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}cost'])!,
      paymentMethod: $ChargeLogsTableTable.$converterpaymentMethod.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.int, data['${effectivePrefix}payment_method'])!),
      locationType: $ChargeLogsTableTable.$converterlocationType.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.int, data['${effectivePrefix}location_type'])!),
      startBattery: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}start_battery'])!,
      endBattery: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}end_battery'])!,
      locationName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}location_name']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
    );
  }

  @override
  $ChargeLogsTableTable createAlias(String alias) {
    return $ChargeLogsTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<PaymentMethod, int, int> $converterpaymentMethod =
      const EnumIndexConverter<PaymentMethod>(PaymentMethod.values);
  static JsonTypeConverter2<LocationType, int, int> $converterlocationType =
      const EnumIndexConverter<LocationType>(LocationType.values);
}

class ChargeLogsTableData extends DataClass
    implements Insertable<ChargeLogsTableData> {
  final String id;
  final DateTime date;
  final double durationMinutes;
  final double kwhAdded;
  final double cost;
  final PaymentMethod paymentMethod;
  final LocationType locationType;
  final int startBattery;
  final int endBattery;
  final String? locationName;
  final String? notes;
  const ChargeLogsTableData(
      {required this.id,
      required this.date,
      required this.durationMinutes,
      required this.kwhAdded,
      required this.cost,
      required this.paymentMethod,
      required this.locationType,
      required this.startBattery,
      required this.endBattery,
      this.locationName,
      this.notes});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<DateTime>(date);
    map['duration_minutes'] = Variable<double>(durationMinutes);
    map['kwh_added'] = Variable<double>(kwhAdded);
    map['cost'] = Variable<double>(cost);
    {
      map['payment_method'] = Variable<int>(
          $ChargeLogsTableTable.$converterpaymentMethod.toSql(paymentMethod));
    }
    {
      map['location_type'] = Variable<int>(
          $ChargeLogsTableTable.$converterlocationType.toSql(locationType));
    }
    map['start_battery'] = Variable<int>(startBattery);
    map['end_battery'] = Variable<int>(endBattery);
    if (!nullToAbsent || locationName != null) {
      map['location_name'] = Variable<String>(locationName);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  ChargeLogsTableCompanion toCompanion(bool nullToAbsent) {
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
      locationName: locationName == null && nullToAbsent
          ? const Value.absent()
          : Value(locationName),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
    );
  }

  factory ChargeLogsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChargeLogsTableData(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      durationMinutes: serializer.fromJson<double>(json['durationMinutes']),
      kwhAdded: serializer.fromJson<double>(json['kwhAdded']),
      cost: serializer.fromJson<double>(json['cost']),
      paymentMethod: $ChargeLogsTableTable.$converterpaymentMethod
          .fromJson(serializer.fromJson<int>(json['paymentMethod'])),
      locationType: $ChargeLogsTableTable.$converterlocationType
          .fromJson(serializer.fromJson<int>(json['locationType'])),
      startBattery: serializer.fromJson<int>(json['startBattery']),
      endBattery: serializer.fromJson<int>(json['endBattery']),
      locationName: serializer.fromJson<String?>(json['locationName']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<DateTime>(date),
      'durationMinutes': serializer.toJson<double>(durationMinutes),
      'kwhAdded': serializer.toJson<double>(kwhAdded),
      'cost': serializer.toJson<double>(cost),
      'paymentMethod': serializer.toJson<int>(
          $ChargeLogsTableTable.$converterpaymentMethod.toJson(paymentMethod)),
      'locationType': serializer.toJson<int>(
          $ChargeLogsTableTable.$converterlocationType.toJson(locationType)),
      'startBattery': serializer.toJson<int>(startBattery),
      'endBattery': serializer.toJson<int>(endBattery),
      'locationName': serializer.toJson<String?>(locationName),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  ChargeLogsTableData copyWith(
          {String? id,
          DateTime? date,
          double? durationMinutes,
          double? kwhAdded,
          double? cost,
          PaymentMethod? paymentMethod,
          LocationType? locationType,
          int? startBattery,
          int? endBattery,
          Value<String?> locationName = const Value.absent(),
          Value<String?> notes = const Value.absent()}) =>
      ChargeLogsTableData(
        id: id ?? this.id,
        date: date ?? this.date,
        durationMinutes: durationMinutes ?? this.durationMinutes,
        kwhAdded: kwhAdded ?? this.kwhAdded,
        cost: cost ?? this.cost,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        locationType: locationType ?? this.locationType,
        startBattery: startBattery ?? this.startBattery,
        endBattery: endBattery ?? this.endBattery,
        locationName:
            locationName.present ? locationName.value : this.locationName,
        notes: notes.present ? notes.value : this.notes,
      );
  ChargeLogsTableData copyWithCompanion(ChargeLogsTableCompanion data) {
    return ChargeLogsTableData(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      durationMinutes: data.durationMinutes.present
          ? data.durationMinutes.value
          : this.durationMinutes,
      kwhAdded: data.kwhAdded.present ? data.kwhAdded.value : this.kwhAdded,
      cost: data.cost.present ? data.cost.value : this.cost,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      locationType: data.locationType.present
          ? data.locationType.value
          : this.locationType,
      startBattery: data.startBattery.present
          ? data.startBattery.value
          : this.startBattery,
      endBattery:
          data.endBattery.present ? data.endBattery.value : this.endBattery,
      locationName: data.locationName.present
          ? data.locationName.value
          : this.locationName,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChargeLogsTableData(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('kwhAdded: $kwhAdded, ')
          ..write('cost: $cost, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('locationType: $locationType, ')
          ..write('startBattery: $startBattery, ')
          ..write('endBattery: $endBattery, ')
          ..write('locationName: $locationName, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      date,
      durationMinutes,
      kwhAdded,
      cost,
      paymentMethod,
      locationType,
      startBattery,
      endBattery,
      locationName,
      notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChargeLogsTableData &&
          other.id == this.id &&
          other.date == this.date &&
          other.durationMinutes == this.durationMinutes &&
          other.kwhAdded == this.kwhAdded &&
          other.cost == this.cost &&
          other.paymentMethod == this.paymentMethod &&
          other.locationType == this.locationType &&
          other.startBattery == this.startBattery &&
          other.endBattery == this.endBattery &&
          other.locationName == this.locationName &&
          other.notes == this.notes);
}

class ChargeLogsTableCompanion extends UpdateCompanion<ChargeLogsTableData> {
  final Value<String> id;
  final Value<DateTime> date;
  final Value<double> durationMinutes;
  final Value<double> kwhAdded;
  final Value<double> cost;
  final Value<PaymentMethod> paymentMethod;
  final Value<LocationType> locationType;
  final Value<int> startBattery;
  final Value<int> endBattery;
  final Value<String?> locationName;
  final Value<String?> notes;
  final Value<int> rowid;
  const ChargeLogsTableCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.kwhAdded = const Value.absent(),
    this.cost = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.locationType = const Value.absent(),
    this.startBattery = const Value.absent(),
    this.endBattery = const Value.absent(),
    this.locationName = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChargeLogsTableCompanion.insert({
    required String id,
    required DateTime date,
    required double durationMinutes,
    required double kwhAdded,
    required double cost,
    required PaymentMethod paymentMethod,
    required LocationType locationType,
    required int startBattery,
    required int endBattery,
    this.locationName = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        date = Value(date),
        durationMinutes = Value(durationMinutes),
        kwhAdded = Value(kwhAdded),
        cost = Value(cost),
        paymentMethod = Value(paymentMethod),
        locationType = Value(locationType),
        startBattery = Value(startBattery),
        endBattery = Value(endBattery);
  static Insertable<ChargeLogsTableData> custom({
    Expression<String>? id,
    Expression<DateTime>? date,
    Expression<double>? durationMinutes,
    Expression<double>? kwhAdded,
    Expression<double>? cost,
    Expression<int>? paymentMethod,
    Expression<int>? locationType,
    Expression<int>? startBattery,
    Expression<int>? endBattery,
    Expression<String>? locationName,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (durationMinutes != null) 'duration_minutes': durationMinutes,
      if (kwhAdded != null) 'kwh_added': kwhAdded,
      if (cost != null) 'cost': cost,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (locationType != null) 'location_type': locationType,
      if (startBattery != null) 'start_battery': startBattery,
      if (endBattery != null) 'end_battery': endBattery,
      if (locationName != null) 'location_name': locationName,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChargeLogsTableCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? date,
      Value<double>? durationMinutes,
      Value<double>? kwhAdded,
      Value<double>? cost,
      Value<PaymentMethod>? paymentMethod,
      Value<LocationType>? locationType,
      Value<int>? startBattery,
      Value<int>? endBattery,
      Value<String?>? locationName,
      Value<String?>? notes,
      Value<int>? rowid}) {
    return ChargeLogsTableCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      kwhAdded: kwhAdded ?? this.kwhAdded,
      cost: cost ?? this.cost,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      locationType: locationType ?? this.locationType,
      startBattery: startBattery ?? this.startBattery,
      endBattery: endBattery ?? this.endBattery,
      locationName: locationName ?? this.locationName,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (durationMinutes.present) {
      map['duration_minutes'] = Variable<double>(durationMinutes.value);
    }
    if (kwhAdded.present) {
      map['kwh_added'] = Variable<double>(kwhAdded.value);
    }
    if (cost.present) {
      map['cost'] = Variable<double>(cost.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<int>($ChargeLogsTableTable
          .$converterpaymentMethod
          .toSql(paymentMethod.value));
    }
    if (locationType.present) {
      map['location_type'] = Variable<int>($ChargeLogsTableTable
          .$converterlocationType
          .toSql(locationType.value));
    }
    if (startBattery.present) {
      map['start_battery'] = Variable<int>(startBattery.value);
    }
    if (endBattery.present) {
      map['end_battery'] = Variable<int>(endBattery.value);
    }
    if (locationName.present) {
      map['location_name'] = Variable<String>(locationName.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChargeLogsTableCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('kwhAdded: $kwhAdded, ')
          ..write('cost: $cost, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('locationType: $locationType, ')
          ..write('startBattery: $startBattery, ')
          ..write('endBattery: $endBattery, ')
          ..write('locationName: $locationName, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExpensesTableTable extends ExpensesTable
    with TableInfo<$ExpensesTableTable, ExpensesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpensesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<ExpenseCategory, int> category =
      GeneratedColumn<int>('category', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<ExpenseCategory>(
              $ExpensesTableTable.$convertercategory);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _receiptPhotoPathMeta =
      const VerificationMeta('receiptPhotoPath');
  @override
  late final GeneratedColumn<String> receiptPhotoPath = GeneratedColumn<String>(
      'receipt_photo_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, date, category, amount, notes, receiptPhotoPath];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expenses_table';
  @override
  VerificationContext validateIntegrity(Insertable<ExpensesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('receipt_photo_path')) {
      context.handle(
          _receiptPhotoPathMeta,
          receiptPhotoPath.isAcceptableOrUnknown(
              data['receipt_photo_path']!, _receiptPhotoPathMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExpensesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExpensesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      category: $ExpensesTableTable.$convertercategory.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category'])!),
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      receiptPhotoPath: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}receipt_photo_path']),
    );
  }

  @override
  $ExpensesTableTable createAlias(String alias) {
    return $ExpensesTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ExpenseCategory, int, int> $convertercategory =
      const EnumIndexConverter<ExpenseCategory>(ExpenseCategory.values);
}

class ExpensesTableData extends DataClass
    implements Insertable<ExpensesTableData> {
  final String id;
  final DateTime date;
  final ExpenseCategory category;
  final double amount;
  final String? notes;
  final String? receiptPhotoPath;
  const ExpensesTableData(
      {required this.id,
      required this.date,
      required this.category,
      required this.amount,
      this.notes,
      this.receiptPhotoPath});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<DateTime>(date);
    {
      map['category'] =
          Variable<int>($ExpensesTableTable.$convertercategory.toSql(category));
    }
    map['amount'] = Variable<double>(amount);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || receiptPhotoPath != null) {
      map['receipt_photo_path'] = Variable<String>(receiptPhotoPath);
    }
    return map;
  }

  ExpensesTableCompanion toCompanion(bool nullToAbsent) {
    return ExpensesTableCompanion(
      id: Value(id),
      date: Value(date),
      category: Value(category),
      amount: Value(amount),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      receiptPhotoPath: receiptPhotoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(receiptPhotoPath),
    );
  }

  factory ExpensesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExpensesTableData(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      category: $ExpensesTableTable.$convertercategory
          .fromJson(serializer.fromJson<int>(json['category'])),
      amount: serializer.fromJson<double>(json['amount']),
      notes: serializer.fromJson<String?>(json['notes']),
      receiptPhotoPath: serializer.fromJson<String?>(json['receiptPhotoPath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<DateTime>(date),
      'category': serializer
          .toJson<int>($ExpensesTableTable.$convertercategory.toJson(category)),
      'amount': serializer.toJson<double>(amount),
      'notes': serializer.toJson<String?>(notes),
      'receiptPhotoPath': serializer.toJson<String?>(receiptPhotoPath),
    };
  }

  ExpensesTableData copyWith(
          {String? id,
          DateTime? date,
          ExpenseCategory? category,
          double? amount,
          Value<String?> notes = const Value.absent(),
          Value<String?> receiptPhotoPath = const Value.absent()}) =>
      ExpensesTableData(
        id: id ?? this.id,
        date: date ?? this.date,
        category: category ?? this.category,
        amount: amount ?? this.amount,
        notes: notes.present ? notes.value : this.notes,
        receiptPhotoPath: receiptPhotoPath.present
            ? receiptPhotoPath.value
            : this.receiptPhotoPath,
      );
  ExpensesTableData copyWithCompanion(ExpensesTableCompanion data) {
    return ExpensesTableData(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      category: data.category.present ? data.category.value : this.category,
      amount: data.amount.present ? data.amount.value : this.amount,
      notes: data.notes.present ? data.notes.value : this.notes,
      receiptPhotoPath: data.receiptPhotoPath.present
          ? data.receiptPhotoPath.value
          : this.receiptPhotoPath,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExpensesTableData(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('category: $category, ')
          ..write('amount: $amount, ')
          ..write('notes: $notes, ')
          ..write('receiptPhotoPath: $receiptPhotoPath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, date, category, amount, notes, receiptPhotoPath);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExpensesTableData &&
          other.id == this.id &&
          other.date == this.date &&
          other.category == this.category &&
          other.amount == this.amount &&
          other.notes == this.notes &&
          other.receiptPhotoPath == this.receiptPhotoPath);
}

class ExpensesTableCompanion extends UpdateCompanion<ExpensesTableData> {
  final Value<String> id;
  final Value<DateTime> date;
  final Value<ExpenseCategory> category;
  final Value<double> amount;
  final Value<String?> notes;
  final Value<String?> receiptPhotoPath;
  final Value<int> rowid;
  const ExpensesTableCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.category = const Value.absent(),
    this.amount = const Value.absent(),
    this.notes = const Value.absent(),
    this.receiptPhotoPath = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExpensesTableCompanion.insert({
    required String id,
    required DateTime date,
    required ExpenseCategory category,
    required double amount,
    this.notes = const Value.absent(),
    this.receiptPhotoPath = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        date = Value(date),
        category = Value(category),
        amount = Value(amount);
  static Insertable<ExpensesTableData> custom({
    Expression<String>? id,
    Expression<DateTime>? date,
    Expression<int>? category,
    Expression<double>? amount,
    Expression<String>? notes,
    Expression<String>? receiptPhotoPath,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (category != null) 'category': category,
      if (amount != null) 'amount': amount,
      if (notes != null) 'notes': notes,
      if (receiptPhotoPath != null) 'receipt_photo_path': receiptPhotoPath,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExpensesTableCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? date,
      Value<ExpenseCategory>? category,
      Value<double>? amount,
      Value<String?>? notes,
      Value<String?>? receiptPhotoPath,
      Value<int>? rowid}) {
    return ExpensesTableCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      notes: notes ?? this.notes,
      receiptPhotoPath: receiptPhotoPath ?? this.receiptPhotoPath,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (category.present) {
      map['category'] = Variable<int>(
          $ExpensesTableTable.$convertercategory.toSql(category.value));
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (receiptPhotoPath.present) {
      map['receipt_photo_path'] = Variable<String>(receiptPhotoPath.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpensesTableCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('category: $category, ')
          ..write('amount: $amount, ')
          ..write('notes: $notes, ')
          ..write('receiptPhotoPath: $receiptPhotoPath, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MaintenanceLogsTableTable extends MaintenanceLogsTable
    with TableInfo<$MaintenanceLogsTableTable, MaintenanceLogsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MaintenanceLogsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<MaintenanceComponent, int>
      component = GeneratedColumn<int>('component', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<MaintenanceComponent>(
              $MaintenanceLogsTableTable.$convertercomponent);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _odometerReadingMeta =
      const VerificationMeta('odometerReading');
  @override
  late final GeneratedColumn<double> odometerReading = GeneratedColumn<double>(
      'odometer_reading', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _costMeta = const VerificationMeta('cost');
  @override
  late final GeneratedColumn<double> cost = GeneratedColumn<double>(
      'cost', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, date, component, description, odometerReading, cost];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'maintenance_logs_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<MaintenanceLogsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('odometer_reading')) {
      context.handle(
          _odometerReadingMeta,
          odometerReading.isAcceptableOrUnknown(
              data['odometer_reading']!, _odometerReadingMeta));
    } else if (isInserting) {
      context.missing(_odometerReadingMeta);
    }
    if (data.containsKey('cost')) {
      context.handle(
          _costMeta, cost.isAcceptableOrUnknown(data['cost']!, _costMeta));
    } else if (isInserting) {
      context.missing(_costMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MaintenanceLogsTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MaintenanceLogsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      component: $MaintenanceLogsTableTable.$convertercomponent.fromSql(
          attachedDatabase.typeMapping
              .read(DriftSqlType.int, data['${effectivePrefix}component'])!),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      odometerReading: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}odometer_reading'])!,
      cost: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}cost'])!,
    );
  }

  @override
  $MaintenanceLogsTableTable createAlias(String alias) {
    return $MaintenanceLogsTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<MaintenanceComponent, int, int>
      $convertercomponent = const EnumIndexConverter<MaintenanceComponent>(
          MaintenanceComponent.values);
}

class MaintenanceLogsTableData extends DataClass
    implements Insertable<MaintenanceLogsTableData> {
  final String id;
  final DateTime date;
  final MaintenanceComponent component;
  final String description;
  final double odometerReading;
  final double cost;
  const MaintenanceLogsTableData(
      {required this.id,
      required this.date,
      required this.component,
      required this.description,
      required this.odometerReading,
      required this.cost});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<DateTime>(date);
    {
      map['component'] = Variable<int>(
          $MaintenanceLogsTableTable.$convertercomponent.toSql(component));
    }
    map['description'] = Variable<String>(description);
    map['odometer_reading'] = Variable<double>(odometerReading);
    map['cost'] = Variable<double>(cost);
    return map;
  }

  MaintenanceLogsTableCompanion toCompanion(bool nullToAbsent) {
    return MaintenanceLogsTableCompanion(
      id: Value(id),
      date: Value(date),
      component: Value(component),
      description: Value(description),
      odometerReading: Value(odometerReading),
      cost: Value(cost),
    );
  }

  factory MaintenanceLogsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MaintenanceLogsTableData(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      component: $MaintenanceLogsTableTable.$convertercomponent
          .fromJson(serializer.fromJson<int>(json['component'])),
      description: serializer.fromJson<String>(json['description']),
      odometerReading: serializer.fromJson<double>(json['odometerReading']),
      cost: serializer.fromJson<double>(json['cost']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<DateTime>(date),
      'component': serializer.toJson<int>(
          $MaintenanceLogsTableTable.$convertercomponent.toJson(component)),
      'description': serializer.toJson<String>(description),
      'odometerReading': serializer.toJson<double>(odometerReading),
      'cost': serializer.toJson<double>(cost),
    };
  }

  MaintenanceLogsTableData copyWith(
          {String? id,
          DateTime? date,
          MaintenanceComponent? component,
          String? description,
          double? odometerReading,
          double? cost}) =>
      MaintenanceLogsTableData(
        id: id ?? this.id,
        date: date ?? this.date,
        component: component ?? this.component,
        description: description ?? this.description,
        odometerReading: odometerReading ?? this.odometerReading,
        cost: cost ?? this.cost,
      );
  MaintenanceLogsTableData copyWithCompanion(
      MaintenanceLogsTableCompanion data) {
    return MaintenanceLogsTableData(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      component: data.component.present ? data.component.value : this.component,
      description:
          data.description.present ? data.description.value : this.description,
      odometerReading: data.odometerReading.present
          ? data.odometerReading.value
          : this.odometerReading,
      cost: data.cost.present ? data.cost.value : this.cost,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MaintenanceLogsTableData(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('component: $component, ')
          ..write('description: $description, ')
          ..write('odometerReading: $odometerReading, ')
          ..write('cost: $cost')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, date, component, description, odometerReading, cost);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MaintenanceLogsTableData &&
          other.id == this.id &&
          other.date == this.date &&
          other.component == this.component &&
          other.description == this.description &&
          other.odometerReading == this.odometerReading &&
          other.cost == this.cost);
}

class MaintenanceLogsTableCompanion
    extends UpdateCompanion<MaintenanceLogsTableData> {
  final Value<String> id;
  final Value<DateTime> date;
  final Value<MaintenanceComponent> component;
  final Value<String> description;
  final Value<double> odometerReading;
  final Value<double> cost;
  final Value<int> rowid;
  const MaintenanceLogsTableCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.component = const Value.absent(),
    this.description = const Value.absent(),
    this.odometerReading = const Value.absent(),
    this.cost = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MaintenanceLogsTableCompanion.insert({
    required String id,
    required DateTime date,
    required MaintenanceComponent component,
    required String description,
    required double odometerReading,
    required double cost,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        date = Value(date),
        component = Value(component),
        description = Value(description),
        odometerReading = Value(odometerReading),
        cost = Value(cost);
  static Insertable<MaintenanceLogsTableData> custom({
    Expression<String>? id,
    Expression<DateTime>? date,
    Expression<int>? component,
    Expression<String>? description,
    Expression<double>? odometerReading,
    Expression<double>? cost,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (component != null) 'component': component,
      if (description != null) 'description': description,
      if (odometerReading != null) 'odometer_reading': odometerReading,
      if (cost != null) 'cost': cost,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MaintenanceLogsTableCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? date,
      Value<MaintenanceComponent>? component,
      Value<String>? description,
      Value<double>? odometerReading,
      Value<double>? cost,
      Value<int>? rowid}) {
    return MaintenanceLogsTableCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      component: component ?? this.component,
      description: description ?? this.description,
      odometerReading: odometerReading ?? this.odometerReading,
      cost: cost ?? this.cost,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (component.present) {
      map['component'] = Variable<int>($MaintenanceLogsTableTable
          .$convertercomponent
          .toSql(component.value));
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (odometerReading.present) {
      map['odometer_reading'] = Variable<double>(odometerReading.value);
    }
    if (cost.present) {
      map['cost'] = Variable<double>(cost.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MaintenanceLogsTableCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('component: $component, ')
          ..write('description: $description, ')
          ..write('odometerReading: $odometerReading, ')
          ..write('cost: $cost, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RemindersTableTable extends RemindersTable
    with TableInfo<$RemindersTableTable, RemindersTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RemindersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
      'body', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _targetDateMeta =
      const VerificationMeta('targetDate');
  @override
  late final GeneratedColumn<DateTime> targetDate = GeneratedColumn<DateTime>(
      'target_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _targetOdometerMeta =
      const VerificationMeta('targetOdometer');
  @override
  late final GeneratedColumn<double> targetOdometer = GeneratedColumn<double>(
      'target_odometer', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _isCompletedMeta =
      const VerificationMeta('isCompleted');
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
      'is_completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_completed" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isNotifiedMeta =
      const VerificationMeta('isNotified');
  @override
  late final GeneratedColumn<bool> isNotified = GeneratedColumn<bool>(
      'is_notified', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_notified" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, body, targetDate, targetOdometer, isCompleted, isNotified];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reminders_table';
  @override
  VerificationContext validateIntegrity(Insertable<RemindersTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
          _bodyMeta, body.isAcceptableOrUnknown(data['body']!, _bodyMeta));
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('target_date')) {
      context.handle(
          _targetDateMeta,
          targetDate.isAcceptableOrUnknown(
              data['target_date']!, _targetDateMeta));
    }
    if (data.containsKey('target_odometer')) {
      context.handle(
          _targetOdometerMeta,
          targetOdometer.isAcceptableOrUnknown(
              data['target_odometer']!, _targetOdometerMeta));
    }
    if (data.containsKey('is_completed')) {
      context.handle(
          _isCompletedMeta,
          isCompleted.isAcceptableOrUnknown(
              data['is_completed']!, _isCompletedMeta));
    }
    if (data.containsKey('is_notified')) {
      context.handle(
          _isNotifiedMeta,
          isNotified.isAcceptableOrUnknown(
              data['is_notified']!, _isNotifiedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RemindersTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RemindersTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      body: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}body'])!,
      targetDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}target_date']),
      targetOdometer: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}target_odometer']),
      isCompleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_completed'])!,
      isNotified: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_notified'])!,
    );
  }

  @override
  $RemindersTableTable createAlias(String alias) {
    return $RemindersTableTable(attachedDatabase, alias);
  }
}

class RemindersTableData extends DataClass
    implements Insertable<RemindersTableData> {
  final String id;
  final String title;
  final String body;
  final DateTime? targetDate;
  final double? targetOdometer;
  final bool isCompleted;
  final bool isNotified;
  const RemindersTableData(
      {required this.id,
      required this.title,
      required this.body,
      this.targetDate,
      this.targetOdometer,
      required this.isCompleted,
      required this.isNotified});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['body'] = Variable<String>(body);
    if (!nullToAbsent || targetDate != null) {
      map['target_date'] = Variable<DateTime>(targetDate);
    }
    if (!nullToAbsent || targetOdometer != null) {
      map['target_odometer'] = Variable<double>(targetOdometer);
    }
    map['is_completed'] = Variable<bool>(isCompleted);
    map['is_notified'] = Variable<bool>(isNotified);
    return map;
  }

  RemindersTableCompanion toCompanion(bool nullToAbsent) {
    return RemindersTableCompanion(
      id: Value(id),
      title: Value(title),
      body: Value(body),
      targetDate: targetDate == null && nullToAbsent
          ? const Value.absent()
          : Value(targetDate),
      targetOdometer: targetOdometer == null && nullToAbsent
          ? const Value.absent()
          : Value(targetOdometer),
      isCompleted: Value(isCompleted),
      isNotified: Value(isNotified),
    );
  }

  factory RemindersTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RemindersTableData(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      body: serializer.fromJson<String>(json['body']),
      targetDate: serializer.fromJson<DateTime?>(json['targetDate']),
      targetOdometer: serializer.fromJson<double?>(json['targetOdometer']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      isNotified: serializer.fromJson<bool>(json['isNotified']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'body': serializer.toJson<String>(body),
      'targetDate': serializer.toJson<DateTime?>(targetDate),
      'targetOdometer': serializer.toJson<double?>(targetOdometer),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'isNotified': serializer.toJson<bool>(isNotified),
    };
  }

  RemindersTableData copyWith(
          {String? id,
          String? title,
          String? body,
          Value<DateTime?> targetDate = const Value.absent(),
          Value<double?> targetOdometer = const Value.absent(),
          bool? isCompleted,
          bool? isNotified}) =>
      RemindersTableData(
        id: id ?? this.id,
        title: title ?? this.title,
        body: body ?? this.body,
        targetDate: targetDate.present ? targetDate.value : this.targetDate,
        targetOdometer:
            targetOdometer.present ? targetOdometer.value : this.targetOdometer,
        isCompleted: isCompleted ?? this.isCompleted,
        isNotified: isNotified ?? this.isNotified,
      );
  RemindersTableData copyWithCompanion(RemindersTableCompanion data) {
    return RemindersTableData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      body: data.body.present ? data.body.value : this.body,
      targetDate:
          data.targetDate.present ? data.targetDate.value : this.targetDate,
      targetOdometer: data.targetOdometer.present
          ? data.targetOdometer.value
          : this.targetOdometer,
      isCompleted:
          data.isCompleted.present ? data.isCompleted.value : this.isCompleted,
      isNotified:
          data.isNotified.present ? data.isNotified.value : this.isNotified,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RemindersTableData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('targetDate: $targetDate, ')
          ..write('targetOdometer: $targetOdometer, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('isNotified: $isNotified')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, title, body, targetDate, targetOdometer, isCompleted, isNotified);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RemindersTableData &&
          other.id == this.id &&
          other.title == this.title &&
          other.body == this.body &&
          other.targetDate == this.targetDate &&
          other.targetOdometer == this.targetOdometer &&
          other.isCompleted == this.isCompleted &&
          other.isNotified == this.isNotified);
}

class RemindersTableCompanion extends UpdateCompanion<RemindersTableData> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> body;
  final Value<DateTime?> targetDate;
  final Value<double?> targetOdometer;
  final Value<bool> isCompleted;
  final Value<bool> isNotified;
  final Value<int> rowid;
  const RemindersTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.body = const Value.absent(),
    this.targetDate = const Value.absent(),
    this.targetOdometer = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.isNotified = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RemindersTableCompanion.insert({
    required String id,
    required String title,
    required String body,
    this.targetDate = const Value.absent(),
    this.targetOdometer = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.isNotified = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        body = Value(body);
  static Insertable<RemindersTableData> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? body,
    Expression<DateTime>? targetDate,
    Expression<double>? targetOdometer,
    Expression<bool>? isCompleted,
    Expression<bool>? isNotified,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (body != null) 'body': body,
      if (targetDate != null) 'target_date': targetDate,
      if (targetOdometer != null) 'target_odometer': targetOdometer,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (isNotified != null) 'is_notified': isNotified,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RemindersTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String>? body,
      Value<DateTime?>? targetDate,
      Value<double?>? targetOdometer,
      Value<bool>? isCompleted,
      Value<bool>? isNotified,
      Value<int>? rowid}) {
    return RemindersTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      targetDate: targetDate ?? this.targetDate,
      targetOdometer: targetOdometer ?? this.targetOdometer,
      isCompleted: isCompleted ?? this.isCompleted,
      isNotified: isNotified ?? this.isNotified,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (targetDate.present) {
      map['target_date'] = Variable<DateTime>(targetDate.value);
    }
    if (targetOdometer.present) {
      map['target_odometer'] = Variable<double>(targetOdometer.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (isNotified.present) {
      map['is_notified'] = Variable<bool>(isNotified.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RemindersTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('targetDate: $targetDate, ')
          ..write('targetOdometer: $targetOdometer, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('isNotified: $isNotified, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $RidesTableTable ridesTable = $RidesTableTable(this);
  late final $ChargeLogsTableTable chargeLogsTable =
      $ChargeLogsTableTable(this);
  late final $ExpensesTableTable expensesTable = $ExpensesTableTable(this);
  late final $MaintenanceLogsTableTable maintenanceLogsTable =
      $MaintenanceLogsTableTable(this);
  late final $RemindersTableTable remindersTable = $RemindersTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        ridesTable,
        chargeLogsTable,
        expensesTable,
        maintenanceLogsTable,
        remindersTable
      ];
}

typedef $$RidesTableTableCreateCompanionBuilder = RidesTableCompanion Function({
  required String id,
  required DateTime date,
  required double startOdometer,
  required double endOdometer,
  required int batteryBefore,
  required int batteryAfter,
  required RideMode rideMode,
  required RoadCondition roadCondition,
  Value<String?> notes,
  Value<List<String>> photoPaths,
  Value<int> rowid,
});
typedef $$RidesTableTableUpdateCompanionBuilder = RidesTableCompanion Function({
  Value<String> id,
  Value<DateTime> date,
  Value<double> startOdometer,
  Value<double> endOdometer,
  Value<int> batteryBefore,
  Value<int> batteryAfter,
  Value<RideMode> rideMode,
  Value<RoadCondition> roadCondition,
  Value<String?> notes,
  Value<List<String>> photoPaths,
  Value<int> rowid,
});

class $$RidesTableTableFilterComposer
    extends Composer<_$AppDatabase, $RidesTableTable> {
  $$RidesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get startOdometer => $composableBuilder(
      column: $table.startOdometer, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get endOdometer => $composableBuilder(
      column: $table.endOdometer, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get batteryBefore => $composableBuilder(
      column: $table.batteryBefore, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get batteryAfter => $composableBuilder(
      column: $table.batteryAfter, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<RideMode, RideMode, int> get rideMode =>
      $composableBuilder(
          column: $table.rideMode,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<RoadCondition, RoadCondition, int>
      get roadCondition => $composableBuilder(
          column: $table.roadCondition,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
      get photoPaths => $composableBuilder(
          column: $table.photoPaths,
          builder: (column) => ColumnWithTypeConverterFilters(column));
}

class $$RidesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $RidesTableTable> {
  $$RidesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get startOdometer => $composableBuilder(
      column: $table.startOdometer,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get endOdometer => $composableBuilder(
      column: $table.endOdometer, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get batteryBefore => $composableBuilder(
      column: $table.batteryBefore,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get batteryAfter => $composableBuilder(
      column: $table.batteryAfter,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get rideMode => $composableBuilder(
      column: $table.rideMode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get roadCondition => $composableBuilder(
      column: $table.roadCondition,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get photoPaths => $composableBuilder(
      column: $table.photoPaths, builder: (column) => ColumnOrderings(column));
}

class $$RidesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $RidesTableTable> {
  $$RidesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get startOdometer => $composableBuilder(
      column: $table.startOdometer, builder: (column) => column);

  GeneratedColumn<double> get endOdometer => $composableBuilder(
      column: $table.endOdometer, builder: (column) => column);

  GeneratedColumn<int> get batteryBefore => $composableBuilder(
      column: $table.batteryBefore, builder: (column) => column);

  GeneratedColumn<int> get batteryAfter => $composableBuilder(
      column: $table.batteryAfter, builder: (column) => column);

  GeneratedColumnWithTypeConverter<RideMode, int> get rideMode =>
      $composableBuilder(column: $table.rideMode, builder: (column) => column);

  GeneratedColumnWithTypeConverter<RoadCondition, int> get roadCondition =>
      $composableBuilder(
          column: $table.roadCondition, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get photoPaths =>
      $composableBuilder(
          column: $table.photoPaths, builder: (column) => column);
}

class $$RidesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RidesTableTable,
    RidesTableData,
    $$RidesTableTableFilterComposer,
    $$RidesTableTableOrderingComposer,
    $$RidesTableTableAnnotationComposer,
    $$RidesTableTableCreateCompanionBuilder,
    $$RidesTableTableUpdateCompanionBuilder,
    (
      RidesTableData,
      BaseReferences<_$AppDatabase, $RidesTableTable, RidesTableData>
    ),
    RidesTableData,
    PrefetchHooks Function()> {
  $$RidesTableTableTableManager(_$AppDatabase db, $RidesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RidesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RidesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RidesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<double> startOdometer = const Value.absent(),
            Value<double> endOdometer = const Value.absent(),
            Value<int> batteryBefore = const Value.absent(),
            Value<int> batteryAfter = const Value.absent(),
            Value<RideMode> rideMode = const Value.absent(),
            Value<RoadCondition> roadCondition = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<List<String>> photoPaths = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RidesTableCompanion(
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
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required DateTime date,
            required double startOdometer,
            required double endOdometer,
            required int batteryBefore,
            required int batteryAfter,
            required RideMode rideMode,
            required RoadCondition roadCondition,
            Value<String?> notes = const Value.absent(),
            Value<List<String>> photoPaths = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RidesTableCompanion.insert(
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
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$RidesTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RidesTableTable,
    RidesTableData,
    $$RidesTableTableFilterComposer,
    $$RidesTableTableOrderingComposer,
    $$RidesTableTableAnnotationComposer,
    $$RidesTableTableCreateCompanionBuilder,
    $$RidesTableTableUpdateCompanionBuilder,
    (
      RidesTableData,
      BaseReferences<_$AppDatabase, $RidesTableTable, RidesTableData>
    ),
    RidesTableData,
    PrefetchHooks Function()>;
typedef $$ChargeLogsTableTableCreateCompanionBuilder = ChargeLogsTableCompanion
    Function({
  required String id,
  required DateTime date,
  required double durationMinutes,
  required double kwhAdded,
  required double cost,
  required PaymentMethod paymentMethod,
  required LocationType locationType,
  required int startBattery,
  required int endBattery,
  Value<String?> locationName,
  Value<String?> notes,
  Value<int> rowid,
});
typedef $$ChargeLogsTableTableUpdateCompanionBuilder = ChargeLogsTableCompanion
    Function({
  Value<String> id,
  Value<DateTime> date,
  Value<double> durationMinutes,
  Value<double> kwhAdded,
  Value<double> cost,
  Value<PaymentMethod> paymentMethod,
  Value<LocationType> locationType,
  Value<int> startBattery,
  Value<int> endBattery,
  Value<String?> locationName,
  Value<String?> notes,
  Value<int> rowid,
});

class $$ChargeLogsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ChargeLogsTableTable> {
  $$ChargeLogsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get kwhAdded => $composableBuilder(
      column: $table.kwhAdded, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get cost => $composableBuilder(
      column: $table.cost, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<PaymentMethod, PaymentMethod, int>
      get paymentMethod => $composableBuilder(
          column: $table.paymentMethod,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<LocationType, LocationType, int>
      get locationType => $composableBuilder(
          column: $table.locationType,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<int> get startBattery => $composableBuilder(
      column: $table.startBattery, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get endBattery => $composableBuilder(
      column: $table.endBattery, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get locationName => $composableBuilder(
      column: $table.locationName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));
}

class $$ChargeLogsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ChargeLogsTableTable> {
  $$ChargeLogsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get kwhAdded => $composableBuilder(
      column: $table.kwhAdded, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get cost => $composableBuilder(
      column: $table.cost, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get paymentMethod => $composableBuilder(
      column: $table.paymentMethod,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get locationType => $composableBuilder(
      column: $table.locationType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get startBattery => $composableBuilder(
      column: $table.startBattery,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get endBattery => $composableBuilder(
      column: $table.endBattery, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get locationName => $composableBuilder(
      column: $table.locationName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));
}

class $$ChargeLogsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChargeLogsTableTable> {
  $$ChargeLogsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes, builder: (column) => column);

  GeneratedColumn<double> get kwhAdded =>
      $composableBuilder(column: $table.kwhAdded, builder: (column) => column);

  GeneratedColumn<double> get cost =>
      $composableBuilder(column: $table.cost, builder: (column) => column);

  GeneratedColumnWithTypeConverter<PaymentMethod, int> get paymentMethod =>
      $composableBuilder(
          column: $table.paymentMethod, builder: (column) => column);

  GeneratedColumnWithTypeConverter<LocationType, int> get locationType =>
      $composableBuilder(
          column: $table.locationType, builder: (column) => column);

  GeneratedColumn<int> get startBattery => $composableBuilder(
      column: $table.startBattery, builder: (column) => column);

  GeneratedColumn<int> get endBattery => $composableBuilder(
      column: $table.endBattery, builder: (column) => column);

  GeneratedColumn<String> get locationName => $composableBuilder(
      column: $table.locationName, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$ChargeLogsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChargeLogsTableTable,
    ChargeLogsTableData,
    $$ChargeLogsTableTableFilterComposer,
    $$ChargeLogsTableTableOrderingComposer,
    $$ChargeLogsTableTableAnnotationComposer,
    $$ChargeLogsTableTableCreateCompanionBuilder,
    $$ChargeLogsTableTableUpdateCompanionBuilder,
    (
      ChargeLogsTableData,
      BaseReferences<_$AppDatabase, $ChargeLogsTableTable, ChargeLogsTableData>
    ),
    ChargeLogsTableData,
    PrefetchHooks Function()> {
  $$ChargeLogsTableTableTableManager(
      _$AppDatabase db, $ChargeLogsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChargeLogsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChargeLogsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChargeLogsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<double> durationMinutes = const Value.absent(),
            Value<double> kwhAdded = const Value.absent(),
            Value<double> cost = const Value.absent(),
            Value<PaymentMethod> paymentMethod = const Value.absent(),
            Value<LocationType> locationType = const Value.absent(),
            Value<int> startBattery = const Value.absent(),
            Value<int> endBattery = const Value.absent(),
            Value<String?> locationName = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ChargeLogsTableCompanion(
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
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required DateTime date,
            required double durationMinutes,
            required double kwhAdded,
            required double cost,
            required PaymentMethod paymentMethod,
            required LocationType locationType,
            required int startBattery,
            required int endBattery,
            Value<String?> locationName = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ChargeLogsTableCompanion.insert(
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
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ChargeLogsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ChargeLogsTableTable,
    ChargeLogsTableData,
    $$ChargeLogsTableTableFilterComposer,
    $$ChargeLogsTableTableOrderingComposer,
    $$ChargeLogsTableTableAnnotationComposer,
    $$ChargeLogsTableTableCreateCompanionBuilder,
    $$ChargeLogsTableTableUpdateCompanionBuilder,
    (
      ChargeLogsTableData,
      BaseReferences<_$AppDatabase, $ChargeLogsTableTable, ChargeLogsTableData>
    ),
    ChargeLogsTableData,
    PrefetchHooks Function()>;
typedef $$ExpensesTableTableCreateCompanionBuilder = ExpensesTableCompanion
    Function({
  required String id,
  required DateTime date,
  required ExpenseCategory category,
  required double amount,
  Value<String?> notes,
  Value<String?> receiptPhotoPath,
  Value<int> rowid,
});
typedef $$ExpensesTableTableUpdateCompanionBuilder = ExpensesTableCompanion
    Function({
  Value<String> id,
  Value<DateTime> date,
  Value<ExpenseCategory> category,
  Value<double> amount,
  Value<String?> notes,
  Value<String?> receiptPhotoPath,
  Value<int> rowid,
});

class $$ExpensesTableTableFilterComposer
    extends Composer<_$AppDatabase, $ExpensesTableTable> {
  $$ExpensesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<ExpenseCategory, ExpenseCategory, int>
      get category => $composableBuilder(
          column: $table.category,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get receiptPhotoPath => $composableBuilder(
      column: $table.receiptPhotoPath,
      builder: (column) => ColumnFilters(column));
}

class $$ExpensesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ExpensesTableTable> {
  $$ExpensesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get receiptPhotoPath => $composableBuilder(
      column: $table.receiptPhotoPath,
      builder: (column) => ColumnOrderings(column));
}

class $$ExpensesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExpensesTableTable> {
  $$ExpensesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ExpenseCategory, int> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get receiptPhotoPath => $composableBuilder(
      column: $table.receiptPhotoPath, builder: (column) => column);
}

class $$ExpensesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ExpensesTableTable,
    ExpensesTableData,
    $$ExpensesTableTableFilterComposer,
    $$ExpensesTableTableOrderingComposer,
    $$ExpensesTableTableAnnotationComposer,
    $$ExpensesTableTableCreateCompanionBuilder,
    $$ExpensesTableTableUpdateCompanionBuilder,
    (
      ExpensesTableData,
      BaseReferences<_$AppDatabase, $ExpensesTableTable, ExpensesTableData>
    ),
    ExpensesTableData,
    PrefetchHooks Function()> {
  $$ExpensesTableTableTableManager(_$AppDatabase db, $ExpensesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpensesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpensesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpensesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<ExpenseCategory> category = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String?> receiptPhotoPath = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ExpensesTableCompanion(
            id: id,
            date: date,
            category: category,
            amount: amount,
            notes: notes,
            receiptPhotoPath: receiptPhotoPath,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required DateTime date,
            required ExpenseCategory category,
            required double amount,
            Value<String?> notes = const Value.absent(),
            Value<String?> receiptPhotoPath = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ExpensesTableCompanion.insert(
            id: id,
            date: date,
            category: category,
            amount: amount,
            notes: notes,
            receiptPhotoPath: receiptPhotoPath,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ExpensesTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ExpensesTableTable,
    ExpensesTableData,
    $$ExpensesTableTableFilterComposer,
    $$ExpensesTableTableOrderingComposer,
    $$ExpensesTableTableAnnotationComposer,
    $$ExpensesTableTableCreateCompanionBuilder,
    $$ExpensesTableTableUpdateCompanionBuilder,
    (
      ExpensesTableData,
      BaseReferences<_$AppDatabase, $ExpensesTableTable, ExpensesTableData>
    ),
    ExpensesTableData,
    PrefetchHooks Function()>;
typedef $$MaintenanceLogsTableTableCreateCompanionBuilder
    = MaintenanceLogsTableCompanion Function({
  required String id,
  required DateTime date,
  required MaintenanceComponent component,
  required String description,
  required double odometerReading,
  required double cost,
  Value<int> rowid,
});
typedef $$MaintenanceLogsTableTableUpdateCompanionBuilder
    = MaintenanceLogsTableCompanion Function({
  Value<String> id,
  Value<DateTime> date,
  Value<MaintenanceComponent> component,
  Value<String> description,
  Value<double> odometerReading,
  Value<double> cost,
  Value<int> rowid,
});

class $$MaintenanceLogsTableTableFilterComposer
    extends Composer<_$AppDatabase, $MaintenanceLogsTableTable> {
  $$MaintenanceLogsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<MaintenanceComponent, MaintenanceComponent,
          int>
      get component => $composableBuilder(
          column: $table.component,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get odometerReading => $composableBuilder(
      column: $table.odometerReading,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get cost => $composableBuilder(
      column: $table.cost, builder: (column) => ColumnFilters(column));
}

class $$MaintenanceLogsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $MaintenanceLogsTableTable> {
  $$MaintenanceLogsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get component => $composableBuilder(
      column: $table.component, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get odometerReading => $composableBuilder(
      column: $table.odometerReading,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get cost => $composableBuilder(
      column: $table.cost, builder: (column) => ColumnOrderings(column));
}

class $$MaintenanceLogsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $MaintenanceLogsTableTable> {
  $$MaintenanceLogsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MaintenanceComponent, int> get component =>
      $composableBuilder(column: $table.component, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<double> get odometerReading => $composableBuilder(
      column: $table.odometerReading, builder: (column) => column);

  GeneratedColumn<double> get cost =>
      $composableBuilder(column: $table.cost, builder: (column) => column);
}

class $$MaintenanceLogsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MaintenanceLogsTableTable,
    MaintenanceLogsTableData,
    $$MaintenanceLogsTableTableFilterComposer,
    $$MaintenanceLogsTableTableOrderingComposer,
    $$MaintenanceLogsTableTableAnnotationComposer,
    $$MaintenanceLogsTableTableCreateCompanionBuilder,
    $$MaintenanceLogsTableTableUpdateCompanionBuilder,
    (
      MaintenanceLogsTableData,
      BaseReferences<_$AppDatabase, $MaintenanceLogsTableTable,
          MaintenanceLogsTableData>
    ),
    MaintenanceLogsTableData,
    PrefetchHooks Function()> {
  $$MaintenanceLogsTableTableTableManager(
      _$AppDatabase db, $MaintenanceLogsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MaintenanceLogsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MaintenanceLogsTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MaintenanceLogsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<MaintenanceComponent> component = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<double> odometerReading = const Value.absent(),
            Value<double> cost = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MaintenanceLogsTableCompanion(
            id: id,
            date: date,
            component: component,
            description: description,
            odometerReading: odometerReading,
            cost: cost,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required DateTime date,
            required MaintenanceComponent component,
            required String description,
            required double odometerReading,
            required double cost,
            Value<int> rowid = const Value.absent(),
          }) =>
              MaintenanceLogsTableCompanion.insert(
            id: id,
            date: date,
            component: component,
            description: description,
            odometerReading: odometerReading,
            cost: cost,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MaintenanceLogsTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $MaintenanceLogsTableTable,
        MaintenanceLogsTableData,
        $$MaintenanceLogsTableTableFilterComposer,
        $$MaintenanceLogsTableTableOrderingComposer,
        $$MaintenanceLogsTableTableAnnotationComposer,
        $$MaintenanceLogsTableTableCreateCompanionBuilder,
        $$MaintenanceLogsTableTableUpdateCompanionBuilder,
        (
          MaintenanceLogsTableData,
          BaseReferences<_$AppDatabase, $MaintenanceLogsTableTable,
              MaintenanceLogsTableData>
        ),
        MaintenanceLogsTableData,
        PrefetchHooks Function()>;
typedef $$RemindersTableTableCreateCompanionBuilder = RemindersTableCompanion
    Function({
  required String id,
  required String title,
  required String body,
  Value<DateTime?> targetDate,
  Value<double?> targetOdometer,
  Value<bool> isCompleted,
  Value<bool> isNotified,
  Value<int> rowid,
});
typedef $$RemindersTableTableUpdateCompanionBuilder = RemindersTableCompanion
    Function({
  Value<String> id,
  Value<String> title,
  Value<String> body,
  Value<DateTime?> targetDate,
  Value<double?> targetOdometer,
  Value<bool> isCompleted,
  Value<bool> isNotified,
  Value<int> rowid,
});

class $$RemindersTableTableFilterComposer
    extends Composer<_$AppDatabase, $RemindersTableTable> {
  $$RemindersTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get body => $composableBuilder(
      column: $table.body, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get targetDate => $composableBuilder(
      column: $table.targetDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get targetOdometer => $composableBuilder(
      column: $table.targetOdometer,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isNotified => $composableBuilder(
      column: $table.isNotified, builder: (column) => ColumnFilters(column));
}

class $$RemindersTableTableOrderingComposer
    extends Composer<_$AppDatabase, $RemindersTableTable> {
  $$RemindersTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get body => $composableBuilder(
      column: $table.body, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get targetDate => $composableBuilder(
      column: $table.targetDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get targetOdometer => $composableBuilder(
      column: $table.targetOdometer,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isNotified => $composableBuilder(
      column: $table.isNotified, builder: (column) => ColumnOrderings(column));
}

class $$RemindersTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $RemindersTableTable> {
  $$RemindersTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<DateTime> get targetDate => $composableBuilder(
      column: $table.targetDate, builder: (column) => column);

  GeneratedColumn<double> get targetOdometer => $composableBuilder(
      column: $table.targetOdometer, builder: (column) => column);

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => column);

  GeneratedColumn<bool> get isNotified => $composableBuilder(
      column: $table.isNotified, builder: (column) => column);
}

class $$RemindersTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RemindersTableTable,
    RemindersTableData,
    $$RemindersTableTableFilterComposer,
    $$RemindersTableTableOrderingComposer,
    $$RemindersTableTableAnnotationComposer,
    $$RemindersTableTableCreateCompanionBuilder,
    $$RemindersTableTableUpdateCompanionBuilder,
    (
      RemindersTableData,
      BaseReferences<_$AppDatabase, $RemindersTableTable, RemindersTableData>
    ),
    RemindersTableData,
    PrefetchHooks Function()> {
  $$RemindersTableTableTableManager(
      _$AppDatabase db, $RemindersTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RemindersTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RemindersTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RemindersTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> body = const Value.absent(),
            Value<DateTime?> targetDate = const Value.absent(),
            Value<double?> targetOdometer = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
            Value<bool> isNotified = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RemindersTableCompanion(
            id: id,
            title: title,
            body: body,
            targetDate: targetDate,
            targetOdometer: targetOdometer,
            isCompleted: isCompleted,
            isNotified: isNotified,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            required String body,
            Value<DateTime?> targetDate = const Value.absent(),
            Value<double?> targetOdometer = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
            Value<bool> isNotified = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RemindersTableCompanion.insert(
            id: id,
            title: title,
            body: body,
            targetDate: targetDate,
            targetOdometer: targetOdometer,
            isCompleted: isCompleted,
            isNotified: isNotified,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$RemindersTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RemindersTableTable,
    RemindersTableData,
    $$RemindersTableTableFilterComposer,
    $$RemindersTableTableOrderingComposer,
    $$RemindersTableTableAnnotationComposer,
    $$RemindersTableTableCreateCompanionBuilder,
    $$RemindersTableTableUpdateCompanionBuilder,
    (
      RemindersTableData,
      BaseReferences<_$AppDatabase, $RemindersTableTable, RemindersTableData>
    ),
    RemindersTableData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$RidesTableTableTableManager get ridesTable =>
      $$RidesTableTableTableManager(_db, _db.ridesTable);
  $$ChargeLogsTableTableTableManager get chargeLogsTable =>
      $$ChargeLogsTableTableTableManager(_db, _db.chargeLogsTable);
  $$ExpensesTableTableTableManager get expensesTable =>
      $$ExpensesTableTableTableManager(_db, _db.expensesTable);
  $$MaintenanceLogsTableTableTableManager get maintenanceLogsTable =>
      $$MaintenanceLogsTableTableTableManager(_db, _db.maintenanceLogsTable);
  $$RemindersTableTableTableManager get remindersTable =>
      $$RemindersTableTableTableManager(_db, _db.remindersTable);
}
