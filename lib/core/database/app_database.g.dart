// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $BikesTableTable extends BikesTable
    with TableInfo<$BikesTableTable, BikesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BikesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _brandMeta = const VerificationMeta('brand');
  @override
  late final GeneratedColumn<String> brand = GeneratedColumn<String>(
    'brand',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
    'model',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _variantMeta = const VerificationMeta(
    'variant',
  );
  @override
  late final GeneratedColumn<String> variant = GeneratedColumn<String>(
    'variant',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
    'color',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _registrationNumberMeta =
      const VerificationMeta('registrationNumber');
  @override
  late final GeneratedColumn<String> registrationNumber =
      GeneratedColumn<String>(
        'registration_number',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _vinMeta = const VerificationMeta('vin');
  @override
  late final GeneratedColumn<String> vin = GeneratedColumn<String>(
    'vin',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _motorNumberMeta = const VerificationMeta(
    'motorNumber',
  );
  @override
  late final GeneratedColumn<String> motorNumber = GeneratedColumn<String>(
    'motor_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _purchaseDateMeta = const VerificationMeta(
    'purchaseDate',
  );
  @override
  late final GeneratedColumn<DateTime> purchaseDate = GeneratedColumn<DateTime>(
    'purchase_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _purchasePriceMeta = const VerificationMeta(
    'purchasePrice',
  );
  @override
  late final GeneratedColumn<double> purchasePrice = GeneratedColumn<double>(
    'purchase_price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dealerMeta = const VerificationMeta('dealer');
  @override
  late final GeneratedColumn<String> dealer = GeneratedColumn<String>(
    'dealer',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _insuranceMeta = const VerificationMeta(
    'insurance',
  );
  @override
  late final GeneratedColumn<String> insurance = GeneratedColumn<String>(
    'insurance',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _warrantyMeta = const VerificationMeta(
    'warranty',
  );
  @override
  late final GeneratedColumn<String> warranty = GeneratedColumn<String>(
    'warranty',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _batteryWarrantyMeta = const VerificationMeta(
    'batteryWarranty',
  );
  @override
  late final GeneratedColumn<String> batteryWarranty = GeneratedColumn<String>(
    'battery_warranty',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _batteryCapacityMeta = const VerificationMeta(
    'batteryCapacity',
  );
  @override
  late final GeneratedColumn<double> batteryCapacity = GeneratedColumn<double>(
    'battery_capacity',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _motorPowerMeta = const VerificationMeta(
    'motorPower',
  );
  @override
  late final GeneratedColumn<double> motorPower = GeneratedColumn<double>(
    'motor_power',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _claimedRangeMeta = const VerificationMeta(
    'claimedRange',
  );
  @override
  late final GeneratedColumn<double> claimedRange = GeneratedColumn<double>(
    'claimed_range',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _topSpeedMeta = const VerificationMeta(
    'topSpeed',
  );
  @override
  late final GeneratedColumn<double> topSpeed = GeneratedColumn<double>(
    'top_speed',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tyreInfoMeta = const VerificationMeta(
    'tyreInfo',
  );
  @override
  late final GeneratedColumn<String> tyreInfo = GeneratedColumn<String>(
    'tyre_info',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _customNotesMeta = const VerificationMeta(
    'customNotes',
  );
  @override
  late final GeneratedColumn<String> customNotes = GeneratedColumn<String>(
    'custom_notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _photoPathMeta = const VerificationMeta(
    'photoPath',
  );
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
    'photo_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    brand,
    model,
    variant,
    color,
    registrationNumber,
    vin,
    motorNumber,
    purchaseDate,
    purchasePrice,
    dealer,
    insurance,
    warranty,
    batteryWarranty,
    batteryCapacity,
    motorPower,
    claimedRange,
    topSpeed,
    tyreInfo,
    customNotes,
    photoPath,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bikes_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<BikesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('brand')) {
      context.handle(
        _brandMeta,
        brand.isAcceptableOrUnknown(data['brand']!, _brandMeta),
      );
    } else if (isInserting) {
      context.missing(_brandMeta);
    }
    if (data.containsKey('model')) {
      context.handle(
        _modelMeta,
        model.isAcceptableOrUnknown(data['model']!, _modelMeta),
      );
    } else if (isInserting) {
      context.missing(_modelMeta);
    }
    if (data.containsKey('variant')) {
      context.handle(
        _variantMeta,
        variant.isAcceptableOrUnknown(data['variant']!, _variantMeta),
      );
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    if (data.containsKey('registration_number')) {
      context.handle(
        _registrationNumberMeta,
        registrationNumber.isAcceptableOrUnknown(
          data['registration_number']!,
          _registrationNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_registrationNumberMeta);
    }
    if (data.containsKey('vin')) {
      context.handle(
        _vinMeta,
        vin.isAcceptableOrUnknown(data['vin']!, _vinMeta),
      );
    }
    if (data.containsKey('motor_number')) {
      context.handle(
        _motorNumberMeta,
        motorNumber.isAcceptableOrUnknown(
          data['motor_number']!,
          _motorNumberMeta,
        ),
      );
    }
    if (data.containsKey('purchase_date')) {
      context.handle(
        _purchaseDateMeta,
        purchaseDate.isAcceptableOrUnknown(
          data['purchase_date']!,
          _purchaseDateMeta,
        ),
      );
    }
    if (data.containsKey('purchase_price')) {
      context.handle(
        _purchasePriceMeta,
        purchasePrice.isAcceptableOrUnknown(
          data['purchase_price']!,
          _purchasePriceMeta,
        ),
      );
    }
    if (data.containsKey('dealer')) {
      context.handle(
        _dealerMeta,
        dealer.isAcceptableOrUnknown(data['dealer']!, _dealerMeta),
      );
    }
    if (data.containsKey('insurance')) {
      context.handle(
        _insuranceMeta,
        insurance.isAcceptableOrUnknown(data['insurance']!, _insuranceMeta),
      );
    }
    if (data.containsKey('warranty')) {
      context.handle(
        _warrantyMeta,
        warranty.isAcceptableOrUnknown(data['warranty']!, _warrantyMeta),
      );
    }
    if (data.containsKey('battery_warranty')) {
      context.handle(
        _batteryWarrantyMeta,
        batteryWarranty.isAcceptableOrUnknown(
          data['battery_warranty']!,
          _batteryWarrantyMeta,
        ),
      );
    }
    if (data.containsKey('battery_capacity')) {
      context.handle(
        _batteryCapacityMeta,
        batteryCapacity.isAcceptableOrUnknown(
          data['battery_capacity']!,
          _batteryCapacityMeta,
        ),
      );
    }
    if (data.containsKey('motor_power')) {
      context.handle(
        _motorPowerMeta,
        motorPower.isAcceptableOrUnknown(data['motor_power']!, _motorPowerMeta),
      );
    }
    if (data.containsKey('claimed_range')) {
      context.handle(
        _claimedRangeMeta,
        claimedRange.isAcceptableOrUnknown(
          data['claimed_range']!,
          _claimedRangeMeta,
        ),
      );
    }
    if (data.containsKey('top_speed')) {
      context.handle(
        _topSpeedMeta,
        topSpeed.isAcceptableOrUnknown(data['top_speed']!, _topSpeedMeta),
      );
    }
    if (data.containsKey('tyre_info')) {
      context.handle(
        _tyreInfoMeta,
        tyreInfo.isAcceptableOrUnknown(data['tyre_info']!, _tyreInfoMeta),
      );
    }
    if (data.containsKey('custom_notes')) {
      context.handle(
        _customNotesMeta,
        customNotes.isAcceptableOrUnknown(
          data['custom_notes']!,
          _customNotesMeta,
        ),
      );
    }
    if (data.containsKey('photo_path')) {
      context.handle(
        _photoPathMeta,
        photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BikesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BikesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      brand: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}brand'],
      )!,
      model: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model'],
      )!,
      variant: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}variant'],
      ),
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color'],
      )!,
      registrationNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}registration_number'],
      )!,
      vin: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vin'],
      ),
      motorNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}motor_number'],
      ),
      purchaseDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}purchase_date'],
      ),
      purchasePrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}purchase_price'],
      ),
      dealer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dealer'],
      ),
      insurance: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}insurance'],
      ),
      warranty: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}warranty'],
      ),
      batteryWarranty: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}battery_warranty'],
      ),
      batteryCapacity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}battery_capacity'],
      ),
      motorPower: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}motor_power'],
      ),
      claimedRange: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}claimed_range'],
      ),
      topSpeed: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}top_speed'],
      ),
      tyreInfo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tyre_info'],
      ),
      customNotes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}custom_notes'],
      ),
      photoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_path'],
      ),
    );
  }

  @override
  $BikesTableTable createAlias(String alias) {
    return $BikesTableTable(attachedDatabase, alias);
  }
}

class BikesTableData extends DataClass implements Insertable<BikesTableData> {
  final int id;
  final String name;
  final String brand;
  final String model;
  final String? variant;
  final String color;
  final String registrationNumber;
  final String? vin;
  final String? motorNumber;
  final DateTime? purchaseDate;
  final double? purchasePrice;
  final String? dealer;
  final String? insurance;
  final String? warranty;
  final String? batteryWarranty;
  final double? batteryCapacity;
  final double? motorPower;
  final double? claimedRange;
  final double? topSpeed;
  final String? tyreInfo;
  final String? customNotes;
  final String? photoPath;
  const BikesTableData({
    required this.id,
    required this.name,
    required this.brand,
    required this.model,
    this.variant,
    required this.color,
    required this.registrationNumber,
    this.vin,
    this.motorNumber,
    this.purchaseDate,
    this.purchasePrice,
    this.dealer,
    this.insurance,
    this.warranty,
    this.batteryWarranty,
    this.batteryCapacity,
    this.motorPower,
    this.claimedRange,
    this.topSpeed,
    this.tyreInfo,
    this.customNotes,
    this.photoPath,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['brand'] = Variable<String>(brand);
    map['model'] = Variable<String>(model);
    if (!nullToAbsent || variant != null) {
      map['variant'] = Variable<String>(variant);
    }
    map['color'] = Variable<String>(color);
    map['registration_number'] = Variable<String>(registrationNumber);
    if (!nullToAbsent || vin != null) {
      map['vin'] = Variable<String>(vin);
    }
    if (!nullToAbsent || motorNumber != null) {
      map['motor_number'] = Variable<String>(motorNumber);
    }
    if (!nullToAbsent || purchaseDate != null) {
      map['purchase_date'] = Variable<DateTime>(purchaseDate);
    }
    if (!nullToAbsent || purchasePrice != null) {
      map['purchase_price'] = Variable<double>(purchasePrice);
    }
    if (!nullToAbsent || dealer != null) {
      map['dealer'] = Variable<String>(dealer);
    }
    if (!nullToAbsent || insurance != null) {
      map['insurance'] = Variable<String>(insurance);
    }
    if (!nullToAbsent || warranty != null) {
      map['warranty'] = Variable<String>(warranty);
    }
    if (!nullToAbsent || batteryWarranty != null) {
      map['battery_warranty'] = Variable<String>(batteryWarranty);
    }
    if (!nullToAbsent || batteryCapacity != null) {
      map['battery_capacity'] = Variable<double>(batteryCapacity);
    }
    if (!nullToAbsent || motorPower != null) {
      map['motor_power'] = Variable<double>(motorPower);
    }
    if (!nullToAbsent || claimedRange != null) {
      map['claimed_range'] = Variable<double>(claimedRange);
    }
    if (!nullToAbsent || topSpeed != null) {
      map['top_speed'] = Variable<double>(topSpeed);
    }
    if (!nullToAbsent || tyreInfo != null) {
      map['tyre_info'] = Variable<String>(tyreInfo);
    }
    if (!nullToAbsent || customNotes != null) {
      map['custom_notes'] = Variable<String>(customNotes);
    }
    if (!nullToAbsent || photoPath != null) {
      map['photo_path'] = Variable<String>(photoPath);
    }
    return map;
  }

  BikesTableCompanion toCompanion(bool nullToAbsent) {
    return BikesTableCompanion(
      id: Value(id),
      name: Value(name),
      brand: Value(brand),
      model: Value(model),
      variant: variant == null && nullToAbsent
          ? const Value.absent()
          : Value(variant),
      color: Value(color),
      registrationNumber: Value(registrationNumber),
      vin: vin == null && nullToAbsent ? const Value.absent() : Value(vin),
      motorNumber: motorNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(motorNumber),
      purchaseDate: purchaseDate == null && nullToAbsent
          ? const Value.absent()
          : Value(purchaseDate),
      purchasePrice: purchasePrice == null && nullToAbsent
          ? const Value.absent()
          : Value(purchasePrice),
      dealer: dealer == null && nullToAbsent
          ? const Value.absent()
          : Value(dealer),
      insurance: insurance == null && nullToAbsent
          ? const Value.absent()
          : Value(insurance),
      warranty: warranty == null && nullToAbsent
          ? const Value.absent()
          : Value(warranty),
      batteryWarranty: batteryWarranty == null && nullToAbsent
          ? const Value.absent()
          : Value(batteryWarranty),
      batteryCapacity: batteryCapacity == null && nullToAbsent
          ? const Value.absent()
          : Value(batteryCapacity),
      motorPower: motorPower == null && nullToAbsent
          ? const Value.absent()
          : Value(motorPower),
      claimedRange: claimedRange == null && nullToAbsent
          ? const Value.absent()
          : Value(claimedRange),
      topSpeed: topSpeed == null && nullToAbsent
          ? const Value.absent()
          : Value(topSpeed),
      tyreInfo: tyreInfo == null && nullToAbsent
          ? const Value.absent()
          : Value(tyreInfo),
      customNotes: customNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(customNotes),
      photoPath: photoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoPath),
    );
  }

  factory BikesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BikesTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      brand: serializer.fromJson<String>(json['brand']),
      model: serializer.fromJson<String>(json['model']),
      variant: serializer.fromJson<String?>(json['variant']),
      color: serializer.fromJson<String>(json['color']),
      registrationNumber: serializer.fromJson<String>(
        json['registrationNumber'],
      ),
      vin: serializer.fromJson<String?>(json['vin']),
      motorNumber: serializer.fromJson<String?>(json['motorNumber']),
      purchaseDate: serializer.fromJson<DateTime?>(json['purchaseDate']),
      purchasePrice: serializer.fromJson<double?>(json['purchasePrice']),
      dealer: serializer.fromJson<String?>(json['dealer']),
      insurance: serializer.fromJson<String?>(json['insurance']),
      warranty: serializer.fromJson<String?>(json['warranty']),
      batteryWarranty: serializer.fromJson<String?>(json['batteryWarranty']),
      batteryCapacity: serializer.fromJson<double?>(json['batteryCapacity']),
      motorPower: serializer.fromJson<double?>(json['motorPower']),
      claimedRange: serializer.fromJson<double?>(json['claimedRange']),
      topSpeed: serializer.fromJson<double?>(json['topSpeed']),
      tyreInfo: serializer.fromJson<String?>(json['tyreInfo']),
      customNotes: serializer.fromJson<String?>(json['customNotes']),
      photoPath: serializer.fromJson<String?>(json['photoPath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'brand': serializer.toJson<String>(brand),
      'model': serializer.toJson<String>(model),
      'variant': serializer.toJson<String?>(variant),
      'color': serializer.toJson<String>(color),
      'registrationNumber': serializer.toJson<String>(registrationNumber),
      'vin': serializer.toJson<String?>(vin),
      'motorNumber': serializer.toJson<String?>(motorNumber),
      'purchaseDate': serializer.toJson<DateTime?>(purchaseDate),
      'purchasePrice': serializer.toJson<double?>(purchasePrice),
      'dealer': serializer.toJson<String?>(dealer),
      'insurance': serializer.toJson<String?>(insurance),
      'warranty': serializer.toJson<String?>(warranty),
      'batteryWarranty': serializer.toJson<String?>(batteryWarranty),
      'batteryCapacity': serializer.toJson<double?>(batteryCapacity),
      'motorPower': serializer.toJson<double?>(motorPower),
      'claimedRange': serializer.toJson<double?>(claimedRange),
      'topSpeed': serializer.toJson<double?>(topSpeed),
      'tyreInfo': serializer.toJson<String?>(tyreInfo),
      'customNotes': serializer.toJson<String?>(customNotes),
      'photoPath': serializer.toJson<String?>(photoPath),
    };
  }

  BikesTableData copyWith({
    int? id,
    String? name,
    String? brand,
    String? model,
    Value<String?> variant = const Value.absent(),
    String? color,
    String? registrationNumber,
    Value<String?> vin = const Value.absent(),
    Value<String?> motorNumber = const Value.absent(),
    Value<DateTime?> purchaseDate = const Value.absent(),
    Value<double?> purchasePrice = const Value.absent(),
    Value<String?> dealer = const Value.absent(),
    Value<String?> insurance = const Value.absent(),
    Value<String?> warranty = const Value.absent(),
    Value<String?> batteryWarranty = const Value.absent(),
    Value<double?> batteryCapacity = const Value.absent(),
    Value<double?> motorPower = const Value.absent(),
    Value<double?> claimedRange = const Value.absent(),
    Value<double?> topSpeed = const Value.absent(),
    Value<String?> tyreInfo = const Value.absent(),
    Value<String?> customNotes = const Value.absent(),
    Value<String?> photoPath = const Value.absent(),
  }) => BikesTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    brand: brand ?? this.brand,
    model: model ?? this.model,
    variant: variant.present ? variant.value : this.variant,
    color: color ?? this.color,
    registrationNumber: registrationNumber ?? this.registrationNumber,
    vin: vin.present ? vin.value : this.vin,
    motorNumber: motorNumber.present ? motorNumber.value : this.motorNumber,
    purchaseDate: purchaseDate.present ? purchaseDate.value : this.purchaseDate,
    purchasePrice: purchasePrice.present
        ? purchasePrice.value
        : this.purchasePrice,
    dealer: dealer.present ? dealer.value : this.dealer,
    insurance: insurance.present ? insurance.value : this.insurance,
    warranty: warranty.present ? warranty.value : this.warranty,
    batteryWarranty: batteryWarranty.present
        ? batteryWarranty.value
        : this.batteryWarranty,
    batteryCapacity: batteryCapacity.present
        ? batteryCapacity.value
        : this.batteryCapacity,
    motorPower: motorPower.present ? motorPower.value : this.motorPower,
    claimedRange: claimedRange.present ? claimedRange.value : this.claimedRange,
    topSpeed: topSpeed.present ? topSpeed.value : this.topSpeed,
    tyreInfo: tyreInfo.present ? tyreInfo.value : this.tyreInfo,
    customNotes: customNotes.present ? customNotes.value : this.customNotes,
    photoPath: photoPath.present ? photoPath.value : this.photoPath,
  );
  BikesTableData copyWithCompanion(BikesTableCompanion data) {
    return BikesTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      brand: data.brand.present ? data.brand.value : this.brand,
      model: data.model.present ? data.model.value : this.model,
      variant: data.variant.present ? data.variant.value : this.variant,
      color: data.color.present ? data.color.value : this.color,
      registrationNumber: data.registrationNumber.present
          ? data.registrationNumber.value
          : this.registrationNumber,
      vin: data.vin.present ? data.vin.value : this.vin,
      motorNumber: data.motorNumber.present
          ? data.motorNumber.value
          : this.motorNumber,
      purchaseDate: data.purchaseDate.present
          ? data.purchaseDate.value
          : this.purchaseDate,
      purchasePrice: data.purchasePrice.present
          ? data.purchasePrice.value
          : this.purchasePrice,
      dealer: data.dealer.present ? data.dealer.value : this.dealer,
      insurance: data.insurance.present ? data.insurance.value : this.insurance,
      warranty: data.warranty.present ? data.warranty.value : this.warranty,
      batteryWarranty: data.batteryWarranty.present
          ? data.batteryWarranty.value
          : this.batteryWarranty,
      batteryCapacity: data.batteryCapacity.present
          ? data.batteryCapacity.value
          : this.batteryCapacity,
      motorPower: data.motorPower.present
          ? data.motorPower.value
          : this.motorPower,
      claimedRange: data.claimedRange.present
          ? data.claimedRange.value
          : this.claimedRange,
      topSpeed: data.topSpeed.present ? data.topSpeed.value : this.topSpeed,
      tyreInfo: data.tyreInfo.present ? data.tyreInfo.value : this.tyreInfo,
      customNotes: data.customNotes.present
          ? data.customNotes.value
          : this.customNotes,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BikesTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('brand: $brand, ')
          ..write('model: $model, ')
          ..write('variant: $variant, ')
          ..write('color: $color, ')
          ..write('registrationNumber: $registrationNumber, ')
          ..write('vin: $vin, ')
          ..write('motorNumber: $motorNumber, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('purchasePrice: $purchasePrice, ')
          ..write('dealer: $dealer, ')
          ..write('insurance: $insurance, ')
          ..write('warranty: $warranty, ')
          ..write('batteryWarranty: $batteryWarranty, ')
          ..write('batteryCapacity: $batteryCapacity, ')
          ..write('motorPower: $motorPower, ')
          ..write('claimedRange: $claimedRange, ')
          ..write('topSpeed: $topSpeed, ')
          ..write('tyreInfo: $tyreInfo, ')
          ..write('customNotes: $customNotes, ')
          ..write('photoPath: $photoPath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    name,
    brand,
    model,
    variant,
    color,
    registrationNumber,
    vin,
    motorNumber,
    purchaseDate,
    purchasePrice,
    dealer,
    insurance,
    warranty,
    batteryWarranty,
    batteryCapacity,
    motorPower,
    claimedRange,
    topSpeed,
    tyreInfo,
    customNotes,
    photoPath,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BikesTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.brand == this.brand &&
          other.model == this.model &&
          other.variant == this.variant &&
          other.color == this.color &&
          other.registrationNumber == this.registrationNumber &&
          other.vin == this.vin &&
          other.motorNumber == this.motorNumber &&
          other.purchaseDate == this.purchaseDate &&
          other.purchasePrice == this.purchasePrice &&
          other.dealer == this.dealer &&
          other.insurance == this.insurance &&
          other.warranty == this.warranty &&
          other.batteryWarranty == this.batteryWarranty &&
          other.batteryCapacity == this.batteryCapacity &&
          other.motorPower == this.motorPower &&
          other.claimedRange == this.claimedRange &&
          other.topSpeed == this.topSpeed &&
          other.tyreInfo == this.tyreInfo &&
          other.customNotes == this.customNotes &&
          other.photoPath == this.photoPath);
}

class BikesTableCompanion extends UpdateCompanion<BikesTableData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> brand;
  final Value<String> model;
  final Value<String?> variant;
  final Value<String> color;
  final Value<String> registrationNumber;
  final Value<String?> vin;
  final Value<String?> motorNumber;
  final Value<DateTime?> purchaseDate;
  final Value<double?> purchasePrice;
  final Value<String?> dealer;
  final Value<String?> insurance;
  final Value<String?> warranty;
  final Value<String?> batteryWarranty;
  final Value<double?> batteryCapacity;
  final Value<double?> motorPower;
  final Value<double?> claimedRange;
  final Value<double?> topSpeed;
  final Value<String?> tyreInfo;
  final Value<String?> customNotes;
  final Value<String?> photoPath;
  const BikesTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.brand = const Value.absent(),
    this.model = const Value.absent(),
    this.variant = const Value.absent(),
    this.color = const Value.absent(),
    this.registrationNumber = const Value.absent(),
    this.vin = const Value.absent(),
    this.motorNumber = const Value.absent(),
    this.purchaseDate = const Value.absent(),
    this.purchasePrice = const Value.absent(),
    this.dealer = const Value.absent(),
    this.insurance = const Value.absent(),
    this.warranty = const Value.absent(),
    this.batteryWarranty = const Value.absent(),
    this.batteryCapacity = const Value.absent(),
    this.motorPower = const Value.absent(),
    this.claimedRange = const Value.absent(),
    this.topSpeed = const Value.absent(),
    this.tyreInfo = const Value.absent(),
    this.customNotes = const Value.absent(),
    this.photoPath = const Value.absent(),
  });
  BikesTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String brand,
    required String model,
    this.variant = const Value.absent(),
    required String color,
    required String registrationNumber,
    this.vin = const Value.absent(),
    this.motorNumber = const Value.absent(),
    this.purchaseDate = const Value.absent(),
    this.purchasePrice = const Value.absent(),
    this.dealer = const Value.absent(),
    this.insurance = const Value.absent(),
    this.warranty = const Value.absent(),
    this.batteryWarranty = const Value.absent(),
    this.batteryCapacity = const Value.absent(),
    this.motorPower = const Value.absent(),
    this.claimedRange = const Value.absent(),
    this.topSpeed = const Value.absent(),
    this.tyreInfo = const Value.absent(),
    this.customNotes = const Value.absent(),
    this.photoPath = const Value.absent(),
  }) : name = Value(name),
       brand = Value(brand),
       model = Value(model),
       color = Value(color),
       registrationNumber = Value(registrationNumber);
  static Insertable<BikesTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? brand,
    Expression<String>? model,
    Expression<String>? variant,
    Expression<String>? color,
    Expression<String>? registrationNumber,
    Expression<String>? vin,
    Expression<String>? motorNumber,
    Expression<DateTime>? purchaseDate,
    Expression<double>? purchasePrice,
    Expression<String>? dealer,
    Expression<String>? insurance,
    Expression<String>? warranty,
    Expression<String>? batteryWarranty,
    Expression<double>? batteryCapacity,
    Expression<double>? motorPower,
    Expression<double>? claimedRange,
    Expression<double>? topSpeed,
    Expression<String>? tyreInfo,
    Expression<String>? customNotes,
    Expression<String>? photoPath,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (brand != null) 'brand': brand,
      if (model != null) 'model': model,
      if (variant != null) 'variant': variant,
      if (color != null) 'color': color,
      if (registrationNumber != null) 'registration_number': registrationNumber,
      if (vin != null) 'vin': vin,
      if (motorNumber != null) 'motor_number': motorNumber,
      if (purchaseDate != null) 'purchase_date': purchaseDate,
      if (purchasePrice != null) 'purchase_price': purchasePrice,
      if (dealer != null) 'dealer': dealer,
      if (insurance != null) 'insurance': insurance,
      if (warranty != null) 'warranty': warranty,
      if (batteryWarranty != null) 'battery_warranty': batteryWarranty,
      if (batteryCapacity != null) 'battery_capacity': batteryCapacity,
      if (motorPower != null) 'motor_power': motorPower,
      if (claimedRange != null) 'claimed_range': claimedRange,
      if (topSpeed != null) 'top_speed': topSpeed,
      if (tyreInfo != null) 'tyre_info': tyreInfo,
      if (customNotes != null) 'custom_notes': customNotes,
      if (photoPath != null) 'photo_path': photoPath,
    });
  }

  BikesTableCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? brand,
    Value<String>? model,
    Value<String?>? variant,
    Value<String>? color,
    Value<String>? registrationNumber,
    Value<String?>? vin,
    Value<String?>? motorNumber,
    Value<DateTime?>? purchaseDate,
    Value<double?>? purchasePrice,
    Value<String?>? dealer,
    Value<String?>? insurance,
    Value<String?>? warranty,
    Value<String?>? batteryWarranty,
    Value<double?>? batteryCapacity,
    Value<double?>? motorPower,
    Value<double?>? claimedRange,
    Value<double?>? topSpeed,
    Value<String?>? tyreInfo,
    Value<String?>? customNotes,
    Value<String?>? photoPath,
  }) {
    return BikesTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      variant: variant ?? this.variant,
      color: color ?? this.color,
      registrationNumber: registrationNumber ?? this.registrationNumber,
      vin: vin ?? this.vin,
      motorNumber: motorNumber ?? this.motorNumber,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      dealer: dealer ?? this.dealer,
      insurance: insurance ?? this.insurance,
      warranty: warranty ?? this.warranty,
      batteryWarranty: batteryWarranty ?? this.batteryWarranty,
      batteryCapacity: batteryCapacity ?? this.batteryCapacity,
      motorPower: motorPower ?? this.motorPower,
      claimedRange: claimedRange ?? this.claimedRange,
      topSpeed: topSpeed ?? this.topSpeed,
      tyreInfo: tyreInfo ?? this.tyreInfo,
      customNotes: customNotes ?? this.customNotes,
      photoPath: photoPath ?? this.photoPath,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (brand.present) {
      map['brand'] = Variable<String>(brand.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (variant.present) {
      map['variant'] = Variable<String>(variant.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (registrationNumber.present) {
      map['registration_number'] = Variable<String>(registrationNumber.value);
    }
    if (vin.present) {
      map['vin'] = Variable<String>(vin.value);
    }
    if (motorNumber.present) {
      map['motor_number'] = Variable<String>(motorNumber.value);
    }
    if (purchaseDate.present) {
      map['purchase_date'] = Variable<DateTime>(purchaseDate.value);
    }
    if (purchasePrice.present) {
      map['purchase_price'] = Variable<double>(purchasePrice.value);
    }
    if (dealer.present) {
      map['dealer'] = Variable<String>(dealer.value);
    }
    if (insurance.present) {
      map['insurance'] = Variable<String>(insurance.value);
    }
    if (warranty.present) {
      map['warranty'] = Variable<String>(warranty.value);
    }
    if (batteryWarranty.present) {
      map['battery_warranty'] = Variable<String>(batteryWarranty.value);
    }
    if (batteryCapacity.present) {
      map['battery_capacity'] = Variable<double>(batteryCapacity.value);
    }
    if (motorPower.present) {
      map['motor_power'] = Variable<double>(motorPower.value);
    }
    if (claimedRange.present) {
      map['claimed_range'] = Variable<double>(claimedRange.value);
    }
    if (topSpeed.present) {
      map['top_speed'] = Variable<double>(topSpeed.value);
    }
    if (tyreInfo.present) {
      map['tyre_info'] = Variable<String>(tyreInfo.value);
    }
    if (customNotes.present) {
      map['custom_notes'] = Variable<String>(customNotes.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BikesTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('brand: $brand, ')
          ..write('model: $model, ')
          ..write('variant: $variant, ')
          ..write('color: $color, ')
          ..write('registrationNumber: $registrationNumber, ')
          ..write('vin: $vin, ')
          ..write('motorNumber: $motorNumber, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('purchasePrice: $purchasePrice, ')
          ..write('dealer: $dealer, ')
          ..write('insurance: $insurance, ')
          ..write('warranty: $warranty, ')
          ..write('batteryWarranty: $batteryWarranty, ')
          ..write('batteryCapacity: $batteryCapacity, ')
          ..write('motorPower: $motorPower, ')
          ..write('claimedRange: $claimedRange, ')
          ..write('topSpeed: $topSpeed, ')
          ..write('tyreInfo: $tyreInfo, ')
          ..write('customNotes: $customNotes, ')
          ..write('photoPath: $photoPath')
          ..write(')'))
        .toString();
  }
}

class $RidesTableTable extends RidesTable
    with TableInfo<$RidesTableTable, RidesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RidesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startOdometerMeta = const VerificationMeta(
    'startOdometer',
  );
  @override
  late final GeneratedColumn<double> startOdometer = GeneratedColumn<double>(
    'start_odometer',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endOdometerMeta = const VerificationMeta(
    'endOdometer',
  );
  @override
  late final GeneratedColumn<double> endOdometer = GeneratedColumn<double>(
    'end_odometer',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _batteryBeforeMeta = const VerificationMeta(
    'batteryBefore',
  );
  @override
  late final GeneratedColumn<int> batteryBefore = GeneratedColumn<int>(
    'battery_before',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _batteryAfterMeta = const VerificationMeta(
    'batteryAfter',
  );
  @override
  late final GeneratedColumn<int> batteryAfter = GeneratedColumn<int>(
    'battery_after',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<RideMode, int> rideMode =
      GeneratedColumn<int>(
        'ride_mode',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<RideMode>($RidesTableTable.$converterrideMode);
  @override
  late final GeneratedColumnWithTypeConverter<RoadCondition, int>
  roadCondition = GeneratedColumn<int>(
    'road_condition',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  ).withConverter<RoadCondition>($RidesTableTable.$converterroadCondition);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String> photoPaths =
      GeneratedColumn<String>(
        'photo_paths',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant(''),
      ).withConverter<List<String>>($RidesTableTable.$converterphotoPaths);
  static const VerificationMeta _startTimeMeta = const VerificationMeta(
    'startTime',
  );
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
    'start_time',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endTimeMeta = const VerificationMeta(
    'endTime',
  );
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
    'end_time',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _durationMinutesMeta = const VerificationMeta(
    'durationMinutes',
  );
  @override
  late final GeneratedColumn<int> durationMinutes = GeneratedColumn<int>(
    'duration_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _estimatedRemainingRangeMeta =
      const VerificationMeta('estimatedRemainingRange');
  @override
  late final GeneratedColumn<double> estimatedRemainingRange =
      GeneratedColumn<double>(
        'estimated_remaining_range',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _averageSpeedMeta = const VerificationMeta(
    'averageSpeed',
  );
  @override
  late final GeneratedColumn<double> averageSpeed = GeneratedColumn<double>(
    'average_speed',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _maxSpeedMeta = const VerificationMeta(
    'maxSpeed',
  );
  @override
  late final GeneratedColumn<double> maxSpeed = GeneratedColumn<double>(
    'max_speed',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weatherMeta = const VerificationMeta(
    'weather',
  );
  @override
  late final GeneratedColumn<String> weather = GeneratedColumn<String>(
    'weather',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _roadTypeMeta = const VerificationMeta(
    'roadType',
  );
  @override
  late final GeneratedColumn<String> roadType = GeneratedColumn<String>(
    'road_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _passengerCountMeta = const VerificationMeta(
    'passengerCount',
  );
  @override
  late final GeneratedColumn<int> passengerCount = GeneratedColumn<int>(
    'passenger_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ridePurposeMeta = const VerificationMeta(
    'ridePurpose',
  );
  @override
  late final GeneratedColumn<String> ridePurpose = GeneratedColumn<String>(
    'ride_purpose',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startLocationMeta = const VerificationMeta(
    'startLocation',
  );
  @override
  late final GeneratedColumn<String> startLocation = GeneratedColumn<String>(
    'start_location',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endLocationMeta = const VerificationMeta(
    'endLocation',
  );
  @override
  late final GeneratedColumn<String> endLocation = GeneratedColumn<String>(
    'end_location',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _routeNotesMeta = const VerificationMeta(
    'routeNotes',
  );
  @override
  late final GeneratedColumn<String> routeNotes = GeneratedColumn<String>(
    'route_notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String> customTags =
      GeneratedColumn<String>(
        'custom_tags',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant(''),
      ).withConverter<List<String>>($RidesTableTable.$convertercustomTags);
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _bikeIdMeta = const VerificationMeta('bikeId');
  @override
  late final GeneratedColumn<int> bikeId = GeneratedColumn<int>(
    'bike_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('manual'),
  );
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
    photoPaths,
    startTime,
    endTime,
    durationMinutes,
    estimatedRemainingRange,
    averageSpeed,
    maxSpeed,
    weather,
    roadType,
    passengerCount,
    ridePurpose,
    startLocation,
    endLocation,
    routeNotes,
    customTags,
    isFavorite,
    bikeId,
    source,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rides_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<RidesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('start_odometer')) {
      context.handle(
        _startOdometerMeta,
        startOdometer.isAcceptableOrUnknown(
          data['start_odometer']!,
          _startOdometerMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_startOdometerMeta);
    }
    if (data.containsKey('end_odometer')) {
      context.handle(
        _endOdometerMeta,
        endOdometer.isAcceptableOrUnknown(
          data['end_odometer']!,
          _endOdometerMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_endOdometerMeta);
    }
    if (data.containsKey('battery_before')) {
      context.handle(
        _batteryBeforeMeta,
        batteryBefore.isAcceptableOrUnknown(
          data['battery_before']!,
          _batteryBeforeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_batteryBeforeMeta);
    }
    if (data.containsKey('battery_after')) {
      context.handle(
        _batteryAfterMeta,
        batteryAfter.isAcceptableOrUnknown(
          data['battery_after']!,
          _batteryAfterMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_batteryAfterMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('start_time')) {
      context.handle(
        _startTimeMeta,
        startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta),
      );
    }
    if (data.containsKey('end_time')) {
      context.handle(
        _endTimeMeta,
        endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta),
      );
    }
    if (data.containsKey('duration_minutes')) {
      context.handle(
        _durationMinutesMeta,
        durationMinutes.isAcceptableOrUnknown(
          data['duration_minutes']!,
          _durationMinutesMeta,
        ),
      );
    }
    if (data.containsKey('estimated_remaining_range')) {
      context.handle(
        _estimatedRemainingRangeMeta,
        estimatedRemainingRange.isAcceptableOrUnknown(
          data['estimated_remaining_range']!,
          _estimatedRemainingRangeMeta,
        ),
      );
    }
    if (data.containsKey('average_speed')) {
      context.handle(
        _averageSpeedMeta,
        averageSpeed.isAcceptableOrUnknown(
          data['average_speed']!,
          _averageSpeedMeta,
        ),
      );
    }
    if (data.containsKey('max_speed')) {
      context.handle(
        _maxSpeedMeta,
        maxSpeed.isAcceptableOrUnknown(data['max_speed']!, _maxSpeedMeta),
      );
    }
    if (data.containsKey('weather')) {
      context.handle(
        _weatherMeta,
        weather.isAcceptableOrUnknown(data['weather']!, _weatherMeta),
      );
    }
    if (data.containsKey('road_type')) {
      context.handle(
        _roadTypeMeta,
        roadType.isAcceptableOrUnknown(data['road_type']!, _roadTypeMeta),
      );
    }
    if (data.containsKey('passenger_count')) {
      context.handle(
        _passengerCountMeta,
        passengerCount.isAcceptableOrUnknown(
          data['passenger_count']!,
          _passengerCountMeta,
        ),
      );
    }
    if (data.containsKey('ride_purpose')) {
      context.handle(
        _ridePurposeMeta,
        ridePurpose.isAcceptableOrUnknown(
          data['ride_purpose']!,
          _ridePurposeMeta,
        ),
      );
    }
    if (data.containsKey('start_location')) {
      context.handle(
        _startLocationMeta,
        startLocation.isAcceptableOrUnknown(
          data['start_location']!,
          _startLocationMeta,
        ),
      );
    }
    if (data.containsKey('end_location')) {
      context.handle(
        _endLocationMeta,
        endLocation.isAcceptableOrUnknown(
          data['end_location']!,
          _endLocationMeta,
        ),
      );
    }
    if (data.containsKey('route_notes')) {
      context.handle(
        _routeNotesMeta,
        routeNotes.isAcceptableOrUnknown(data['route_notes']!, _routeNotesMeta),
      );
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    if (data.containsKey('bike_id')) {
      context.handle(
        _bikeIdMeta,
        bikeId.isAcceptableOrUnknown(data['bike_id']!, _bikeIdMeta),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RidesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RidesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      startOdometer: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}start_odometer'],
      )!,
      endOdometer: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}end_odometer'],
      )!,
      batteryBefore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}battery_before'],
      )!,
      batteryAfter: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}battery_after'],
      )!,
      rideMode: $RidesTableTable.$converterrideMode.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}ride_mode'],
        )!,
      ),
      roadCondition: $RidesTableTable.$converterroadCondition.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}road_condition'],
        )!,
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      photoPaths: $RidesTableTable.$converterphotoPaths.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}photo_paths'],
        )!,
      ),
      startTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_time'],
      ),
      endTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_time'],
      ),
      durationMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_minutes'],
      ),
      estimatedRemainingRange: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}estimated_remaining_range'],
      ),
      averageSpeed: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}average_speed'],
      ),
      maxSpeed: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}max_speed'],
      ),
      weather: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}weather'],
      ),
      roadType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}road_type'],
      ),
      passengerCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}passenger_count'],
      ),
      ridePurpose: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ride_purpose'],
      ),
      startLocation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}start_location'],
      ),
      endLocation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}end_location'],
      ),
      routeNotes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}route_notes'],
      ),
      customTags: $RidesTableTable.$convertercustomTags.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}custom_tags'],
        )!,
      ),
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
      bikeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bike_id'],
      ),
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
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
  static TypeConverter<List<String>, String> $convertercustomTags =
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
  final DateTime? startTime;
  final DateTime? endTime;
  final int? durationMinutes;
  final double? estimatedRemainingRange;
  final double? averageSpeed;
  final double? maxSpeed;
  final String? weather;
  final String? roadType;
  final int? passengerCount;
  final String? ridePurpose;
  final String? startLocation;
  final String? endLocation;
  final String? routeNotes;
  final List<String> customTags;
  final bool isFavorite;
  final int? bikeId;
  final String source;
  const RidesTableData({
    required this.id,
    required this.date,
    required this.startOdometer,
    required this.endOdometer,
    required this.batteryBefore,
    required this.batteryAfter,
    required this.rideMode,
    required this.roadCondition,
    this.notes,
    required this.photoPaths,
    this.startTime,
    this.endTime,
    this.durationMinutes,
    this.estimatedRemainingRange,
    this.averageSpeed,
    this.maxSpeed,
    this.weather,
    this.roadType,
    this.passengerCount,
    this.ridePurpose,
    this.startLocation,
    this.endLocation,
    this.routeNotes,
    required this.customTags,
    required this.isFavorite,
    this.bikeId,
    required this.source,
  });
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
      map['ride_mode'] = Variable<int>(
        $RidesTableTable.$converterrideMode.toSql(rideMode),
      );
    }
    {
      map['road_condition'] = Variable<int>(
        $RidesTableTable.$converterroadCondition.toSql(roadCondition),
      );
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    {
      map['photo_paths'] = Variable<String>(
        $RidesTableTable.$converterphotoPaths.toSql(photoPaths),
      );
    }
    if (!nullToAbsent || startTime != null) {
      map['start_time'] = Variable<DateTime>(startTime);
    }
    if (!nullToAbsent || endTime != null) {
      map['end_time'] = Variable<DateTime>(endTime);
    }
    if (!nullToAbsent || durationMinutes != null) {
      map['duration_minutes'] = Variable<int>(durationMinutes);
    }
    if (!nullToAbsent || estimatedRemainingRange != null) {
      map['estimated_remaining_range'] = Variable<double>(
        estimatedRemainingRange,
      );
    }
    if (!nullToAbsent || averageSpeed != null) {
      map['average_speed'] = Variable<double>(averageSpeed);
    }
    if (!nullToAbsent || maxSpeed != null) {
      map['max_speed'] = Variable<double>(maxSpeed);
    }
    if (!nullToAbsent || weather != null) {
      map['weather'] = Variable<String>(weather);
    }
    if (!nullToAbsent || roadType != null) {
      map['road_type'] = Variable<String>(roadType);
    }
    if (!nullToAbsent || passengerCount != null) {
      map['passenger_count'] = Variable<int>(passengerCount);
    }
    if (!nullToAbsent || ridePurpose != null) {
      map['ride_purpose'] = Variable<String>(ridePurpose);
    }
    if (!nullToAbsent || startLocation != null) {
      map['start_location'] = Variable<String>(startLocation);
    }
    if (!nullToAbsent || endLocation != null) {
      map['end_location'] = Variable<String>(endLocation);
    }
    if (!nullToAbsent || routeNotes != null) {
      map['route_notes'] = Variable<String>(routeNotes);
    }
    {
      map['custom_tags'] = Variable<String>(
        $RidesTableTable.$convertercustomTags.toSql(customTags),
      );
    }
    map['is_favorite'] = Variable<bool>(isFavorite);
    if (!nullToAbsent || bikeId != null) {
      map['bike_id'] = Variable<int>(bikeId);
    }
    map['source'] = Variable<String>(source);
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
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      photoPaths: Value(photoPaths),
      startTime: startTime == null && nullToAbsent
          ? const Value.absent()
          : Value(startTime),
      endTime: endTime == null && nullToAbsent
          ? const Value.absent()
          : Value(endTime),
      durationMinutes: durationMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(durationMinutes),
      estimatedRemainingRange: estimatedRemainingRange == null && nullToAbsent
          ? const Value.absent()
          : Value(estimatedRemainingRange),
      averageSpeed: averageSpeed == null && nullToAbsent
          ? const Value.absent()
          : Value(averageSpeed),
      maxSpeed: maxSpeed == null && nullToAbsent
          ? const Value.absent()
          : Value(maxSpeed),
      weather: weather == null && nullToAbsent
          ? const Value.absent()
          : Value(weather),
      roadType: roadType == null && nullToAbsent
          ? const Value.absent()
          : Value(roadType),
      passengerCount: passengerCount == null && nullToAbsent
          ? const Value.absent()
          : Value(passengerCount),
      ridePurpose: ridePurpose == null && nullToAbsent
          ? const Value.absent()
          : Value(ridePurpose),
      startLocation: startLocation == null && nullToAbsent
          ? const Value.absent()
          : Value(startLocation),
      endLocation: endLocation == null && nullToAbsent
          ? const Value.absent()
          : Value(endLocation),
      routeNotes: routeNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(routeNotes),
      customTags: Value(customTags),
      isFavorite: Value(isFavorite),
      bikeId: bikeId == null && nullToAbsent
          ? const Value.absent()
          : Value(bikeId),
      source: Value(source),
    );
  }

  factory RidesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RidesTableData(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      startOdometer: serializer.fromJson<double>(json['startOdometer']),
      endOdometer: serializer.fromJson<double>(json['endOdometer']),
      batteryBefore: serializer.fromJson<int>(json['batteryBefore']),
      batteryAfter: serializer.fromJson<int>(json['batteryAfter']),
      rideMode: $RidesTableTable.$converterrideMode.fromJson(
        serializer.fromJson<int>(json['rideMode']),
      ),
      roadCondition: $RidesTableTable.$converterroadCondition.fromJson(
        serializer.fromJson<int>(json['roadCondition']),
      ),
      notes: serializer.fromJson<String?>(json['notes']),
      photoPaths: serializer.fromJson<List<String>>(json['photoPaths']),
      startTime: serializer.fromJson<DateTime?>(json['startTime']),
      endTime: serializer.fromJson<DateTime?>(json['endTime']),
      durationMinutes: serializer.fromJson<int?>(json['durationMinutes']),
      estimatedRemainingRange: serializer.fromJson<double?>(
        json['estimatedRemainingRange'],
      ),
      averageSpeed: serializer.fromJson<double?>(json['averageSpeed']),
      maxSpeed: serializer.fromJson<double?>(json['maxSpeed']),
      weather: serializer.fromJson<String?>(json['weather']),
      roadType: serializer.fromJson<String?>(json['roadType']),
      passengerCount: serializer.fromJson<int?>(json['passengerCount']),
      ridePurpose: serializer.fromJson<String?>(json['ridePurpose']),
      startLocation: serializer.fromJson<String?>(json['startLocation']),
      endLocation: serializer.fromJson<String?>(json['endLocation']),
      routeNotes: serializer.fromJson<String?>(json['routeNotes']),
      customTags: serializer.fromJson<List<String>>(json['customTags']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      bikeId: serializer.fromJson<int?>(json['bikeId']),
      source: serializer.fromJson<String>(json['source']),
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
      'rideMode': serializer.toJson<int>(
        $RidesTableTable.$converterrideMode.toJson(rideMode),
      ),
      'roadCondition': serializer.toJson<int>(
        $RidesTableTable.$converterroadCondition.toJson(roadCondition),
      ),
      'notes': serializer.toJson<String?>(notes),
      'photoPaths': serializer.toJson<List<String>>(photoPaths),
      'startTime': serializer.toJson<DateTime?>(startTime),
      'endTime': serializer.toJson<DateTime?>(endTime),
      'durationMinutes': serializer.toJson<int?>(durationMinutes),
      'estimatedRemainingRange': serializer.toJson<double?>(
        estimatedRemainingRange,
      ),
      'averageSpeed': serializer.toJson<double?>(averageSpeed),
      'maxSpeed': serializer.toJson<double?>(maxSpeed),
      'weather': serializer.toJson<String?>(weather),
      'roadType': serializer.toJson<String?>(roadType),
      'passengerCount': serializer.toJson<int?>(passengerCount),
      'ridePurpose': serializer.toJson<String?>(ridePurpose),
      'startLocation': serializer.toJson<String?>(startLocation),
      'endLocation': serializer.toJson<String?>(endLocation),
      'routeNotes': serializer.toJson<String?>(routeNotes),
      'customTags': serializer.toJson<List<String>>(customTags),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'bikeId': serializer.toJson<int?>(bikeId),
      'source': serializer.toJson<String>(source),
    };
  }

  RidesTableData copyWith({
    String? id,
    DateTime? date,
    double? startOdometer,
    double? endOdometer,
    int? batteryBefore,
    int? batteryAfter,
    RideMode? rideMode,
    RoadCondition? roadCondition,
    Value<String?> notes = const Value.absent(),
    List<String>? photoPaths,
    Value<DateTime?> startTime = const Value.absent(),
    Value<DateTime?> endTime = const Value.absent(),
    Value<int?> durationMinutes = const Value.absent(),
    Value<double?> estimatedRemainingRange = const Value.absent(),
    Value<double?> averageSpeed = const Value.absent(),
    Value<double?> maxSpeed = const Value.absent(),
    Value<String?> weather = const Value.absent(),
    Value<String?> roadType = const Value.absent(),
    Value<int?> passengerCount = const Value.absent(),
    Value<String?> ridePurpose = const Value.absent(),
    Value<String?> startLocation = const Value.absent(),
    Value<String?> endLocation = const Value.absent(),
    Value<String?> routeNotes = const Value.absent(),
    List<String>? customTags,
    bool? isFavorite,
    Value<int?> bikeId = const Value.absent(),
    String? source,
  }) => RidesTableData(
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
    startTime: startTime.present ? startTime.value : this.startTime,
    endTime: endTime.present ? endTime.value : this.endTime,
    durationMinutes: durationMinutes.present
        ? durationMinutes.value
        : this.durationMinutes,
    estimatedRemainingRange: estimatedRemainingRange.present
        ? estimatedRemainingRange.value
        : this.estimatedRemainingRange,
    averageSpeed: averageSpeed.present ? averageSpeed.value : this.averageSpeed,
    maxSpeed: maxSpeed.present ? maxSpeed.value : this.maxSpeed,
    weather: weather.present ? weather.value : this.weather,
    roadType: roadType.present ? roadType.value : this.roadType,
    passengerCount: passengerCount.present
        ? passengerCount.value
        : this.passengerCount,
    ridePurpose: ridePurpose.present ? ridePurpose.value : this.ridePurpose,
    startLocation: startLocation.present
        ? startLocation.value
        : this.startLocation,
    endLocation: endLocation.present ? endLocation.value : this.endLocation,
    routeNotes: routeNotes.present ? routeNotes.value : this.routeNotes,
    customTags: customTags ?? this.customTags,
    isFavorite: isFavorite ?? this.isFavorite,
    bikeId: bikeId.present ? bikeId.value : this.bikeId,
    source: source ?? this.source,
  );
  RidesTableData copyWithCompanion(RidesTableCompanion data) {
    return RidesTableData(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      startOdometer: data.startOdometer.present
          ? data.startOdometer.value
          : this.startOdometer,
      endOdometer: data.endOdometer.present
          ? data.endOdometer.value
          : this.endOdometer,
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
      photoPaths: data.photoPaths.present
          ? data.photoPaths.value
          : this.photoPaths,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      durationMinutes: data.durationMinutes.present
          ? data.durationMinutes.value
          : this.durationMinutes,
      estimatedRemainingRange: data.estimatedRemainingRange.present
          ? data.estimatedRemainingRange.value
          : this.estimatedRemainingRange,
      averageSpeed: data.averageSpeed.present
          ? data.averageSpeed.value
          : this.averageSpeed,
      maxSpeed: data.maxSpeed.present ? data.maxSpeed.value : this.maxSpeed,
      weather: data.weather.present ? data.weather.value : this.weather,
      roadType: data.roadType.present ? data.roadType.value : this.roadType,
      passengerCount: data.passengerCount.present
          ? data.passengerCount.value
          : this.passengerCount,
      ridePurpose: data.ridePurpose.present
          ? data.ridePurpose.value
          : this.ridePurpose,
      startLocation: data.startLocation.present
          ? data.startLocation.value
          : this.startLocation,
      endLocation: data.endLocation.present
          ? data.endLocation.value
          : this.endLocation,
      routeNotes: data.routeNotes.present
          ? data.routeNotes.value
          : this.routeNotes,
      customTags: data.customTags.present
          ? data.customTags.value
          : this.customTags,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
      bikeId: data.bikeId.present ? data.bikeId.value : this.bikeId,
      source: data.source.present ? data.source.value : this.source,
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
          ..write('photoPaths: $photoPaths, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('estimatedRemainingRange: $estimatedRemainingRange, ')
          ..write('averageSpeed: $averageSpeed, ')
          ..write('maxSpeed: $maxSpeed, ')
          ..write('weather: $weather, ')
          ..write('roadType: $roadType, ')
          ..write('passengerCount: $passengerCount, ')
          ..write('ridePurpose: $ridePurpose, ')
          ..write('startLocation: $startLocation, ')
          ..write('endLocation: $endLocation, ')
          ..write('routeNotes: $routeNotes, ')
          ..write('customTags: $customTags, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('bikeId: $bikeId, ')
          ..write('source: $source')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    date,
    startOdometer,
    endOdometer,
    batteryBefore,
    batteryAfter,
    rideMode,
    roadCondition,
    notes,
    photoPaths,
    startTime,
    endTime,
    durationMinutes,
    estimatedRemainingRange,
    averageSpeed,
    maxSpeed,
    weather,
    roadType,
    passengerCount,
    ridePurpose,
    startLocation,
    endLocation,
    routeNotes,
    customTags,
    isFavorite,
    bikeId,
    source,
  ]);
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
          other.photoPaths == this.photoPaths &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.durationMinutes == this.durationMinutes &&
          other.estimatedRemainingRange == this.estimatedRemainingRange &&
          other.averageSpeed == this.averageSpeed &&
          other.maxSpeed == this.maxSpeed &&
          other.weather == this.weather &&
          other.roadType == this.roadType &&
          other.passengerCount == this.passengerCount &&
          other.ridePurpose == this.ridePurpose &&
          other.startLocation == this.startLocation &&
          other.endLocation == this.endLocation &&
          other.routeNotes == this.routeNotes &&
          other.customTags == this.customTags &&
          other.isFavorite == this.isFavorite &&
          other.bikeId == this.bikeId &&
          other.source == this.source);
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
  final Value<DateTime?> startTime;
  final Value<DateTime?> endTime;
  final Value<int?> durationMinutes;
  final Value<double?> estimatedRemainingRange;
  final Value<double?> averageSpeed;
  final Value<double?> maxSpeed;
  final Value<String?> weather;
  final Value<String?> roadType;
  final Value<int?> passengerCount;
  final Value<String?> ridePurpose;
  final Value<String?> startLocation;
  final Value<String?> endLocation;
  final Value<String?> routeNotes;
  final Value<List<String>> customTags;
  final Value<bool> isFavorite;
  final Value<int?> bikeId;
  final Value<String> source;
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
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.estimatedRemainingRange = const Value.absent(),
    this.averageSpeed = const Value.absent(),
    this.maxSpeed = const Value.absent(),
    this.weather = const Value.absent(),
    this.roadType = const Value.absent(),
    this.passengerCount = const Value.absent(),
    this.ridePurpose = const Value.absent(),
    this.startLocation = const Value.absent(),
    this.endLocation = const Value.absent(),
    this.routeNotes = const Value.absent(),
    this.customTags = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.bikeId = const Value.absent(),
    this.source = const Value.absent(),
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
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.estimatedRemainingRange = const Value.absent(),
    this.averageSpeed = const Value.absent(),
    this.maxSpeed = const Value.absent(),
    this.weather = const Value.absent(),
    this.roadType = const Value.absent(),
    this.passengerCount = const Value.absent(),
    this.ridePurpose = const Value.absent(),
    this.startLocation = const Value.absent(),
    this.endLocation = const Value.absent(),
    this.routeNotes = const Value.absent(),
    this.customTags = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.bikeId = const Value.absent(),
    this.source = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
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
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<int>? durationMinutes,
    Expression<double>? estimatedRemainingRange,
    Expression<double>? averageSpeed,
    Expression<double>? maxSpeed,
    Expression<String>? weather,
    Expression<String>? roadType,
    Expression<int>? passengerCount,
    Expression<String>? ridePurpose,
    Expression<String>? startLocation,
    Expression<String>? endLocation,
    Expression<String>? routeNotes,
    Expression<String>? customTags,
    Expression<bool>? isFavorite,
    Expression<int>? bikeId,
    Expression<String>? source,
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
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (durationMinutes != null) 'duration_minutes': durationMinutes,
      if (estimatedRemainingRange != null)
        'estimated_remaining_range': estimatedRemainingRange,
      if (averageSpeed != null) 'average_speed': averageSpeed,
      if (maxSpeed != null) 'max_speed': maxSpeed,
      if (weather != null) 'weather': weather,
      if (roadType != null) 'road_type': roadType,
      if (passengerCount != null) 'passenger_count': passengerCount,
      if (ridePurpose != null) 'ride_purpose': ridePurpose,
      if (startLocation != null) 'start_location': startLocation,
      if (endLocation != null) 'end_location': endLocation,
      if (routeNotes != null) 'route_notes': routeNotes,
      if (customTags != null) 'custom_tags': customTags,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (bikeId != null) 'bike_id': bikeId,
      if (source != null) 'source': source,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RidesTableCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? date,
    Value<double>? startOdometer,
    Value<double>? endOdometer,
    Value<int>? batteryBefore,
    Value<int>? batteryAfter,
    Value<RideMode>? rideMode,
    Value<RoadCondition>? roadCondition,
    Value<String?>? notes,
    Value<List<String>>? photoPaths,
    Value<DateTime?>? startTime,
    Value<DateTime?>? endTime,
    Value<int?>? durationMinutes,
    Value<double?>? estimatedRemainingRange,
    Value<double?>? averageSpeed,
    Value<double?>? maxSpeed,
    Value<String?>? weather,
    Value<String?>? roadType,
    Value<int?>? passengerCount,
    Value<String?>? ridePurpose,
    Value<String?>? startLocation,
    Value<String?>? endLocation,
    Value<String?>? routeNotes,
    Value<List<String>>? customTags,
    Value<bool>? isFavorite,
    Value<int?>? bikeId,
    Value<String>? source,
    Value<int>? rowid,
  }) {
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
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      estimatedRemainingRange:
          estimatedRemainingRange ?? this.estimatedRemainingRange,
      averageSpeed: averageSpeed ?? this.averageSpeed,
      maxSpeed: maxSpeed ?? this.maxSpeed,
      weather: weather ?? this.weather,
      roadType: roadType ?? this.roadType,
      passengerCount: passengerCount ?? this.passengerCount,
      ridePurpose: ridePurpose ?? this.ridePurpose,
      startLocation: startLocation ?? this.startLocation,
      endLocation: endLocation ?? this.endLocation,
      routeNotes: routeNotes ?? this.routeNotes,
      customTags: customTags ?? this.customTags,
      isFavorite: isFavorite ?? this.isFavorite,
      bikeId: bikeId ?? this.bikeId,
      source: source ?? this.source,
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
        $RidesTableTable.$converterrideMode.toSql(rideMode.value),
      );
    }
    if (roadCondition.present) {
      map['road_condition'] = Variable<int>(
        $RidesTableTable.$converterroadCondition.toSql(roadCondition.value),
      );
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (photoPaths.present) {
      map['photo_paths'] = Variable<String>(
        $RidesTableTable.$converterphotoPaths.toSql(photoPaths.value),
      );
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    if (durationMinutes.present) {
      map['duration_minutes'] = Variable<int>(durationMinutes.value);
    }
    if (estimatedRemainingRange.present) {
      map['estimated_remaining_range'] = Variable<double>(
        estimatedRemainingRange.value,
      );
    }
    if (averageSpeed.present) {
      map['average_speed'] = Variable<double>(averageSpeed.value);
    }
    if (maxSpeed.present) {
      map['max_speed'] = Variable<double>(maxSpeed.value);
    }
    if (weather.present) {
      map['weather'] = Variable<String>(weather.value);
    }
    if (roadType.present) {
      map['road_type'] = Variable<String>(roadType.value);
    }
    if (passengerCount.present) {
      map['passenger_count'] = Variable<int>(passengerCount.value);
    }
    if (ridePurpose.present) {
      map['ride_purpose'] = Variable<String>(ridePurpose.value);
    }
    if (startLocation.present) {
      map['start_location'] = Variable<String>(startLocation.value);
    }
    if (endLocation.present) {
      map['end_location'] = Variable<String>(endLocation.value);
    }
    if (routeNotes.present) {
      map['route_notes'] = Variable<String>(routeNotes.value);
    }
    if (customTags.present) {
      map['custom_tags'] = Variable<String>(
        $RidesTableTable.$convertercustomTags.toSql(customTags.value),
      );
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (bikeId.present) {
      map['bike_id'] = Variable<int>(bikeId.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
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
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('estimatedRemainingRange: $estimatedRemainingRange, ')
          ..write('averageSpeed: $averageSpeed, ')
          ..write('maxSpeed: $maxSpeed, ')
          ..write('weather: $weather, ')
          ..write('roadType: $roadType, ')
          ..write('passengerCount: $passengerCount, ')
          ..write('ridePurpose: $ridePurpose, ')
          ..write('startLocation: $startLocation, ')
          ..write('endLocation: $endLocation, ')
          ..write('routeNotes: $routeNotes, ')
          ..write('customTags: $customTags, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('bikeId: $bikeId, ')
          ..write('source: $source, ')
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
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationMinutesMeta = const VerificationMeta(
    'durationMinutes',
  );
  @override
  late final GeneratedColumn<double> durationMinutes = GeneratedColumn<double>(
    'duration_minutes',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kwhAddedMeta = const VerificationMeta(
    'kwhAdded',
  );
  @override
  late final GeneratedColumn<double> kwhAdded = GeneratedColumn<double>(
    'kwh_added',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _costMeta = const VerificationMeta('cost');
  @override
  late final GeneratedColumn<double> cost = GeneratedColumn<double>(
    'cost',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<PaymentMethod, int>
  paymentMethod = GeneratedColumn<int>(
    'payment_method',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  ).withConverter<PaymentMethod>($ChargeLogsTableTable.$converterpaymentMethod);
  @override
  late final GeneratedColumnWithTypeConverter<LocationType, int> locationType =
      GeneratedColumn<int>(
        'location_type',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<LocationType>(
        $ChargeLogsTableTable.$converterlocationType,
      );
  static const VerificationMeta _startBatteryMeta = const VerificationMeta(
    'startBattery',
  );
  @override
  late final GeneratedColumn<int> startBattery = GeneratedColumn<int>(
    'start_battery',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endBatteryMeta = const VerificationMeta(
    'endBattery',
  );
  @override
  late final GeneratedColumn<int> endBattery = GeneratedColumn<int>(
    'end_battery',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _locationNameMeta = const VerificationMeta(
    'locationName',
  );
  @override
  late final GeneratedColumn<String> locationName = GeneratedColumn<String>(
    'location_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startTimeMeta = const VerificationMeta(
    'startTime',
  );
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
    'start_time',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endTimeMeta = const VerificationMeta(
    'endTime',
  );
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
    'end_time',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _chargerTypeMeta = const VerificationMeta(
    'chargerType',
  );
  @override
  late final GeneratedColumn<String> chargerType = GeneratedColumn<String>(
    'charger_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _chargingMethodMeta = const VerificationMeta(
    'chargingMethod',
  );
  @override
  late final GeneratedColumn<String> chargingMethod = GeneratedColumn<String>(
    'charging_method',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _electricityPriceMeta = const VerificationMeta(
    'electricityPrice',
  );
  @override
  late final GeneratedColumn<double> electricityPrice = GeneratedColumn<double>(
    'electricity_price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String> photoPaths =
      GeneratedColumn<String>(
        'photo_paths',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant(''),
      ).withConverter<List<String>>($ChargeLogsTableTable.$converterphotoPaths);
  static const VerificationMeta _bikeIdMeta = const VerificationMeta('bikeId');
  @override
  late final GeneratedColumn<int> bikeId = GeneratedColumn<int>(
    'bike_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _providerNameMeta = const VerificationMeta(
    'providerName',
  );
  @override
  late final GeneratedColumn<String> providerName = GeneratedColumn<String>(
    'provider_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _maxChargingPowerKwMeta =
      const VerificationMeta('maxChargingPowerKw');
  @override
  late final GeneratedColumn<double> maxChargingPowerKw =
      GeneratedColumn<double>(
        'max_charging_power_kw',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('manual'),
  );
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
    notes,
    startTime,
    endTime,
    chargerType,
    chargingMethod,
    electricityPrice,
    photoPaths,
    bikeId,
    providerName,
    maxChargingPowerKw,
    source,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'charge_logs_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChargeLogsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('duration_minutes')) {
      context.handle(
        _durationMinutesMeta,
        durationMinutes.isAcceptableOrUnknown(
          data['duration_minutes']!,
          _durationMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationMinutesMeta);
    }
    if (data.containsKey('kwh_added')) {
      context.handle(
        _kwhAddedMeta,
        kwhAdded.isAcceptableOrUnknown(data['kwh_added']!, _kwhAddedMeta),
      );
    } else if (isInserting) {
      context.missing(_kwhAddedMeta);
    }
    if (data.containsKey('cost')) {
      context.handle(
        _costMeta,
        cost.isAcceptableOrUnknown(data['cost']!, _costMeta),
      );
    } else if (isInserting) {
      context.missing(_costMeta);
    }
    if (data.containsKey('start_battery')) {
      context.handle(
        _startBatteryMeta,
        startBattery.isAcceptableOrUnknown(
          data['start_battery']!,
          _startBatteryMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_startBatteryMeta);
    }
    if (data.containsKey('end_battery')) {
      context.handle(
        _endBatteryMeta,
        endBattery.isAcceptableOrUnknown(data['end_battery']!, _endBatteryMeta),
      );
    } else if (isInserting) {
      context.missing(_endBatteryMeta);
    }
    if (data.containsKey('location_name')) {
      context.handle(
        _locationNameMeta,
        locationName.isAcceptableOrUnknown(
          data['location_name']!,
          _locationNameMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('start_time')) {
      context.handle(
        _startTimeMeta,
        startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta),
      );
    }
    if (data.containsKey('end_time')) {
      context.handle(
        _endTimeMeta,
        endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta),
      );
    }
    if (data.containsKey('charger_type')) {
      context.handle(
        _chargerTypeMeta,
        chargerType.isAcceptableOrUnknown(
          data['charger_type']!,
          _chargerTypeMeta,
        ),
      );
    }
    if (data.containsKey('charging_method')) {
      context.handle(
        _chargingMethodMeta,
        chargingMethod.isAcceptableOrUnknown(
          data['charging_method']!,
          _chargingMethodMeta,
        ),
      );
    }
    if (data.containsKey('electricity_price')) {
      context.handle(
        _electricityPriceMeta,
        electricityPrice.isAcceptableOrUnknown(
          data['electricity_price']!,
          _electricityPriceMeta,
        ),
      );
    }
    if (data.containsKey('bike_id')) {
      context.handle(
        _bikeIdMeta,
        bikeId.isAcceptableOrUnknown(data['bike_id']!, _bikeIdMeta),
      );
    }
    if (data.containsKey('provider_name')) {
      context.handle(
        _providerNameMeta,
        providerName.isAcceptableOrUnknown(
          data['provider_name']!,
          _providerNameMeta,
        ),
      );
    }
    if (data.containsKey('max_charging_power_kw')) {
      context.handle(
        _maxChargingPowerKwMeta,
        maxChargingPowerKw.isAcceptableOrUnknown(
          data['max_charging_power_kw']!,
          _maxChargingPowerKwMeta,
        ),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChargeLogsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChargeLogsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      durationMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}duration_minutes'],
      )!,
      kwhAdded: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}kwh_added'],
      )!,
      cost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cost'],
      )!,
      paymentMethod: $ChargeLogsTableTable.$converterpaymentMethod.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}payment_method'],
        )!,
      ),
      locationType: $ChargeLogsTableTable.$converterlocationType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}location_type'],
        )!,
      ),
      startBattery: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}start_battery'],
      )!,
      endBattery: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}end_battery'],
      )!,
      locationName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location_name'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      startTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_time'],
      ),
      endTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_time'],
      ),
      chargerType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}charger_type'],
      ),
      chargingMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}charging_method'],
      ),
      electricityPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}electricity_price'],
      ),
      photoPaths: $ChargeLogsTableTable.$converterphotoPaths.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}photo_paths'],
        )!,
      ),
      bikeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bike_id'],
      ),
      providerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}provider_name'],
      ),
      maxChargingPowerKw: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}max_charging_power_kw'],
      ),
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
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
  static TypeConverter<List<String>, String> $converterphotoPaths =
      const StringListConverter();
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
  final DateTime? startTime;
  final DateTime? endTime;
  final String? chargerType;
  final String? chargingMethod;
  final double? electricityPrice;
  final List<String> photoPaths;
  final int? bikeId;
  final String? providerName;
  final double? maxChargingPowerKw;
  final String source;
  const ChargeLogsTableData({
    required this.id,
    required this.date,
    required this.durationMinutes,
    required this.kwhAdded,
    required this.cost,
    required this.paymentMethod,
    required this.locationType,
    required this.startBattery,
    required this.endBattery,
    this.locationName,
    this.notes,
    this.startTime,
    this.endTime,
    this.chargerType,
    this.chargingMethod,
    this.electricityPrice,
    required this.photoPaths,
    this.bikeId,
    this.providerName,
    this.maxChargingPowerKw,
    required this.source,
  });
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
        $ChargeLogsTableTable.$converterpaymentMethod.toSql(paymentMethod),
      );
    }
    {
      map['location_type'] = Variable<int>(
        $ChargeLogsTableTable.$converterlocationType.toSql(locationType),
      );
    }
    map['start_battery'] = Variable<int>(startBattery);
    map['end_battery'] = Variable<int>(endBattery);
    if (!nullToAbsent || locationName != null) {
      map['location_name'] = Variable<String>(locationName);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || startTime != null) {
      map['start_time'] = Variable<DateTime>(startTime);
    }
    if (!nullToAbsent || endTime != null) {
      map['end_time'] = Variable<DateTime>(endTime);
    }
    if (!nullToAbsent || chargerType != null) {
      map['charger_type'] = Variable<String>(chargerType);
    }
    if (!nullToAbsent || chargingMethod != null) {
      map['charging_method'] = Variable<String>(chargingMethod);
    }
    if (!nullToAbsent || electricityPrice != null) {
      map['electricity_price'] = Variable<double>(electricityPrice);
    }
    {
      map['photo_paths'] = Variable<String>(
        $ChargeLogsTableTable.$converterphotoPaths.toSql(photoPaths),
      );
    }
    if (!nullToAbsent || bikeId != null) {
      map['bike_id'] = Variable<int>(bikeId);
    }
    if (!nullToAbsent || providerName != null) {
      map['provider_name'] = Variable<String>(providerName);
    }
    if (!nullToAbsent || maxChargingPowerKw != null) {
      map['max_charging_power_kw'] = Variable<double>(maxChargingPowerKw);
    }
    map['source'] = Variable<String>(source);
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
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      startTime: startTime == null && nullToAbsent
          ? const Value.absent()
          : Value(startTime),
      endTime: endTime == null && nullToAbsent
          ? const Value.absent()
          : Value(endTime),
      chargerType: chargerType == null && nullToAbsent
          ? const Value.absent()
          : Value(chargerType),
      chargingMethod: chargingMethod == null && nullToAbsent
          ? const Value.absent()
          : Value(chargingMethod),
      electricityPrice: electricityPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(electricityPrice),
      photoPaths: Value(photoPaths),
      bikeId: bikeId == null && nullToAbsent
          ? const Value.absent()
          : Value(bikeId),
      providerName: providerName == null && nullToAbsent
          ? const Value.absent()
          : Value(providerName),
      maxChargingPowerKw: maxChargingPowerKw == null && nullToAbsent
          ? const Value.absent()
          : Value(maxChargingPowerKw),
      source: Value(source),
    );
  }

  factory ChargeLogsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChargeLogsTableData(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      durationMinutes: serializer.fromJson<double>(json['durationMinutes']),
      kwhAdded: serializer.fromJson<double>(json['kwhAdded']),
      cost: serializer.fromJson<double>(json['cost']),
      paymentMethod: $ChargeLogsTableTable.$converterpaymentMethod.fromJson(
        serializer.fromJson<int>(json['paymentMethod']),
      ),
      locationType: $ChargeLogsTableTable.$converterlocationType.fromJson(
        serializer.fromJson<int>(json['locationType']),
      ),
      startBattery: serializer.fromJson<int>(json['startBattery']),
      endBattery: serializer.fromJson<int>(json['endBattery']),
      locationName: serializer.fromJson<String?>(json['locationName']),
      notes: serializer.fromJson<String?>(json['notes']),
      startTime: serializer.fromJson<DateTime?>(json['startTime']),
      endTime: serializer.fromJson<DateTime?>(json['endTime']),
      chargerType: serializer.fromJson<String?>(json['chargerType']),
      chargingMethod: serializer.fromJson<String?>(json['chargingMethod']),
      electricityPrice: serializer.fromJson<double?>(json['electricityPrice']),
      photoPaths: serializer.fromJson<List<String>>(json['photoPaths']),
      bikeId: serializer.fromJson<int?>(json['bikeId']),
      providerName: serializer.fromJson<String?>(json['providerName']),
      maxChargingPowerKw: serializer.fromJson<double?>(
        json['maxChargingPowerKw'],
      ),
      source: serializer.fromJson<String>(json['source']),
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
        $ChargeLogsTableTable.$converterpaymentMethod.toJson(paymentMethod),
      ),
      'locationType': serializer.toJson<int>(
        $ChargeLogsTableTable.$converterlocationType.toJson(locationType),
      ),
      'startBattery': serializer.toJson<int>(startBattery),
      'endBattery': serializer.toJson<int>(endBattery),
      'locationName': serializer.toJson<String?>(locationName),
      'notes': serializer.toJson<String?>(notes),
      'startTime': serializer.toJson<DateTime?>(startTime),
      'endTime': serializer.toJson<DateTime?>(endTime),
      'chargerType': serializer.toJson<String?>(chargerType),
      'chargingMethod': serializer.toJson<String?>(chargingMethod),
      'electricityPrice': serializer.toJson<double?>(electricityPrice),
      'photoPaths': serializer.toJson<List<String>>(photoPaths),
      'bikeId': serializer.toJson<int?>(bikeId),
      'providerName': serializer.toJson<String?>(providerName),
      'maxChargingPowerKw': serializer.toJson<double?>(maxChargingPowerKw),
      'source': serializer.toJson<String>(source),
    };
  }

  ChargeLogsTableData copyWith({
    String? id,
    DateTime? date,
    double? durationMinutes,
    double? kwhAdded,
    double? cost,
    PaymentMethod? paymentMethod,
    LocationType? locationType,
    int? startBattery,
    int? endBattery,
    Value<String?> locationName = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    Value<DateTime?> startTime = const Value.absent(),
    Value<DateTime?> endTime = const Value.absent(),
    Value<String?> chargerType = const Value.absent(),
    Value<String?> chargingMethod = const Value.absent(),
    Value<double?> electricityPrice = const Value.absent(),
    List<String>? photoPaths,
    Value<int?> bikeId = const Value.absent(),
    Value<String?> providerName = const Value.absent(),
    Value<double?> maxChargingPowerKw = const Value.absent(),
    String? source,
  }) => ChargeLogsTableData(
    id: id ?? this.id,
    date: date ?? this.date,
    durationMinutes: durationMinutes ?? this.durationMinutes,
    kwhAdded: kwhAdded ?? this.kwhAdded,
    cost: cost ?? this.cost,
    paymentMethod: paymentMethod ?? this.paymentMethod,
    locationType: locationType ?? this.locationType,
    startBattery: startBattery ?? this.startBattery,
    endBattery: endBattery ?? this.endBattery,
    locationName: locationName.present ? locationName.value : this.locationName,
    notes: notes.present ? notes.value : this.notes,
    startTime: startTime.present ? startTime.value : this.startTime,
    endTime: endTime.present ? endTime.value : this.endTime,
    chargerType: chargerType.present ? chargerType.value : this.chargerType,
    chargingMethod: chargingMethod.present
        ? chargingMethod.value
        : this.chargingMethod,
    electricityPrice: electricityPrice.present
        ? electricityPrice.value
        : this.electricityPrice,
    photoPaths: photoPaths ?? this.photoPaths,
    bikeId: bikeId.present ? bikeId.value : this.bikeId,
    providerName: providerName.present ? providerName.value : this.providerName,
    maxChargingPowerKw: maxChargingPowerKw.present
        ? maxChargingPowerKw.value
        : this.maxChargingPowerKw,
    source: source ?? this.source,
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
      endBattery: data.endBattery.present
          ? data.endBattery.value
          : this.endBattery,
      locationName: data.locationName.present
          ? data.locationName.value
          : this.locationName,
      notes: data.notes.present ? data.notes.value : this.notes,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      chargerType: data.chargerType.present
          ? data.chargerType.value
          : this.chargerType,
      chargingMethod: data.chargingMethod.present
          ? data.chargingMethod.value
          : this.chargingMethod,
      electricityPrice: data.electricityPrice.present
          ? data.electricityPrice.value
          : this.electricityPrice,
      photoPaths: data.photoPaths.present
          ? data.photoPaths.value
          : this.photoPaths,
      bikeId: data.bikeId.present ? data.bikeId.value : this.bikeId,
      providerName: data.providerName.present
          ? data.providerName.value
          : this.providerName,
      maxChargingPowerKw: data.maxChargingPowerKw.present
          ? data.maxChargingPowerKw.value
          : this.maxChargingPowerKw,
      source: data.source.present ? data.source.value : this.source,
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
          ..write('notes: $notes, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('chargerType: $chargerType, ')
          ..write('chargingMethod: $chargingMethod, ')
          ..write('electricityPrice: $electricityPrice, ')
          ..write('photoPaths: $photoPaths, ')
          ..write('bikeId: $bikeId, ')
          ..write('providerName: $providerName, ')
          ..write('maxChargingPowerKw: $maxChargingPowerKw, ')
          ..write('source: $source')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
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
    notes,
    startTime,
    endTime,
    chargerType,
    chargingMethod,
    electricityPrice,
    photoPaths,
    bikeId,
    providerName,
    maxChargingPowerKw,
    source,
  ]);
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
          other.notes == this.notes &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.chargerType == this.chargerType &&
          other.chargingMethod == this.chargingMethod &&
          other.electricityPrice == this.electricityPrice &&
          other.photoPaths == this.photoPaths &&
          other.bikeId == this.bikeId &&
          other.providerName == this.providerName &&
          other.maxChargingPowerKw == this.maxChargingPowerKw &&
          other.source == this.source);
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
  final Value<DateTime?> startTime;
  final Value<DateTime?> endTime;
  final Value<String?> chargerType;
  final Value<String?> chargingMethod;
  final Value<double?> electricityPrice;
  final Value<List<String>> photoPaths;
  final Value<int?> bikeId;
  final Value<String?> providerName;
  final Value<double?> maxChargingPowerKw;
  final Value<String> source;
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
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.chargerType = const Value.absent(),
    this.chargingMethod = const Value.absent(),
    this.electricityPrice = const Value.absent(),
    this.photoPaths = const Value.absent(),
    this.bikeId = const Value.absent(),
    this.providerName = const Value.absent(),
    this.maxChargingPowerKw = const Value.absent(),
    this.source = const Value.absent(),
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
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.chargerType = const Value.absent(),
    this.chargingMethod = const Value.absent(),
    this.electricityPrice = const Value.absent(),
    this.photoPaths = const Value.absent(),
    this.bikeId = const Value.absent(),
    this.providerName = const Value.absent(),
    this.maxChargingPowerKw = const Value.absent(),
    this.source = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
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
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<String>? chargerType,
    Expression<String>? chargingMethod,
    Expression<double>? electricityPrice,
    Expression<String>? photoPaths,
    Expression<int>? bikeId,
    Expression<String>? providerName,
    Expression<double>? maxChargingPowerKw,
    Expression<String>? source,
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
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (chargerType != null) 'charger_type': chargerType,
      if (chargingMethod != null) 'charging_method': chargingMethod,
      if (electricityPrice != null) 'electricity_price': electricityPrice,
      if (photoPaths != null) 'photo_paths': photoPaths,
      if (bikeId != null) 'bike_id': bikeId,
      if (providerName != null) 'provider_name': providerName,
      if (maxChargingPowerKw != null)
        'max_charging_power_kw': maxChargingPowerKw,
      if (source != null) 'source': source,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChargeLogsTableCompanion copyWith({
    Value<String>? id,
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
    Value<DateTime?>? startTime,
    Value<DateTime?>? endTime,
    Value<String?>? chargerType,
    Value<String?>? chargingMethod,
    Value<double?>? electricityPrice,
    Value<List<String>>? photoPaths,
    Value<int?>? bikeId,
    Value<String?>? providerName,
    Value<double?>? maxChargingPowerKw,
    Value<String>? source,
    Value<int>? rowid,
  }) {
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
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      chargerType: chargerType ?? this.chargerType,
      chargingMethod: chargingMethod ?? this.chargingMethod,
      electricityPrice: electricityPrice ?? this.electricityPrice,
      photoPaths: photoPaths ?? this.photoPaths,
      bikeId: bikeId ?? this.bikeId,
      providerName: providerName ?? this.providerName,
      maxChargingPowerKw: maxChargingPowerKw ?? this.maxChargingPowerKw,
      source: source ?? this.source,
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
      map['payment_method'] = Variable<int>(
        $ChargeLogsTableTable.$converterpaymentMethod.toSql(
          paymentMethod.value,
        ),
      );
    }
    if (locationType.present) {
      map['location_type'] = Variable<int>(
        $ChargeLogsTableTable.$converterlocationType.toSql(locationType.value),
      );
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
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    if (chargerType.present) {
      map['charger_type'] = Variable<String>(chargerType.value);
    }
    if (chargingMethod.present) {
      map['charging_method'] = Variable<String>(chargingMethod.value);
    }
    if (electricityPrice.present) {
      map['electricity_price'] = Variable<double>(electricityPrice.value);
    }
    if (photoPaths.present) {
      map['photo_paths'] = Variable<String>(
        $ChargeLogsTableTable.$converterphotoPaths.toSql(photoPaths.value),
      );
    }
    if (bikeId.present) {
      map['bike_id'] = Variable<int>(bikeId.value);
    }
    if (providerName.present) {
      map['provider_name'] = Variable<String>(providerName.value);
    }
    if (maxChargingPowerKw.present) {
      map['max_charging_power_kw'] = Variable<double>(maxChargingPowerKw.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
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
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('chargerType: $chargerType, ')
          ..write('chargingMethod: $chargingMethod, ')
          ..write('electricityPrice: $electricityPrice, ')
          ..write('photoPaths: $photoPaths, ')
          ..write('bikeId: $bikeId, ')
          ..write('providerName: $providerName, ')
          ..write('maxChargingPowerKw: $maxChargingPowerKw, ')
          ..write('source: $source, ')
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
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ExpenseCategory, int> category =
      GeneratedColumn<int>(
        'category',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<ExpenseCategory>($ExpensesTableTable.$convertercategory);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _receiptPhotoPathMeta = const VerificationMeta(
    'receiptPhotoPath',
  );
  @override
  late final GeneratedColumn<String> receiptPhotoPath = GeneratedColumn<String>(
    'receipt_photo_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bikeIdMeta = const VerificationMeta('bikeId');
  @override
  late final GeneratedColumn<int> bikeId = GeneratedColumn<int>(
    'bike_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    category,
    amount,
    notes,
    receiptPhotoPath,
    description,
    bikeId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expenses_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExpensesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('receipt_photo_path')) {
      context.handle(
        _receiptPhotoPathMeta,
        receiptPhotoPath.isAcceptableOrUnknown(
          data['receipt_photo_path']!,
          _receiptPhotoPathMeta,
        ),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('bike_id')) {
      context.handle(
        _bikeIdMeta,
        bikeId.isAcceptableOrUnknown(data['bike_id']!, _bikeIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExpensesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExpensesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      category: $ExpensesTableTable.$convertercategory.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}category'],
        )!,
      ),
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      receiptPhotoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}receipt_photo_path'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      bikeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bike_id'],
      ),
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
  final String? description;
  final int? bikeId;
  const ExpensesTableData({
    required this.id,
    required this.date,
    required this.category,
    required this.amount,
    this.notes,
    this.receiptPhotoPath,
    this.description,
    this.bikeId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<DateTime>(date);
    {
      map['category'] = Variable<int>(
        $ExpensesTableTable.$convertercategory.toSql(category),
      );
    }
    map['amount'] = Variable<double>(amount);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || receiptPhotoPath != null) {
      map['receipt_photo_path'] = Variable<String>(receiptPhotoPath);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || bikeId != null) {
      map['bike_id'] = Variable<int>(bikeId);
    }
    return map;
  }

  ExpensesTableCompanion toCompanion(bool nullToAbsent) {
    return ExpensesTableCompanion(
      id: Value(id),
      date: Value(date),
      category: Value(category),
      amount: Value(amount),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      receiptPhotoPath: receiptPhotoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(receiptPhotoPath),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      bikeId: bikeId == null && nullToAbsent
          ? const Value.absent()
          : Value(bikeId),
    );
  }

  factory ExpensesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExpensesTableData(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      category: $ExpensesTableTable.$convertercategory.fromJson(
        serializer.fromJson<int>(json['category']),
      ),
      amount: serializer.fromJson<double>(json['amount']),
      notes: serializer.fromJson<String?>(json['notes']),
      receiptPhotoPath: serializer.fromJson<String?>(json['receiptPhotoPath']),
      description: serializer.fromJson<String?>(json['description']),
      bikeId: serializer.fromJson<int?>(json['bikeId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<DateTime>(date),
      'category': serializer.toJson<int>(
        $ExpensesTableTable.$convertercategory.toJson(category),
      ),
      'amount': serializer.toJson<double>(amount),
      'notes': serializer.toJson<String?>(notes),
      'receiptPhotoPath': serializer.toJson<String?>(receiptPhotoPath),
      'description': serializer.toJson<String?>(description),
      'bikeId': serializer.toJson<int?>(bikeId),
    };
  }

  ExpensesTableData copyWith({
    String? id,
    DateTime? date,
    ExpenseCategory? category,
    double? amount,
    Value<String?> notes = const Value.absent(),
    Value<String?> receiptPhotoPath = const Value.absent(),
    Value<String?> description = const Value.absent(),
    Value<int?> bikeId = const Value.absent(),
  }) => ExpensesTableData(
    id: id ?? this.id,
    date: date ?? this.date,
    category: category ?? this.category,
    amount: amount ?? this.amount,
    notes: notes.present ? notes.value : this.notes,
    receiptPhotoPath: receiptPhotoPath.present
        ? receiptPhotoPath.value
        : this.receiptPhotoPath,
    description: description.present ? description.value : this.description,
    bikeId: bikeId.present ? bikeId.value : this.bikeId,
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
      description: data.description.present
          ? data.description.value
          : this.description,
      bikeId: data.bikeId.present ? data.bikeId.value : this.bikeId,
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
          ..write('receiptPhotoPath: $receiptPhotoPath, ')
          ..write('description: $description, ')
          ..write('bikeId: $bikeId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    date,
    category,
    amount,
    notes,
    receiptPhotoPath,
    description,
    bikeId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExpensesTableData &&
          other.id == this.id &&
          other.date == this.date &&
          other.category == this.category &&
          other.amount == this.amount &&
          other.notes == this.notes &&
          other.receiptPhotoPath == this.receiptPhotoPath &&
          other.description == this.description &&
          other.bikeId == this.bikeId);
}

class ExpensesTableCompanion extends UpdateCompanion<ExpensesTableData> {
  final Value<String> id;
  final Value<DateTime> date;
  final Value<ExpenseCategory> category;
  final Value<double> amount;
  final Value<String?> notes;
  final Value<String?> receiptPhotoPath;
  final Value<String?> description;
  final Value<int?> bikeId;
  final Value<int> rowid;
  const ExpensesTableCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.category = const Value.absent(),
    this.amount = const Value.absent(),
    this.notes = const Value.absent(),
    this.receiptPhotoPath = const Value.absent(),
    this.description = const Value.absent(),
    this.bikeId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExpensesTableCompanion.insert({
    required String id,
    required DateTime date,
    required ExpenseCategory category,
    required double amount,
    this.notes = const Value.absent(),
    this.receiptPhotoPath = const Value.absent(),
    this.description = const Value.absent(),
    this.bikeId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
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
    Expression<String>? description,
    Expression<int>? bikeId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (category != null) 'category': category,
      if (amount != null) 'amount': amount,
      if (notes != null) 'notes': notes,
      if (receiptPhotoPath != null) 'receipt_photo_path': receiptPhotoPath,
      if (description != null) 'description': description,
      if (bikeId != null) 'bike_id': bikeId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExpensesTableCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? date,
    Value<ExpenseCategory>? category,
    Value<double>? amount,
    Value<String?>? notes,
    Value<String?>? receiptPhotoPath,
    Value<String?>? description,
    Value<int?>? bikeId,
    Value<int>? rowid,
  }) {
    return ExpensesTableCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      notes: notes ?? this.notes,
      receiptPhotoPath: receiptPhotoPath ?? this.receiptPhotoPath,
      description: description ?? this.description,
      bikeId: bikeId ?? this.bikeId,
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
        $ExpensesTableTable.$convertercategory.toSql(category.value),
      );
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
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (bikeId.present) {
      map['bike_id'] = Variable<int>(bikeId.value);
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
          ..write('description: $description, ')
          ..write('bikeId: $bikeId, ')
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
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<MaintenanceComponent, int>
  component =
      GeneratedColumn<int>(
        'component',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<MaintenanceComponent>(
        $MaintenanceLogsTableTable.$convertercomponent,
      );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _odometerReadingMeta = const VerificationMeta(
    'odometerReading',
  );
  @override
  late final GeneratedColumn<double> odometerReading = GeneratedColumn<double>(
    'odometer_reading',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _costMeta = const VerificationMeta('cost');
  @override
  late final GeneratedColumn<double> cost = GeneratedColumn<double>(
    'cost',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serviceCenterMeta = const VerificationMeta(
    'serviceCenter',
  );
  @override
  late final GeneratedColumn<String> serviceCenter = GeneratedColumn<String>(
    'service_center',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _partsReplacedMeta = const VerificationMeta(
    'partsReplaced',
  );
  @override
  late final GeneratedColumn<String> partsReplaced = GeneratedColumn<String>(
    'parts_replaced',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _labourCostMeta = const VerificationMeta(
    'labourCost',
  );
  @override
  late final GeneratedColumn<double> labourCost = GeneratedColumn<double>(
    'labour_cost',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _warrantyClaimMeta = const VerificationMeta(
    'warrantyClaim',
  );
  @override
  late final GeneratedColumn<bool> warrantyClaim = GeneratedColumn<bool>(
    'warranty_claim',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("warranty_claim" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _technicianMeta = const VerificationMeta(
    'technician',
  );
  @override
  late final GeneratedColumn<String> technician = GeneratedColumn<String>(
    'technician',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _invoicePhotoPathMeta = const VerificationMeta(
    'invoicePhotoPath',
  );
  @override
  late final GeneratedColumn<String> invoicePhotoPath = GeneratedColumn<String>(
    'invoice_photo_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nextServiceDueOdometerMeta =
      const VerificationMeta('nextServiceDueOdometer');
  @override
  late final GeneratedColumn<double> nextServiceDueOdometer =
      GeneratedColumn<double>(
        'next_service_due_odometer',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _nextServiceDueDateMeta =
      const VerificationMeta('nextServiceDueDate');
  @override
  late final GeneratedColumn<DateTime> nextServiceDueDate =
      GeneratedColumn<DateTime>(
        'next_service_due_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _tyresMeta = const VerificationMeta('tyres');
  @override
  late final GeneratedColumn<bool> tyres = GeneratedColumn<bool>(
    'tyres',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("tyres" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _brakesMeta = const VerificationMeta('brakes');
  @override
  late final GeneratedColumn<bool> brakes = GeneratedColumn<bool>(
    'brakes',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("brakes" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _batteryMeta = const VerificationMeta(
    'battery',
  );
  @override
  late final GeneratedColumn<bool> battery = GeneratedColumn<bool>(
    'battery',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("battery" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _suspensionMeta = const VerificationMeta(
    'suspension',
  );
  @override
  late final GeneratedColumn<bool> suspension = GeneratedColumn<bool>(
    'suspension',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("suspension" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _motorMeta = const VerificationMeta('motor');
  @override
  late final GeneratedColumn<bool> motor = GeneratedColumn<bool>(
    'motor',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("motor" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _lightsMeta = const VerificationMeta('lights');
  @override
  late final GeneratedColumn<bool> lights = GeneratedColumn<bool>(
    'lights',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("lights" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _hornMeta = const VerificationMeta('horn');
  @override
  late final GeneratedColumn<bool> horn = GeneratedColumn<bool>(
    'horn',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("horn" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _softwareUpdateMeta = const VerificationMeta(
    'softwareUpdate',
  );
  @override
  late final GeneratedColumn<bool> softwareUpdate = GeneratedColumn<bool>(
    'software_update',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("software_update" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _generalInspectionMeta = const VerificationMeta(
    'generalInspection',
  );
  @override
  late final GeneratedColumn<bool> generalInspection = GeneratedColumn<bool>(
    'general_inspection',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("general_inspection" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _bikeIdMeta = const VerificationMeta('bikeId');
  @override
  late final GeneratedColumn<int> bikeId = GeneratedColumn<int>(
    'bike_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    component,
    description,
    odometerReading,
    cost,
    serviceCenter,
    partsReplaced,
    labourCost,
    warrantyClaim,
    technician,
    invoicePhotoPath,
    notes,
    nextServiceDueOdometer,
    nextServiceDueDate,
    tyres,
    brakes,
    battery,
    suspension,
    motor,
    lights,
    horn,
    softwareUpdate,
    generalInspection,
    bikeId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'maintenance_logs_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<MaintenanceLogsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('odometer_reading')) {
      context.handle(
        _odometerReadingMeta,
        odometerReading.isAcceptableOrUnknown(
          data['odometer_reading']!,
          _odometerReadingMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_odometerReadingMeta);
    }
    if (data.containsKey('cost')) {
      context.handle(
        _costMeta,
        cost.isAcceptableOrUnknown(data['cost']!, _costMeta),
      );
    } else if (isInserting) {
      context.missing(_costMeta);
    }
    if (data.containsKey('service_center')) {
      context.handle(
        _serviceCenterMeta,
        serviceCenter.isAcceptableOrUnknown(
          data['service_center']!,
          _serviceCenterMeta,
        ),
      );
    }
    if (data.containsKey('parts_replaced')) {
      context.handle(
        _partsReplacedMeta,
        partsReplaced.isAcceptableOrUnknown(
          data['parts_replaced']!,
          _partsReplacedMeta,
        ),
      );
    }
    if (data.containsKey('labour_cost')) {
      context.handle(
        _labourCostMeta,
        labourCost.isAcceptableOrUnknown(data['labour_cost']!, _labourCostMeta),
      );
    }
    if (data.containsKey('warranty_claim')) {
      context.handle(
        _warrantyClaimMeta,
        warrantyClaim.isAcceptableOrUnknown(
          data['warranty_claim']!,
          _warrantyClaimMeta,
        ),
      );
    }
    if (data.containsKey('technician')) {
      context.handle(
        _technicianMeta,
        technician.isAcceptableOrUnknown(data['technician']!, _technicianMeta),
      );
    }
    if (data.containsKey('invoice_photo_path')) {
      context.handle(
        _invoicePhotoPathMeta,
        invoicePhotoPath.isAcceptableOrUnknown(
          data['invoice_photo_path']!,
          _invoicePhotoPathMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('next_service_due_odometer')) {
      context.handle(
        _nextServiceDueOdometerMeta,
        nextServiceDueOdometer.isAcceptableOrUnknown(
          data['next_service_due_odometer']!,
          _nextServiceDueOdometerMeta,
        ),
      );
    }
    if (data.containsKey('next_service_due_date')) {
      context.handle(
        _nextServiceDueDateMeta,
        nextServiceDueDate.isAcceptableOrUnknown(
          data['next_service_due_date']!,
          _nextServiceDueDateMeta,
        ),
      );
    }
    if (data.containsKey('tyres')) {
      context.handle(
        _tyresMeta,
        tyres.isAcceptableOrUnknown(data['tyres']!, _tyresMeta),
      );
    }
    if (data.containsKey('brakes')) {
      context.handle(
        _brakesMeta,
        brakes.isAcceptableOrUnknown(data['brakes']!, _brakesMeta),
      );
    }
    if (data.containsKey('battery')) {
      context.handle(
        _batteryMeta,
        battery.isAcceptableOrUnknown(data['battery']!, _batteryMeta),
      );
    }
    if (data.containsKey('suspension')) {
      context.handle(
        _suspensionMeta,
        suspension.isAcceptableOrUnknown(data['suspension']!, _suspensionMeta),
      );
    }
    if (data.containsKey('motor')) {
      context.handle(
        _motorMeta,
        motor.isAcceptableOrUnknown(data['motor']!, _motorMeta),
      );
    }
    if (data.containsKey('lights')) {
      context.handle(
        _lightsMeta,
        lights.isAcceptableOrUnknown(data['lights']!, _lightsMeta),
      );
    }
    if (data.containsKey('horn')) {
      context.handle(
        _hornMeta,
        horn.isAcceptableOrUnknown(data['horn']!, _hornMeta),
      );
    }
    if (data.containsKey('software_update')) {
      context.handle(
        _softwareUpdateMeta,
        softwareUpdate.isAcceptableOrUnknown(
          data['software_update']!,
          _softwareUpdateMeta,
        ),
      );
    }
    if (data.containsKey('general_inspection')) {
      context.handle(
        _generalInspectionMeta,
        generalInspection.isAcceptableOrUnknown(
          data['general_inspection']!,
          _generalInspectionMeta,
        ),
      );
    }
    if (data.containsKey('bike_id')) {
      context.handle(
        _bikeIdMeta,
        bikeId.isAcceptableOrUnknown(data['bike_id']!, _bikeIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MaintenanceLogsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MaintenanceLogsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      component: $MaintenanceLogsTableTable.$convertercomponent.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}component'],
        )!,
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      odometerReading: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}odometer_reading'],
      )!,
      cost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cost'],
      )!,
      serviceCenter: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}service_center'],
      ),
      partsReplaced: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parts_replaced'],
      ),
      labourCost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}labour_cost'],
      ),
      warrantyClaim: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}warranty_claim'],
      )!,
      technician: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}technician'],
      ),
      invoicePhotoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_photo_path'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      nextServiceDueOdometer: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}next_service_due_odometer'],
      ),
      nextServiceDueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_service_due_date'],
      ),
      tyres: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}tyres'],
      )!,
      brakes: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}brakes'],
      )!,
      battery: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}battery'],
      )!,
      suspension: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}suspension'],
      )!,
      motor: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}motor'],
      )!,
      lights: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}lights'],
      )!,
      horn: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}horn'],
      )!,
      softwareUpdate: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}software_update'],
      )!,
      generalInspection: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}general_inspection'],
      )!,
      bikeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bike_id'],
      ),
    );
  }

  @override
  $MaintenanceLogsTableTable createAlias(String alias) {
    return $MaintenanceLogsTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<MaintenanceComponent, int, int>
  $convertercomponent = const EnumIndexConverter<MaintenanceComponent>(
    MaintenanceComponent.values,
  );
}

class MaintenanceLogsTableData extends DataClass
    implements Insertable<MaintenanceLogsTableData> {
  final String id;
  final DateTime date;
  final MaintenanceComponent component;
  final String description;
  final double odometerReading;
  final double cost;
  final String? serviceCenter;
  final String? partsReplaced;
  final double? labourCost;
  final bool warrantyClaim;
  final String? technician;
  final String? invoicePhotoPath;
  final String? notes;
  final double? nextServiceDueOdometer;
  final DateTime? nextServiceDueDate;
  final bool tyres;
  final bool brakes;
  final bool battery;
  final bool suspension;
  final bool motor;
  final bool lights;
  final bool horn;
  final bool softwareUpdate;
  final bool generalInspection;
  final int? bikeId;
  const MaintenanceLogsTableData({
    required this.id,
    required this.date,
    required this.component,
    required this.description,
    required this.odometerReading,
    required this.cost,
    this.serviceCenter,
    this.partsReplaced,
    this.labourCost,
    required this.warrantyClaim,
    this.technician,
    this.invoicePhotoPath,
    this.notes,
    this.nextServiceDueOdometer,
    this.nextServiceDueDate,
    required this.tyres,
    required this.brakes,
    required this.battery,
    required this.suspension,
    required this.motor,
    required this.lights,
    required this.horn,
    required this.softwareUpdate,
    required this.generalInspection,
    this.bikeId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<DateTime>(date);
    {
      map['component'] = Variable<int>(
        $MaintenanceLogsTableTable.$convertercomponent.toSql(component),
      );
    }
    map['description'] = Variable<String>(description);
    map['odometer_reading'] = Variable<double>(odometerReading);
    map['cost'] = Variable<double>(cost);
    if (!nullToAbsent || serviceCenter != null) {
      map['service_center'] = Variable<String>(serviceCenter);
    }
    if (!nullToAbsent || partsReplaced != null) {
      map['parts_replaced'] = Variable<String>(partsReplaced);
    }
    if (!nullToAbsent || labourCost != null) {
      map['labour_cost'] = Variable<double>(labourCost);
    }
    map['warranty_claim'] = Variable<bool>(warrantyClaim);
    if (!nullToAbsent || technician != null) {
      map['technician'] = Variable<String>(technician);
    }
    if (!nullToAbsent || invoicePhotoPath != null) {
      map['invoice_photo_path'] = Variable<String>(invoicePhotoPath);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || nextServiceDueOdometer != null) {
      map['next_service_due_odometer'] = Variable<double>(
        nextServiceDueOdometer,
      );
    }
    if (!nullToAbsent || nextServiceDueDate != null) {
      map['next_service_due_date'] = Variable<DateTime>(nextServiceDueDate);
    }
    map['tyres'] = Variable<bool>(tyres);
    map['brakes'] = Variable<bool>(brakes);
    map['battery'] = Variable<bool>(battery);
    map['suspension'] = Variable<bool>(suspension);
    map['motor'] = Variable<bool>(motor);
    map['lights'] = Variable<bool>(lights);
    map['horn'] = Variable<bool>(horn);
    map['software_update'] = Variable<bool>(softwareUpdate);
    map['general_inspection'] = Variable<bool>(generalInspection);
    if (!nullToAbsent || bikeId != null) {
      map['bike_id'] = Variable<int>(bikeId);
    }
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
      serviceCenter: serviceCenter == null && nullToAbsent
          ? const Value.absent()
          : Value(serviceCenter),
      partsReplaced: partsReplaced == null && nullToAbsent
          ? const Value.absent()
          : Value(partsReplaced),
      labourCost: labourCost == null && nullToAbsent
          ? const Value.absent()
          : Value(labourCost),
      warrantyClaim: Value(warrantyClaim),
      technician: technician == null && nullToAbsent
          ? const Value.absent()
          : Value(technician),
      invoicePhotoPath: invoicePhotoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(invoicePhotoPath),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      nextServiceDueOdometer: nextServiceDueOdometer == null && nullToAbsent
          ? const Value.absent()
          : Value(nextServiceDueOdometer),
      nextServiceDueDate: nextServiceDueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(nextServiceDueDate),
      tyres: Value(tyres),
      brakes: Value(brakes),
      battery: Value(battery),
      suspension: Value(suspension),
      motor: Value(motor),
      lights: Value(lights),
      horn: Value(horn),
      softwareUpdate: Value(softwareUpdate),
      generalInspection: Value(generalInspection),
      bikeId: bikeId == null && nullToAbsent
          ? const Value.absent()
          : Value(bikeId),
    );
  }

  factory MaintenanceLogsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MaintenanceLogsTableData(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      component: $MaintenanceLogsTableTable.$convertercomponent.fromJson(
        serializer.fromJson<int>(json['component']),
      ),
      description: serializer.fromJson<String>(json['description']),
      odometerReading: serializer.fromJson<double>(json['odometerReading']),
      cost: serializer.fromJson<double>(json['cost']),
      serviceCenter: serializer.fromJson<String?>(json['serviceCenter']),
      partsReplaced: serializer.fromJson<String?>(json['partsReplaced']),
      labourCost: serializer.fromJson<double?>(json['labourCost']),
      warrantyClaim: serializer.fromJson<bool>(json['warrantyClaim']),
      technician: serializer.fromJson<String?>(json['technician']),
      invoicePhotoPath: serializer.fromJson<String?>(json['invoicePhotoPath']),
      notes: serializer.fromJson<String?>(json['notes']),
      nextServiceDueOdometer: serializer.fromJson<double?>(
        json['nextServiceDueOdometer'],
      ),
      nextServiceDueDate: serializer.fromJson<DateTime?>(
        json['nextServiceDueDate'],
      ),
      tyres: serializer.fromJson<bool>(json['tyres']),
      brakes: serializer.fromJson<bool>(json['brakes']),
      battery: serializer.fromJson<bool>(json['battery']),
      suspension: serializer.fromJson<bool>(json['suspension']),
      motor: serializer.fromJson<bool>(json['motor']),
      lights: serializer.fromJson<bool>(json['lights']),
      horn: serializer.fromJson<bool>(json['horn']),
      softwareUpdate: serializer.fromJson<bool>(json['softwareUpdate']),
      generalInspection: serializer.fromJson<bool>(json['generalInspection']),
      bikeId: serializer.fromJson<int?>(json['bikeId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<DateTime>(date),
      'component': serializer.toJson<int>(
        $MaintenanceLogsTableTable.$convertercomponent.toJson(component),
      ),
      'description': serializer.toJson<String>(description),
      'odometerReading': serializer.toJson<double>(odometerReading),
      'cost': serializer.toJson<double>(cost),
      'serviceCenter': serializer.toJson<String?>(serviceCenter),
      'partsReplaced': serializer.toJson<String?>(partsReplaced),
      'labourCost': serializer.toJson<double?>(labourCost),
      'warrantyClaim': serializer.toJson<bool>(warrantyClaim),
      'technician': serializer.toJson<String?>(technician),
      'invoicePhotoPath': serializer.toJson<String?>(invoicePhotoPath),
      'notes': serializer.toJson<String?>(notes),
      'nextServiceDueOdometer': serializer.toJson<double?>(
        nextServiceDueOdometer,
      ),
      'nextServiceDueDate': serializer.toJson<DateTime?>(nextServiceDueDate),
      'tyres': serializer.toJson<bool>(tyres),
      'brakes': serializer.toJson<bool>(brakes),
      'battery': serializer.toJson<bool>(battery),
      'suspension': serializer.toJson<bool>(suspension),
      'motor': serializer.toJson<bool>(motor),
      'lights': serializer.toJson<bool>(lights),
      'horn': serializer.toJson<bool>(horn),
      'softwareUpdate': serializer.toJson<bool>(softwareUpdate),
      'generalInspection': serializer.toJson<bool>(generalInspection),
      'bikeId': serializer.toJson<int?>(bikeId),
    };
  }

  MaintenanceLogsTableData copyWith({
    String? id,
    DateTime? date,
    MaintenanceComponent? component,
    String? description,
    double? odometerReading,
    double? cost,
    Value<String?> serviceCenter = const Value.absent(),
    Value<String?> partsReplaced = const Value.absent(),
    Value<double?> labourCost = const Value.absent(),
    bool? warrantyClaim,
    Value<String?> technician = const Value.absent(),
    Value<String?> invoicePhotoPath = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    Value<double?> nextServiceDueOdometer = const Value.absent(),
    Value<DateTime?> nextServiceDueDate = const Value.absent(),
    bool? tyres,
    bool? brakes,
    bool? battery,
    bool? suspension,
    bool? motor,
    bool? lights,
    bool? horn,
    bool? softwareUpdate,
    bool? generalInspection,
    Value<int?> bikeId = const Value.absent(),
  }) => MaintenanceLogsTableData(
    id: id ?? this.id,
    date: date ?? this.date,
    component: component ?? this.component,
    description: description ?? this.description,
    odometerReading: odometerReading ?? this.odometerReading,
    cost: cost ?? this.cost,
    serviceCenter: serviceCenter.present
        ? serviceCenter.value
        : this.serviceCenter,
    partsReplaced: partsReplaced.present
        ? partsReplaced.value
        : this.partsReplaced,
    labourCost: labourCost.present ? labourCost.value : this.labourCost,
    warrantyClaim: warrantyClaim ?? this.warrantyClaim,
    technician: technician.present ? technician.value : this.technician,
    invoicePhotoPath: invoicePhotoPath.present
        ? invoicePhotoPath.value
        : this.invoicePhotoPath,
    notes: notes.present ? notes.value : this.notes,
    nextServiceDueOdometer: nextServiceDueOdometer.present
        ? nextServiceDueOdometer.value
        : this.nextServiceDueOdometer,
    nextServiceDueDate: nextServiceDueDate.present
        ? nextServiceDueDate.value
        : this.nextServiceDueDate,
    tyres: tyres ?? this.tyres,
    brakes: brakes ?? this.brakes,
    battery: battery ?? this.battery,
    suspension: suspension ?? this.suspension,
    motor: motor ?? this.motor,
    lights: lights ?? this.lights,
    horn: horn ?? this.horn,
    softwareUpdate: softwareUpdate ?? this.softwareUpdate,
    generalInspection: generalInspection ?? this.generalInspection,
    bikeId: bikeId.present ? bikeId.value : this.bikeId,
  );
  MaintenanceLogsTableData copyWithCompanion(
    MaintenanceLogsTableCompanion data,
  ) {
    return MaintenanceLogsTableData(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      component: data.component.present ? data.component.value : this.component,
      description: data.description.present
          ? data.description.value
          : this.description,
      odometerReading: data.odometerReading.present
          ? data.odometerReading.value
          : this.odometerReading,
      cost: data.cost.present ? data.cost.value : this.cost,
      serviceCenter: data.serviceCenter.present
          ? data.serviceCenter.value
          : this.serviceCenter,
      partsReplaced: data.partsReplaced.present
          ? data.partsReplaced.value
          : this.partsReplaced,
      labourCost: data.labourCost.present
          ? data.labourCost.value
          : this.labourCost,
      warrantyClaim: data.warrantyClaim.present
          ? data.warrantyClaim.value
          : this.warrantyClaim,
      technician: data.technician.present
          ? data.technician.value
          : this.technician,
      invoicePhotoPath: data.invoicePhotoPath.present
          ? data.invoicePhotoPath.value
          : this.invoicePhotoPath,
      notes: data.notes.present ? data.notes.value : this.notes,
      nextServiceDueOdometer: data.nextServiceDueOdometer.present
          ? data.nextServiceDueOdometer.value
          : this.nextServiceDueOdometer,
      nextServiceDueDate: data.nextServiceDueDate.present
          ? data.nextServiceDueDate.value
          : this.nextServiceDueDate,
      tyres: data.tyres.present ? data.tyres.value : this.tyres,
      brakes: data.brakes.present ? data.brakes.value : this.brakes,
      battery: data.battery.present ? data.battery.value : this.battery,
      suspension: data.suspension.present
          ? data.suspension.value
          : this.suspension,
      motor: data.motor.present ? data.motor.value : this.motor,
      lights: data.lights.present ? data.lights.value : this.lights,
      horn: data.horn.present ? data.horn.value : this.horn,
      softwareUpdate: data.softwareUpdate.present
          ? data.softwareUpdate.value
          : this.softwareUpdate,
      generalInspection: data.generalInspection.present
          ? data.generalInspection.value
          : this.generalInspection,
      bikeId: data.bikeId.present ? data.bikeId.value : this.bikeId,
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
          ..write('cost: $cost, ')
          ..write('serviceCenter: $serviceCenter, ')
          ..write('partsReplaced: $partsReplaced, ')
          ..write('labourCost: $labourCost, ')
          ..write('warrantyClaim: $warrantyClaim, ')
          ..write('technician: $technician, ')
          ..write('invoicePhotoPath: $invoicePhotoPath, ')
          ..write('notes: $notes, ')
          ..write('nextServiceDueOdometer: $nextServiceDueOdometer, ')
          ..write('nextServiceDueDate: $nextServiceDueDate, ')
          ..write('tyres: $tyres, ')
          ..write('brakes: $brakes, ')
          ..write('battery: $battery, ')
          ..write('suspension: $suspension, ')
          ..write('motor: $motor, ')
          ..write('lights: $lights, ')
          ..write('horn: $horn, ')
          ..write('softwareUpdate: $softwareUpdate, ')
          ..write('generalInspection: $generalInspection, ')
          ..write('bikeId: $bikeId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    date,
    component,
    description,
    odometerReading,
    cost,
    serviceCenter,
    partsReplaced,
    labourCost,
    warrantyClaim,
    technician,
    invoicePhotoPath,
    notes,
    nextServiceDueOdometer,
    nextServiceDueDate,
    tyres,
    brakes,
    battery,
    suspension,
    motor,
    lights,
    horn,
    softwareUpdate,
    generalInspection,
    bikeId,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MaintenanceLogsTableData &&
          other.id == this.id &&
          other.date == this.date &&
          other.component == this.component &&
          other.description == this.description &&
          other.odometerReading == this.odometerReading &&
          other.cost == this.cost &&
          other.serviceCenter == this.serviceCenter &&
          other.partsReplaced == this.partsReplaced &&
          other.labourCost == this.labourCost &&
          other.warrantyClaim == this.warrantyClaim &&
          other.technician == this.technician &&
          other.invoicePhotoPath == this.invoicePhotoPath &&
          other.notes == this.notes &&
          other.nextServiceDueOdometer == this.nextServiceDueOdometer &&
          other.nextServiceDueDate == this.nextServiceDueDate &&
          other.tyres == this.tyres &&
          other.brakes == this.brakes &&
          other.battery == this.battery &&
          other.suspension == this.suspension &&
          other.motor == this.motor &&
          other.lights == this.lights &&
          other.horn == this.horn &&
          other.softwareUpdate == this.softwareUpdate &&
          other.generalInspection == this.generalInspection &&
          other.bikeId == this.bikeId);
}

class MaintenanceLogsTableCompanion
    extends UpdateCompanion<MaintenanceLogsTableData> {
  final Value<String> id;
  final Value<DateTime> date;
  final Value<MaintenanceComponent> component;
  final Value<String> description;
  final Value<double> odometerReading;
  final Value<double> cost;
  final Value<String?> serviceCenter;
  final Value<String?> partsReplaced;
  final Value<double?> labourCost;
  final Value<bool> warrantyClaim;
  final Value<String?> technician;
  final Value<String?> invoicePhotoPath;
  final Value<String?> notes;
  final Value<double?> nextServiceDueOdometer;
  final Value<DateTime?> nextServiceDueDate;
  final Value<bool> tyres;
  final Value<bool> brakes;
  final Value<bool> battery;
  final Value<bool> suspension;
  final Value<bool> motor;
  final Value<bool> lights;
  final Value<bool> horn;
  final Value<bool> softwareUpdate;
  final Value<bool> generalInspection;
  final Value<int?> bikeId;
  final Value<int> rowid;
  const MaintenanceLogsTableCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.component = const Value.absent(),
    this.description = const Value.absent(),
    this.odometerReading = const Value.absent(),
    this.cost = const Value.absent(),
    this.serviceCenter = const Value.absent(),
    this.partsReplaced = const Value.absent(),
    this.labourCost = const Value.absent(),
    this.warrantyClaim = const Value.absent(),
    this.technician = const Value.absent(),
    this.invoicePhotoPath = const Value.absent(),
    this.notes = const Value.absent(),
    this.nextServiceDueOdometer = const Value.absent(),
    this.nextServiceDueDate = const Value.absent(),
    this.tyres = const Value.absent(),
    this.brakes = const Value.absent(),
    this.battery = const Value.absent(),
    this.suspension = const Value.absent(),
    this.motor = const Value.absent(),
    this.lights = const Value.absent(),
    this.horn = const Value.absent(),
    this.softwareUpdate = const Value.absent(),
    this.generalInspection = const Value.absent(),
    this.bikeId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MaintenanceLogsTableCompanion.insert({
    required String id,
    required DateTime date,
    required MaintenanceComponent component,
    required String description,
    required double odometerReading,
    required double cost,
    this.serviceCenter = const Value.absent(),
    this.partsReplaced = const Value.absent(),
    this.labourCost = const Value.absent(),
    this.warrantyClaim = const Value.absent(),
    this.technician = const Value.absent(),
    this.invoicePhotoPath = const Value.absent(),
    this.notes = const Value.absent(),
    this.nextServiceDueOdometer = const Value.absent(),
    this.nextServiceDueDate = const Value.absent(),
    this.tyres = const Value.absent(),
    this.brakes = const Value.absent(),
    this.battery = const Value.absent(),
    this.suspension = const Value.absent(),
    this.motor = const Value.absent(),
    this.lights = const Value.absent(),
    this.horn = const Value.absent(),
    this.softwareUpdate = const Value.absent(),
    this.generalInspection = const Value.absent(),
    this.bikeId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
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
    Expression<String>? serviceCenter,
    Expression<String>? partsReplaced,
    Expression<double>? labourCost,
    Expression<bool>? warrantyClaim,
    Expression<String>? technician,
    Expression<String>? invoicePhotoPath,
    Expression<String>? notes,
    Expression<double>? nextServiceDueOdometer,
    Expression<DateTime>? nextServiceDueDate,
    Expression<bool>? tyres,
    Expression<bool>? brakes,
    Expression<bool>? battery,
    Expression<bool>? suspension,
    Expression<bool>? motor,
    Expression<bool>? lights,
    Expression<bool>? horn,
    Expression<bool>? softwareUpdate,
    Expression<bool>? generalInspection,
    Expression<int>? bikeId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (component != null) 'component': component,
      if (description != null) 'description': description,
      if (odometerReading != null) 'odometer_reading': odometerReading,
      if (cost != null) 'cost': cost,
      if (serviceCenter != null) 'service_center': serviceCenter,
      if (partsReplaced != null) 'parts_replaced': partsReplaced,
      if (labourCost != null) 'labour_cost': labourCost,
      if (warrantyClaim != null) 'warranty_claim': warrantyClaim,
      if (technician != null) 'technician': technician,
      if (invoicePhotoPath != null) 'invoice_photo_path': invoicePhotoPath,
      if (notes != null) 'notes': notes,
      if (nextServiceDueOdometer != null)
        'next_service_due_odometer': nextServiceDueOdometer,
      if (nextServiceDueDate != null)
        'next_service_due_date': nextServiceDueDate,
      if (tyres != null) 'tyres': tyres,
      if (brakes != null) 'brakes': brakes,
      if (battery != null) 'battery': battery,
      if (suspension != null) 'suspension': suspension,
      if (motor != null) 'motor': motor,
      if (lights != null) 'lights': lights,
      if (horn != null) 'horn': horn,
      if (softwareUpdate != null) 'software_update': softwareUpdate,
      if (generalInspection != null) 'general_inspection': generalInspection,
      if (bikeId != null) 'bike_id': bikeId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MaintenanceLogsTableCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? date,
    Value<MaintenanceComponent>? component,
    Value<String>? description,
    Value<double>? odometerReading,
    Value<double>? cost,
    Value<String?>? serviceCenter,
    Value<String?>? partsReplaced,
    Value<double?>? labourCost,
    Value<bool>? warrantyClaim,
    Value<String?>? technician,
    Value<String?>? invoicePhotoPath,
    Value<String?>? notes,
    Value<double?>? nextServiceDueOdometer,
    Value<DateTime?>? nextServiceDueDate,
    Value<bool>? tyres,
    Value<bool>? brakes,
    Value<bool>? battery,
    Value<bool>? suspension,
    Value<bool>? motor,
    Value<bool>? lights,
    Value<bool>? horn,
    Value<bool>? softwareUpdate,
    Value<bool>? generalInspection,
    Value<int?>? bikeId,
    Value<int>? rowid,
  }) {
    return MaintenanceLogsTableCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      component: component ?? this.component,
      description: description ?? this.description,
      odometerReading: odometerReading ?? this.odometerReading,
      cost: cost ?? this.cost,
      serviceCenter: serviceCenter ?? this.serviceCenter,
      partsReplaced: partsReplaced ?? this.partsReplaced,
      labourCost: labourCost ?? this.labourCost,
      warrantyClaim: warrantyClaim ?? this.warrantyClaim,
      technician: technician ?? this.technician,
      invoicePhotoPath: invoicePhotoPath ?? this.invoicePhotoPath,
      notes: notes ?? this.notes,
      nextServiceDueOdometer:
          nextServiceDueOdometer ?? this.nextServiceDueOdometer,
      nextServiceDueDate: nextServiceDueDate ?? this.nextServiceDueDate,
      tyres: tyres ?? this.tyres,
      brakes: brakes ?? this.brakes,
      battery: battery ?? this.battery,
      suspension: suspension ?? this.suspension,
      motor: motor ?? this.motor,
      lights: lights ?? this.lights,
      horn: horn ?? this.horn,
      softwareUpdate: softwareUpdate ?? this.softwareUpdate,
      generalInspection: generalInspection ?? this.generalInspection,
      bikeId: bikeId ?? this.bikeId,
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
      map['component'] = Variable<int>(
        $MaintenanceLogsTableTable.$convertercomponent.toSql(component.value),
      );
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
    if (serviceCenter.present) {
      map['service_center'] = Variable<String>(serviceCenter.value);
    }
    if (partsReplaced.present) {
      map['parts_replaced'] = Variable<String>(partsReplaced.value);
    }
    if (labourCost.present) {
      map['labour_cost'] = Variable<double>(labourCost.value);
    }
    if (warrantyClaim.present) {
      map['warranty_claim'] = Variable<bool>(warrantyClaim.value);
    }
    if (technician.present) {
      map['technician'] = Variable<String>(technician.value);
    }
    if (invoicePhotoPath.present) {
      map['invoice_photo_path'] = Variable<String>(invoicePhotoPath.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (nextServiceDueOdometer.present) {
      map['next_service_due_odometer'] = Variable<double>(
        nextServiceDueOdometer.value,
      );
    }
    if (nextServiceDueDate.present) {
      map['next_service_due_date'] = Variable<DateTime>(
        nextServiceDueDate.value,
      );
    }
    if (tyres.present) {
      map['tyres'] = Variable<bool>(tyres.value);
    }
    if (brakes.present) {
      map['brakes'] = Variable<bool>(brakes.value);
    }
    if (battery.present) {
      map['battery'] = Variable<bool>(battery.value);
    }
    if (suspension.present) {
      map['suspension'] = Variable<bool>(suspension.value);
    }
    if (motor.present) {
      map['motor'] = Variable<bool>(motor.value);
    }
    if (lights.present) {
      map['lights'] = Variable<bool>(lights.value);
    }
    if (horn.present) {
      map['horn'] = Variable<bool>(horn.value);
    }
    if (softwareUpdate.present) {
      map['software_update'] = Variable<bool>(softwareUpdate.value);
    }
    if (generalInspection.present) {
      map['general_inspection'] = Variable<bool>(generalInspection.value);
    }
    if (bikeId.present) {
      map['bike_id'] = Variable<int>(bikeId.value);
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
          ..write('serviceCenter: $serviceCenter, ')
          ..write('partsReplaced: $partsReplaced, ')
          ..write('labourCost: $labourCost, ')
          ..write('warrantyClaim: $warrantyClaim, ')
          ..write('technician: $technician, ')
          ..write('invoicePhotoPath: $invoicePhotoPath, ')
          ..write('notes: $notes, ')
          ..write('nextServiceDueOdometer: $nextServiceDueOdometer, ')
          ..write('nextServiceDueDate: $nextServiceDueDate, ')
          ..write('tyres: $tyres, ')
          ..write('brakes: $brakes, ')
          ..write('battery: $battery, ')
          ..write('suspension: $suspension, ')
          ..write('motor: $motor, ')
          ..write('lights: $lights, ')
          ..write('horn: $horn, ')
          ..write('softwareUpdate: $softwareUpdate, ')
          ..write('generalInspection: $generalInspection, ')
          ..write('bikeId: $bikeId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DocumentsTableTable extends DocumentsTable
    with TableInfo<$DocumentsTableTable, DocumentsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DocumentsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _filePathMeta = const VerificationMeta(
    'filePath',
  );
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
    'file_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _uploadDateMeta = const VerificationMeta(
    'uploadDate',
  );
  @override
  late final GeneratedColumn<DateTime> uploadDate = GeneratedColumn<DateTime>(
    'upload_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bikeIdMeta = const VerificationMeta('bikeId');
  @override
  late final GeneratedColumn<int> bikeId = GeneratedColumn<int>(
    'bike_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _expiryDateMeta = const VerificationMeta(
    'expiryDate',
  );
  @override
  late final GeneratedColumn<DateTime> expiryDate = GeneratedColumn<DateTime>(
    'expiry_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    category,
    filePath,
    uploadDate,
    notes,
    bikeId,
    expiryDate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'documents_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<DocumentsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('file_path')) {
      context.handle(
        _filePathMeta,
        filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta),
      );
    } else if (isInserting) {
      context.missing(_filePathMeta);
    }
    if (data.containsKey('upload_date')) {
      context.handle(
        _uploadDateMeta,
        uploadDate.isAcceptableOrUnknown(data['upload_date']!, _uploadDateMeta),
      );
    } else if (isInserting) {
      context.missing(_uploadDateMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('bike_id')) {
      context.handle(
        _bikeIdMeta,
        bikeId.isAcceptableOrUnknown(data['bike_id']!, _bikeIdMeta),
      );
    }
    if (data.containsKey('expiry_date')) {
      context.handle(
        _expiryDateMeta,
        expiryDate.isAcceptableOrUnknown(data['expiry_date']!, _expiryDateMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DocumentsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DocumentsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      filePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_path'],
      )!,
      uploadDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}upload_date'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      bikeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bike_id'],
      ),
      expiryDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expiry_date'],
      ),
    );
  }

  @override
  $DocumentsTableTable createAlias(String alias) {
    return $DocumentsTableTable(attachedDatabase, alias);
  }
}

class DocumentsTableData extends DataClass
    implements Insertable<DocumentsTableData> {
  final int id;
  final String name;
  final String category;
  final String filePath;
  final DateTime uploadDate;
  final String? notes;
  final int? bikeId;
  final DateTime? expiryDate;
  const DocumentsTableData({
    required this.id,
    required this.name,
    required this.category,
    required this.filePath,
    required this.uploadDate,
    this.notes,
    this.bikeId,
    this.expiryDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['category'] = Variable<String>(category);
    map['file_path'] = Variable<String>(filePath);
    map['upload_date'] = Variable<DateTime>(uploadDate);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || bikeId != null) {
      map['bike_id'] = Variable<int>(bikeId);
    }
    if (!nullToAbsent || expiryDate != null) {
      map['expiry_date'] = Variable<DateTime>(expiryDate);
    }
    return map;
  }

  DocumentsTableCompanion toCompanion(bool nullToAbsent) {
    return DocumentsTableCompanion(
      id: Value(id),
      name: Value(name),
      category: Value(category),
      filePath: Value(filePath),
      uploadDate: Value(uploadDate),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      bikeId: bikeId == null && nullToAbsent
          ? const Value.absent()
          : Value(bikeId),
      expiryDate: expiryDate == null && nullToAbsent
          ? const Value.absent()
          : Value(expiryDate),
    );
  }

  factory DocumentsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DocumentsTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String>(json['category']),
      filePath: serializer.fromJson<String>(json['filePath']),
      uploadDate: serializer.fromJson<DateTime>(json['uploadDate']),
      notes: serializer.fromJson<String?>(json['notes']),
      bikeId: serializer.fromJson<int?>(json['bikeId']),
      expiryDate: serializer.fromJson<DateTime?>(json['expiryDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String>(category),
      'filePath': serializer.toJson<String>(filePath),
      'uploadDate': serializer.toJson<DateTime>(uploadDate),
      'notes': serializer.toJson<String?>(notes),
      'bikeId': serializer.toJson<int?>(bikeId),
      'expiryDate': serializer.toJson<DateTime?>(expiryDate),
    };
  }

  DocumentsTableData copyWith({
    int? id,
    String? name,
    String? category,
    String? filePath,
    DateTime? uploadDate,
    Value<String?> notes = const Value.absent(),
    Value<int?> bikeId = const Value.absent(),
    Value<DateTime?> expiryDate = const Value.absent(),
  }) => DocumentsTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    category: category ?? this.category,
    filePath: filePath ?? this.filePath,
    uploadDate: uploadDate ?? this.uploadDate,
    notes: notes.present ? notes.value : this.notes,
    bikeId: bikeId.present ? bikeId.value : this.bikeId,
    expiryDate: expiryDate.present ? expiryDate.value : this.expiryDate,
  );
  DocumentsTableData copyWithCompanion(DocumentsTableCompanion data) {
    return DocumentsTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      uploadDate: data.uploadDate.present
          ? data.uploadDate.value
          : this.uploadDate,
      notes: data.notes.present ? data.notes.value : this.notes,
      bikeId: data.bikeId.present ? data.bikeId.value : this.bikeId,
      expiryDate: data.expiryDate.present
          ? data.expiryDate.value
          : this.expiryDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DocumentsTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('filePath: $filePath, ')
          ..write('uploadDate: $uploadDate, ')
          ..write('notes: $notes, ')
          ..write('bikeId: $bikeId, ')
          ..write('expiryDate: $expiryDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    category,
    filePath,
    uploadDate,
    notes,
    bikeId,
    expiryDate,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DocumentsTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.category == this.category &&
          other.filePath == this.filePath &&
          other.uploadDate == this.uploadDate &&
          other.notes == this.notes &&
          other.bikeId == this.bikeId &&
          other.expiryDate == this.expiryDate);
}

class DocumentsTableCompanion extends UpdateCompanion<DocumentsTableData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> category;
  final Value<String> filePath;
  final Value<DateTime> uploadDate;
  final Value<String?> notes;
  final Value<int?> bikeId;
  final Value<DateTime?> expiryDate;
  const DocumentsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.filePath = const Value.absent(),
    this.uploadDate = const Value.absent(),
    this.notes = const Value.absent(),
    this.bikeId = const Value.absent(),
    this.expiryDate = const Value.absent(),
  });
  DocumentsTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String category,
    required String filePath,
    required DateTime uploadDate,
    this.notes = const Value.absent(),
    this.bikeId = const Value.absent(),
    this.expiryDate = const Value.absent(),
  }) : name = Value(name),
       category = Value(category),
       filePath = Value(filePath),
       uploadDate = Value(uploadDate);
  static Insertable<DocumentsTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? category,
    Expression<String>? filePath,
    Expression<DateTime>? uploadDate,
    Expression<String>? notes,
    Expression<int>? bikeId,
    Expression<DateTime>? expiryDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (filePath != null) 'file_path': filePath,
      if (uploadDate != null) 'upload_date': uploadDate,
      if (notes != null) 'notes': notes,
      if (bikeId != null) 'bike_id': bikeId,
      if (expiryDate != null) 'expiry_date': expiryDate,
    });
  }

  DocumentsTableCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? category,
    Value<String>? filePath,
    Value<DateTime>? uploadDate,
    Value<String?>? notes,
    Value<int?>? bikeId,
    Value<DateTime?>? expiryDate,
  }) {
    return DocumentsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      filePath: filePath ?? this.filePath,
      uploadDate: uploadDate ?? this.uploadDate,
      notes: notes ?? this.notes,
      bikeId: bikeId ?? this.bikeId,
      expiryDate: expiryDate ?? this.expiryDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (uploadDate.present) {
      map['upload_date'] = Variable<DateTime>(uploadDate.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (bikeId.present) {
      map['bike_id'] = Variable<int>(bikeId.value);
    }
    if (expiryDate.present) {
      map['expiry_date'] = Variable<DateTime>(expiryDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DocumentsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('filePath: $filePath, ')
          ..write('uploadDate: $uploadDate, ')
          ..write('notes: $notes, ')
          ..write('bikeId: $bikeId, ')
          ..write('expiryDate: $expiryDate')
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
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetDateMeta = const VerificationMeta(
    'targetDate',
  );
  @override
  late final GeneratedColumn<DateTime> targetDate = GeneratedColumn<DateTime>(
    'target_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _targetOdometerMeta = const VerificationMeta(
    'targetOdometer',
  );
  @override
  late final GeneratedColumn<double> targetOdometer = GeneratedColumn<double>(
    'target_odometer',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isCompletedMeta = const VerificationMeta(
    'isCompleted',
  );
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
    'is_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isNotifiedMeta = const VerificationMeta(
    'isNotified',
  );
  @override
  late final GeneratedColumn<bool> isNotified = GeneratedColumn<bool>(
    'is_notified',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_notified" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _bikeIdMeta = const VerificationMeta('bikeId');
  @override
  late final GeneratedColumn<int> bikeId = GeneratedColumn<int>(
    'bike_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    body,
    targetDate,
    targetOdometer,
    isCompleted,
    isNotified,
    type,
    note,
    isActive,
    bikeId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reminders_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<RemindersTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('target_date')) {
      context.handle(
        _targetDateMeta,
        targetDate.isAcceptableOrUnknown(data['target_date']!, _targetDateMeta),
      );
    }
    if (data.containsKey('target_odometer')) {
      context.handle(
        _targetOdometerMeta,
        targetOdometer.isAcceptableOrUnknown(
          data['target_odometer']!,
          _targetOdometerMeta,
        ),
      );
    }
    if (data.containsKey('is_completed')) {
      context.handle(
        _isCompletedMeta,
        isCompleted.isAcceptableOrUnknown(
          data['is_completed']!,
          _isCompletedMeta,
        ),
      );
    }
    if (data.containsKey('is_notified')) {
      context.handle(
        _isNotifiedMeta,
        isNotified.isAcceptableOrUnknown(data['is_notified']!, _isNotifiedMeta),
      );
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('bike_id')) {
      context.handle(
        _bikeIdMeta,
        bikeId.isAcceptableOrUnknown(data['bike_id']!, _bikeIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RemindersTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RemindersTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      )!,
      targetDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}target_date'],
      ),
      targetOdometer: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_odometer'],
      ),
      isCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_completed'],
      )!,
      isNotified: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_notified'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      bikeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bike_id'],
      ),
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
  final String? type;
  final String? note;
  final bool isActive;
  final int? bikeId;
  const RemindersTableData({
    required this.id,
    required this.title,
    required this.body,
    this.targetDate,
    this.targetOdometer,
    required this.isCompleted,
    required this.isNotified,
    this.type,
    this.note,
    required this.isActive,
    this.bikeId,
  });
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
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<String>(type);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['is_active'] = Variable<bool>(isActive);
    if (!nullToAbsent || bikeId != null) {
      map['bike_id'] = Variable<int>(bikeId);
    }
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
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      isActive: Value(isActive),
      bikeId: bikeId == null && nullToAbsent
          ? const Value.absent()
          : Value(bikeId),
    );
  }

  factory RemindersTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RemindersTableData(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      body: serializer.fromJson<String>(json['body']),
      targetDate: serializer.fromJson<DateTime?>(json['targetDate']),
      targetOdometer: serializer.fromJson<double?>(json['targetOdometer']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      isNotified: serializer.fromJson<bool>(json['isNotified']),
      type: serializer.fromJson<String?>(json['type']),
      note: serializer.fromJson<String?>(json['note']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      bikeId: serializer.fromJson<int?>(json['bikeId']),
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
      'type': serializer.toJson<String?>(type),
      'note': serializer.toJson<String?>(note),
      'isActive': serializer.toJson<bool>(isActive),
      'bikeId': serializer.toJson<int?>(bikeId),
    };
  }

  RemindersTableData copyWith({
    String? id,
    String? title,
    String? body,
    Value<DateTime?> targetDate = const Value.absent(),
    Value<double?> targetOdometer = const Value.absent(),
    bool? isCompleted,
    bool? isNotified,
    Value<String?> type = const Value.absent(),
    Value<String?> note = const Value.absent(),
    bool? isActive,
    Value<int?> bikeId = const Value.absent(),
  }) => RemindersTableData(
    id: id ?? this.id,
    title: title ?? this.title,
    body: body ?? this.body,
    targetDate: targetDate.present ? targetDate.value : this.targetDate,
    targetOdometer: targetOdometer.present
        ? targetOdometer.value
        : this.targetOdometer,
    isCompleted: isCompleted ?? this.isCompleted,
    isNotified: isNotified ?? this.isNotified,
    type: type.present ? type.value : this.type,
    note: note.present ? note.value : this.note,
    isActive: isActive ?? this.isActive,
    bikeId: bikeId.present ? bikeId.value : this.bikeId,
  );
  RemindersTableData copyWithCompanion(RemindersTableCompanion data) {
    return RemindersTableData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      body: data.body.present ? data.body.value : this.body,
      targetDate: data.targetDate.present
          ? data.targetDate.value
          : this.targetDate,
      targetOdometer: data.targetOdometer.present
          ? data.targetOdometer.value
          : this.targetOdometer,
      isCompleted: data.isCompleted.present
          ? data.isCompleted.value
          : this.isCompleted,
      isNotified: data.isNotified.present
          ? data.isNotified.value
          : this.isNotified,
      type: data.type.present ? data.type.value : this.type,
      note: data.note.present ? data.note.value : this.note,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      bikeId: data.bikeId.present ? data.bikeId.value : this.bikeId,
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
          ..write('isNotified: $isNotified, ')
          ..write('type: $type, ')
          ..write('note: $note, ')
          ..write('isActive: $isActive, ')
          ..write('bikeId: $bikeId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    body,
    targetDate,
    targetOdometer,
    isCompleted,
    isNotified,
    type,
    note,
    isActive,
    bikeId,
  );
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
          other.isNotified == this.isNotified &&
          other.type == this.type &&
          other.note == this.note &&
          other.isActive == this.isActive &&
          other.bikeId == this.bikeId);
}

class RemindersTableCompanion extends UpdateCompanion<RemindersTableData> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> body;
  final Value<DateTime?> targetDate;
  final Value<double?> targetOdometer;
  final Value<bool> isCompleted;
  final Value<bool> isNotified;
  final Value<String?> type;
  final Value<String?> note;
  final Value<bool> isActive;
  final Value<int?> bikeId;
  final Value<int> rowid;
  const RemindersTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.body = const Value.absent(),
    this.targetDate = const Value.absent(),
    this.targetOdometer = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.isNotified = const Value.absent(),
    this.type = const Value.absent(),
    this.note = const Value.absent(),
    this.isActive = const Value.absent(),
    this.bikeId = const Value.absent(),
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
    this.type = const Value.absent(),
    this.note = const Value.absent(),
    this.isActive = const Value.absent(),
    this.bikeId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
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
    Expression<String>? type,
    Expression<String>? note,
    Expression<bool>? isActive,
    Expression<int>? bikeId,
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
      if (type != null) 'type': type,
      if (note != null) 'note': note,
      if (isActive != null) 'is_active': isActive,
      if (bikeId != null) 'bike_id': bikeId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RemindersTableCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String>? body,
    Value<DateTime?>? targetDate,
    Value<double?>? targetOdometer,
    Value<bool>? isCompleted,
    Value<bool>? isNotified,
    Value<String?>? type,
    Value<String?>? note,
    Value<bool>? isActive,
    Value<int?>? bikeId,
    Value<int>? rowid,
  }) {
    return RemindersTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      targetDate: targetDate ?? this.targetDate,
      targetOdometer: targetOdometer ?? this.targetOdometer,
      isCompleted: isCompleted ?? this.isCompleted,
      isNotified: isNotified ?? this.isNotified,
      type: type ?? this.type,
      note: note ?? this.note,
      isActive: isActive ?? this.isActive,
      bikeId: bikeId ?? this.bikeId,
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
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (bikeId.present) {
      map['bike_id'] = Variable<int>(bikeId.value);
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
          ..write('type: $type, ')
          ..write('note: $note, ')
          ..write('isActive: $isActive, ')
          ..write('bikeId: $bikeId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BatteryHealthSnapshotsTableTable extends BatteryHealthSnapshotsTable
    with
        TableInfo<
          $BatteryHealthSnapshotsTableTable,
          BatteryHealthSnapshotsTableData
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BatteryHealthSnapshotsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _healthPercentMeta = const VerificationMeta(
    'healthPercent',
  );
  @override
  late final GeneratedColumn<double> healthPercent = GeneratedColumn<double>(
    'health_percent',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rangeAtFullChargeMeta = const VerificationMeta(
    'rangeAtFullCharge',
  );
  @override
  late final GeneratedColumn<double> rangeAtFullCharge =
      GeneratedColumn<double>(
        'range_at_full_charge',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _bikeIdMeta = const VerificationMeta('bikeId');
  @override
  late final GeneratedColumn<int> bikeId = GeneratedColumn<int>(
    'bike_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    healthPercent,
    rangeAtFullCharge,
    bikeId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'battery_health_snapshots_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<BatteryHealthSnapshotsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('health_percent')) {
      context.handle(
        _healthPercentMeta,
        healthPercent.isAcceptableOrUnknown(
          data['health_percent']!,
          _healthPercentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_healthPercentMeta);
    }
    if (data.containsKey('range_at_full_charge')) {
      context.handle(
        _rangeAtFullChargeMeta,
        rangeAtFullCharge.isAcceptableOrUnknown(
          data['range_at_full_charge']!,
          _rangeAtFullChargeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_rangeAtFullChargeMeta);
    }
    if (data.containsKey('bike_id')) {
      context.handle(
        _bikeIdMeta,
        bikeId.isAcceptableOrUnknown(data['bike_id']!, _bikeIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BatteryHealthSnapshotsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BatteryHealthSnapshotsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      healthPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}health_percent'],
      )!,
      rangeAtFullCharge: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}range_at_full_charge'],
      )!,
      bikeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bike_id'],
      ),
    );
  }

  @override
  $BatteryHealthSnapshotsTableTable createAlias(String alias) {
    return $BatteryHealthSnapshotsTableTable(attachedDatabase, alias);
  }
}

class BatteryHealthSnapshotsTableData extends DataClass
    implements Insertable<BatteryHealthSnapshotsTableData> {
  final String id;
  final DateTime date;
  final double healthPercent;
  final double rangeAtFullCharge;
  final int? bikeId;
  const BatteryHealthSnapshotsTableData({
    required this.id,
    required this.date,
    required this.healthPercent,
    required this.rangeAtFullCharge,
    this.bikeId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<DateTime>(date);
    map['health_percent'] = Variable<double>(healthPercent);
    map['range_at_full_charge'] = Variable<double>(rangeAtFullCharge);
    if (!nullToAbsent || bikeId != null) {
      map['bike_id'] = Variable<int>(bikeId);
    }
    return map;
  }

  BatteryHealthSnapshotsTableCompanion toCompanion(bool nullToAbsent) {
    return BatteryHealthSnapshotsTableCompanion(
      id: Value(id),
      date: Value(date),
      healthPercent: Value(healthPercent),
      rangeAtFullCharge: Value(rangeAtFullCharge),
      bikeId: bikeId == null && nullToAbsent
          ? const Value.absent()
          : Value(bikeId),
    );
  }

  factory BatteryHealthSnapshotsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BatteryHealthSnapshotsTableData(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      healthPercent: serializer.fromJson<double>(json['healthPercent']),
      rangeAtFullCharge: serializer.fromJson<double>(json['rangeAtFullCharge']),
      bikeId: serializer.fromJson<int?>(json['bikeId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<DateTime>(date),
      'healthPercent': serializer.toJson<double>(healthPercent),
      'rangeAtFullCharge': serializer.toJson<double>(rangeAtFullCharge),
      'bikeId': serializer.toJson<int?>(bikeId),
    };
  }

  BatteryHealthSnapshotsTableData copyWith({
    String? id,
    DateTime? date,
    double? healthPercent,
    double? rangeAtFullCharge,
    Value<int?> bikeId = const Value.absent(),
  }) => BatteryHealthSnapshotsTableData(
    id: id ?? this.id,
    date: date ?? this.date,
    healthPercent: healthPercent ?? this.healthPercent,
    rangeAtFullCharge: rangeAtFullCharge ?? this.rangeAtFullCharge,
    bikeId: bikeId.present ? bikeId.value : this.bikeId,
  );
  BatteryHealthSnapshotsTableData copyWithCompanion(
    BatteryHealthSnapshotsTableCompanion data,
  ) {
    return BatteryHealthSnapshotsTableData(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      healthPercent: data.healthPercent.present
          ? data.healthPercent.value
          : this.healthPercent,
      rangeAtFullCharge: data.rangeAtFullCharge.present
          ? data.rangeAtFullCharge.value
          : this.rangeAtFullCharge,
      bikeId: data.bikeId.present ? data.bikeId.value : this.bikeId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BatteryHealthSnapshotsTableData(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('healthPercent: $healthPercent, ')
          ..write('rangeAtFullCharge: $rangeAtFullCharge, ')
          ..write('bikeId: $bikeId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, date, healthPercent, rangeAtFullCharge, bikeId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BatteryHealthSnapshotsTableData &&
          other.id == this.id &&
          other.date == this.date &&
          other.healthPercent == this.healthPercent &&
          other.rangeAtFullCharge == this.rangeAtFullCharge &&
          other.bikeId == this.bikeId);
}

class BatteryHealthSnapshotsTableCompanion
    extends UpdateCompanion<BatteryHealthSnapshotsTableData> {
  final Value<String> id;
  final Value<DateTime> date;
  final Value<double> healthPercent;
  final Value<double> rangeAtFullCharge;
  final Value<int?> bikeId;
  final Value<int> rowid;
  const BatteryHealthSnapshotsTableCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.healthPercent = const Value.absent(),
    this.rangeAtFullCharge = const Value.absent(),
    this.bikeId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BatteryHealthSnapshotsTableCompanion.insert({
    required String id,
    required DateTime date,
    required double healthPercent,
    required double rangeAtFullCharge,
    this.bikeId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       date = Value(date),
       healthPercent = Value(healthPercent),
       rangeAtFullCharge = Value(rangeAtFullCharge);
  static Insertable<BatteryHealthSnapshotsTableData> custom({
    Expression<String>? id,
    Expression<DateTime>? date,
    Expression<double>? healthPercent,
    Expression<double>? rangeAtFullCharge,
    Expression<int>? bikeId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (healthPercent != null) 'health_percent': healthPercent,
      if (rangeAtFullCharge != null) 'range_at_full_charge': rangeAtFullCharge,
      if (bikeId != null) 'bike_id': bikeId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BatteryHealthSnapshotsTableCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? date,
    Value<double>? healthPercent,
    Value<double>? rangeAtFullCharge,
    Value<int?>? bikeId,
    Value<int>? rowid,
  }) {
    return BatteryHealthSnapshotsTableCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      healthPercent: healthPercent ?? this.healthPercent,
      rangeAtFullCharge: rangeAtFullCharge ?? this.rangeAtFullCharge,
      bikeId: bikeId ?? this.bikeId,
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
    if (healthPercent.present) {
      map['health_percent'] = Variable<double>(healthPercent.value);
    }
    if (rangeAtFullCharge.present) {
      map['range_at_full_charge'] = Variable<double>(rangeAtFullCharge.value);
    }
    if (bikeId.present) {
      map['bike_id'] = Variable<int>(bikeId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BatteryHealthSnapshotsTableCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('healthPercent: $healthPercent, ')
          ..write('rangeAtFullCharge: $rangeAtFullCharge, ')
          ..write('bikeId: $bikeId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BikesTableTable bikesTable = $BikesTableTable(this);
  late final $RidesTableTable ridesTable = $RidesTableTable(this);
  late final $ChargeLogsTableTable chargeLogsTable = $ChargeLogsTableTable(
    this,
  );
  late final $ExpensesTableTable expensesTable = $ExpensesTableTable(this);
  late final $MaintenanceLogsTableTable maintenanceLogsTable =
      $MaintenanceLogsTableTable(this);
  late final $DocumentsTableTable documentsTable = $DocumentsTableTable(this);
  late final $RemindersTableTable remindersTable = $RemindersTableTable(this);
  late final $BatteryHealthSnapshotsTableTable batteryHealthSnapshotsTable =
      $BatteryHealthSnapshotsTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    bikesTable,
    ridesTable,
    chargeLogsTable,
    expensesTable,
    maintenanceLogsTable,
    documentsTable,
    remindersTable,
    batteryHealthSnapshotsTable,
  ];
}

typedef $$BikesTableTableCreateCompanionBuilder =
    BikesTableCompanion Function({
      Value<int> id,
      required String name,
      required String brand,
      required String model,
      Value<String?> variant,
      required String color,
      required String registrationNumber,
      Value<String?> vin,
      Value<String?> motorNumber,
      Value<DateTime?> purchaseDate,
      Value<double?> purchasePrice,
      Value<String?> dealer,
      Value<String?> insurance,
      Value<String?> warranty,
      Value<String?> batteryWarranty,
      Value<double?> batteryCapacity,
      Value<double?> motorPower,
      Value<double?> claimedRange,
      Value<double?> topSpeed,
      Value<String?> tyreInfo,
      Value<String?> customNotes,
      Value<String?> photoPath,
    });
typedef $$BikesTableTableUpdateCompanionBuilder =
    BikesTableCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> brand,
      Value<String> model,
      Value<String?> variant,
      Value<String> color,
      Value<String> registrationNumber,
      Value<String?> vin,
      Value<String?> motorNumber,
      Value<DateTime?> purchaseDate,
      Value<double?> purchasePrice,
      Value<String?> dealer,
      Value<String?> insurance,
      Value<String?> warranty,
      Value<String?> batteryWarranty,
      Value<double?> batteryCapacity,
      Value<double?> motorPower,
      Value<double?> claimedRange,
      Value<double?> topSpeed,
      Value<String?> tyreInfo,
      Value<String?> customNotes,
      Value<String?> photoPath,
    });

class $$BikesTableTableFilterComposer
    extends Composer<_$AppDatabase, $BikesTableTable> {
  $$BikesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get variant => $composableBuilder(
    column: $table.variant,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get registrationNumber => $composableBuilder(
    column: $table.registrationNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vin => $composableBuilder(
    column: $table.vin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get motorNumber => $composableBuilder(
    column: $table.motorNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dealer => $composableBuilder(
    column: $table.dealer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get insurance => $composableBuilder(
    column: $table.insurance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get warranty => $composableBuilder(
    column: $table.warranty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get batteryWarranty => $composableBuilder(
    column: $table.batteryWarranty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get batteryCapacity => $composableBuilder(
    column: $table.batteryCapacity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get motorPower => $composableBuilder(
    column: $table.motorPower,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get claimedRange => $composableBuilder(
    column: $table.claimedRange,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get topSpeed => $composableBuilder(
    column: $table.topSpeed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tyreInfo => $composableBuilder(
    column: $table.tyreInfo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customNotes => $composableBuilder(
    column: $table.customNotes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BikesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $BikesTableTable> {
  $$BikesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get variant => $composableBuilder(
    column: $table.variant,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get registrationNumber => $composableBuilder(
    column: $table.registrationNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vin => $composableBuilder(
    column: $table.vin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get motorNumber => $composableBuilder(
    column: $table.motorNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dealer => $composableBuilder(
    column: $table.dealer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get insurance => $composableBuilder(
    column: $table.insurance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get warranty => $composableBuilder(
    column: $table.warranty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get batteryWarranty => $composableBuilder(
    column: $table.batteryWarranty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get batteryCapacity => $composableBuilder(
    column: $table.batteryCapacity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get motorPower => $composableBuilder(
    column: $table.motorPower,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get claimedRange => $composableBuilder(
    column: $table.claimedRange,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get topSpeed => $composableBuilder(
    column: $table.topSpeed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tyreInfo => $composableBuilder(
    column: $table.tyreInfo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customNotes => $composableBuilder(
    column: $table.customNotes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BikesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $BikesTableTable> {
  $$BikesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get brand =>
      $composableBuilder(column: $table.brand, builder: (column) => column);

  GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  GeneratedColumn<String> get variant =>
      $composableBuilder(column: $table.variant, builder: (column) => column);

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<String> get registrationNumber => $composableBuilder(
    column: $table.registrationNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get vin =>
      $composableBuilder(column: $table.vin, builder: (column) => column);

  GeneratedColumn<String> get motorNumber => $composableBuilder(
    column: $table.motorNumber,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => column,
  );

  GeneratedColumn<String> get dealer =>
      $composableBuilder(column: $table.dealer, builder: (column) => column);

  GeneratedColumn<String> get insurance =>
      $composableBuilder(column: $table.insurance, builder: (column) => column);

  GeneratedColumn<String> get warranty =>
      $composableBuilder(column: $table.warranty, builder: (column) => column);

  GeneratedColumn<String> get batteryWarranty => $composableBuilder(
    column: $table.batteryWarranty,
    builder: (column) => column,
  );

  GeneratedColumn<double> get batteryCapacity => $composableBuilder(
    column: $table.batteryCapacity,
    builder: (column) => column,
  );

  GeneratedColumn<double> get motorPower => $composableBuilder(
    column: $table.motorPower,
    builder: (column) => column,
  );

  GeneratedColumn<double> get claimedRange => $composableBuilder(
    column: $table.claimedRange,
    builder: (column) => column,
  );

  GeneratedColumn<double> get topSpeed =>
      $composableBuilder(column: $table.topSpeed, builder: (column) => column);

  GeneratedColumn<String> get tyreInfo =>
      $composableBuilder(column: $table.tyreInfo, builder: (column) => column);

  GeneratedColumn<String> get customNotes => $composableBuilder(
    column: $table.customNotes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);
}

class $$BikesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BikesTableTable,
          BikesTableData,
          $$BikesTableTableFilterComposer,
          $$BikesTableTableOrderingComposer,
          $$BikesTableTableAnnotationComposer,
          $$BikesTableTableCreateCompanionBuilder,
          $$BikesTableTableUpdateCompanionBuilder,
          (
            BikesTableData,
            BaseReferences<_$AppDatabase, $BikesTableTable, BikesTableData>,
          ),
          BikesTableData,
          PrefetchHooks Function()
        > {
  $$BikesTableTableTableManager(_$AppDatabase db, $BikesTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BikesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BikesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BikesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> brand = const Value.absent(),
                Value<String> model = const Value.absent(),
                Value<String?> variant = const Value.absent(),
                Value<String> color = const Value.absent(),
                Value<String> registrationNumber = const Value.absent(),
                Value<String?> vin = const Value.absent(),
                Value<String?> motorNumber = const Value.absent(),
                Value<DateTime?> purchaseDate = const Value.absent(),
                Value<double?> purchasePrice = const Value.absent(),
                Value<String?> dealer = const Value.absent(),
                Value<String?> insurance = const Value.absent(),
                Value<String?> warranty = const Value.absent(),
                Value<String?> batteryWarranty = const Value.absent(),
                Value<double?> batteryCapacity = const Value.absent(),
                Value<double?> motorPower = const Value.absent(),
                Value<double?> claimedRange = const Value.absent(),
                Value<double?> topSpeed = const Value.absent(),
                Value<String?> tyreInfo = const Value.absent(),
                Value<String?> customNotes = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
              }) => BikesTableCompanion(
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
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String brand,
                required String model,
                Value<String?> variant = const Value.absent(),
                required String color,
                required String registrationNumber,
                Value<String?> vin = const Value.absent(),
                Value<String?> motorNumber = const Value.absent(),
                Value<DateTime?> purchaseDate = const Value.absent(),
                Value<double?> purchasePrice = const Value.absent(),
                Value<String?> dealer = const Value.absent(),
                Value<String?> insurance = const Value.absent(),
                Value<String?> warranty = const Value.absent(),
                Value<String?> batteryWarranty = const Value.absent(),
                Value<double?> batteryCapacity = const Value.absent(),
                Value<double?> motorPower = const Value.absent(),
                Value<double?> claimedRange = const Value.absent(),
                Value<double?> topSpeed = const Value.absent(),
                Value<String?> tyreInfo = const Value.absent(),
                Value<String?> customNotes = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
              }) => BikesTableCompanion.insert(
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
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BikesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BikesTableTable,
      BikesTableData,
      $$BikesTableTableFilterComposer,
      $$BikesTableTableOrderingComposer,
      $$BikesTableTableAnnotationComposer,
      $$BikesTableTableCreateCompanionBuilder,
      $$BikesTableTableUpdateCompanionBuilder,
      (
        BikesTableData,
        BaseReferences<_$AppDatabase, $BikesTableTable, BikesTableData>,
      ),
      BikesTableData,
      PrefetchHooks Function()
    >;
typedef $$RidesTableTableCreateCompanionBuilder =
    RidesTableCompanion Function({
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
      Value<DateTime?> startTime,
      Value<DateTime?> endTime,
      Value<int?> durationMinutes,
      Value<double?> estimatedRemainingRange,
      Value<double?> averageSpeed,
      Value<double?> maxSpeed,
      Value<String?> weather,
      Value<String?> roadType,
      Value<int?> passengerCount,
      Value<String?> ridePurpose,
      Value<String?> startLocation,
      Value<String?> endLocation,
      Value<String?> routeNotes,
      Value<List<String>> customTags,
      Value<bool> isFavorite,
      Value<int?> bikeId,
      Value<String> source,
      Value<int> rowid,
    });
typedef $$RidesTableTableUpdateCompanionBuilder =
    RidesTableCompanion Function({
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
      Value<DateTime?> startTime,
      Value<DateTime?> endTime,
      Value<int?> durationMinutes,
      Value<double?> estimatedRemainingRange,
      Value<double?> averageSpeed,
      Value<double?> maxSpeed,
      Value<String?> weather,
      Value<String?> roadType,
      Value<int?> passengerCount,
      Value<String?> ridePurpose,
      Value<String?> startLocation,
      Value<String?> endLocation,
      Value<String?> routeNotes,
      Value<List<String>> customTags,
      Value<bool> isFavorite,
      Value<int?> bikeId,
      Value<String> source,
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
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get startOdometer => $composableBuilder(
    column: $table.startOdometer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get endOdometer => $composableBuilder(
    column: $table.endOdometer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get batteryBefore => $composableBuilder(
    column: $table.batteryBefore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get batteryAfter => $composableBuilder(
    column: $table.batteryAfter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<RideMode, RideMode, int> get rideMode =>
      $composableBuilder(
        column: $table.rideMode,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<RoadCondition, RoadCondition, int>
  get roadCondition => $composableBuilder(
    column: $table.roadCondition,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
  get photoPaths => $composableBuilder(
    column: $table.photoPaths,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get estimatedRemainingRange => $composableBuilder(
    column: $table.estimatedRemainingRange,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get averageSpeed => $composableBuilder(
    column: $table.averageSpeed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get maxSpeed => $composableBuilder(
    column: $table.maxSpeed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get weather => $composableBuilder(
    column: $table.weather,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get roadType => $composableBuilder(
    column: $table.roadType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get passengerCount => $composableBuilder(
    column: $table.passengerCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ridePurpose => $composableBuilder(
    column: $table.ridePurpose,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get startLocation => $composableBuilder(
    column: $table.startLocation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get endLocation => $composableBuilder(
    column: $table.endLocation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get routeNotes => $composableBuilder(
    column: $table.routeNotes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
  get customTags => $composableBuilder(
    column: $table.customTags,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bikeId => $composableBuilder(
    column: $table.bikeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );
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
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get startOdometer => $composableBuilder(
    column: $table.startOdometer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get endOdometer => $composableBuilder(
    column: $table.endOdometer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get batteryBefore => $composableBuilder(
    column: $table.batteryBefore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get batteryAfter => $composableBuilder(
    column: $table.batteryAfter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rideMode => $composableBuilder(
    column: $table.rideMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get roadCondition => $composableBuilder(
    column: $table.roadCondition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoPaths => $composableBuilder(
    column: $table.photoPaths,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get estimatedRemainingRange => $composableBuilder(
    column: $table.estimatedRemainingRange,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get averageSpeed => $composableBuilder(
    column: $table.averageSpeed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get maxSpeed => $composableBuilder(
    column: $table.maxSpeed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get weather => $composableBuilder(
    column: $table.weather,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get roadType => $composableBuilder(
    column: $table.roadType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get passengerCount => $composableBuilder(
    column: $table.passengerCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ridePurpose => $composableBuilder(
    column: $table.ridePurpose,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get startLocation => $composableBuilder(
    column: $table.startLocation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get endLocation => $composableBuilder(
    column: $table.endLocation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get routeNotes => $composableBuilder(
    column: $table.routeNotes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customTags => $composableBuilder(
    column: $table.customTags,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bikeId => $composableBuilder(
    column: $table.bikeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );
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
    column: $table.startOdometer,
    builder: (column) => column,
  );

  GeneratedColumn<double> get endOdometer => $composableBuilder(
    column: $table.endOdometer,
    builder: (column) => column,
  );

  GeneratedColumn<int> get batteryBefore => $composableBuilder(
    column: $table.batteryBefore,
    builder: (column) => column,
  );

  GeneratedColumn<int> get batteryAfter => $composableBuilder(
    column: $table.batteryAfter,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<RideMode, int> get rideMode =>
      $composableBuilder(column: $table.rideMode, builder: (column) => column);

  GeneratedColumnWithTypeConverter<RoadCondition, int> get roadCondition =>
      $composableBuilder(
        column: $table.roadCondition,
        builder: (column) => column,
      );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get photoPaths =>
      $composableBuilder(
        column: $table.photoPaths,
        builder: (column) => column,
      );

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<DateTime> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<double> get estimatedRemainingRange => $composableBuilder(
    column: $table.estimatedRemainingRange,
    builder: (column) => column,
  );

  GeneratedColumn<double> get averageSpeed => $composableBuilder(
    column: $table.averageSpeed,
    builder: (column) => column,
  );

  GeneratedColumn<double> get maxSpeed =>
      $composableBuilder(column: $table.maxSpeed, builder: (column) => column);

  GeneratedColumn<String> get weather =>
      $composableBuilder(column: $table.weather, builder: (column) => column);

  GeneratedColumn<String> get roadType =>
      $composableBuilder(column: $table.roadType, builder: (column) => column);

  GeneratedColumn<int> get passengerCount => $composableBuilder(
    column: $table.passengerCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ridePurpose => $composableBuilder(
    column: $table.ridePurpose,
    builder: (column) => column,
  );

  GeneratedColumn<String> get startLocation => $composableBuilder(
    column: $table.startLocation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get endLocation => $composableBuilder(
    column: $table.endLocation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get routeNotes => $composableBuilder(
    column: $table.routeNotes,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<List<String>, String> get customTags =>
      $composableBuilder(
        column: $table.customTags,
        builder: (column) => column,
      );

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<int> get bikeId =>
      $composableBuilder(column: $table.bikeId, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);
}

class $$RidesTableTableTableManager
    extends
        RootTableManager<
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
            BaseReferences<_$AppDatabase, $RidesTableTable, RidesTableData>,
          ),
          RidesTableData,
          PrefetchHooks Function()
        > {
  $$RidesTableTableTableManager(_$AppDatabase db, $RidesTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RidesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RidesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RidesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
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
                Value<DateTime?> startTime = const Value.absent(),
                Value<DateTime?> endTime = const Value.absent(),
                Value<int?> durationMinutes = const Value.absent(),
                Value<double?> estimatedRemainingRange = const Value.absent(),
                Value<double?> averageSpeed = const Value.absent(),
                Value<double?> maxSpeed = const Value.absent(),
                Value<String?> weather = const Value.absent(),
                Value<String?> roadType = const Value.absent(),
                Value<int?> passengerCount = const Value.absent(),
                Value<String?> ridePurpose = const Value.absent(),
                Value<String?> startLocation = const Value.absent(),
                Value<String?> endLocation = const Value.absent(),
                Value<String?> routeNotes = const Value.absent(),
                Value<List<String>> customTags = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<int?> bikeId = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RidesTableCompanion(
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
                startTime: startTime,
                endTime: endTime,
                durationMinutes: durationMinutes,
                estimatedRemainingRange: estimatedRemainingRange,
                averageSpeed: averageSpeed,
                maxSpeed: maxSpeed,
                weather: weather,
                roadType: roadType,
                passengerCount: passengerCount,
                ridePurpose: ridePurpose,
                startLocation: startLocation,
                endLocation: endLocation,
                routeNotes: routeNotes,
                customTags: customTags,
                isFavorite: isFavorite,
                bikeId: bikeId,
                source: source,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
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
                Value<DateTime?> startTime = const Value.absent(),
                Value<DateTime?> endTime = const Value.absent(),
                Value<int?> durationMinutes = const Value.absent(),
                Value<double?> estimatedRemainingRange = const Value.absent(),
                Value<double?> averageSpeed = const Value.absent(),
                Value<double?> maxSpeed = const Value.absent(),
                Value<String?> weather = const Value.absent(),
                Value<String?> roadType = const Value.absent(),
                Value<int?> passengerCount = const Value.absent(),
                Value<String?> ridePurpose = const Value.absent(),
                Value<String?> startLocation = const Value.absent(),
                Value<String?> endLocation = const Value.absent(),
                Value<String?> routeNotes = const Value.absent(),
                Value<List<String>> customTags = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<int?> bikeId = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RidesTableCompanion.insert(
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
                startTime: startTime,
                endTime: endTime,
                durationMinutes: durationMinutes,
                estimatedRemainingRange: estimatedRemainingRange,
                averageSpeed: averageSpeed,
                maxSpeed: maxSpeed,
                weather: weather,
                roadType: roadType,
                passengerCount: passengerCount,
                ridePurpose: ridePurpose,
                startLocation: startLocation,
                endLocation: endLocation,
                routeNotes: routeNotes,
                customTags: customTags,
                isFavorite: isFavorite,
                bikeId: bikeId,
                source: source,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RidesTableTableProcessedTableManager =
    ProcessedTableManager<
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
        BaseReferences<_$AppDatabase, $RidesTableTable, RidesTableData>,
      ),
      RidesTableData,
      PrefetchHooks Function()
    >;
typedef $$ChargeLogsTableTableCreateCompanionBuilder =
    ChargeLogsTableCompanion Function({
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
      Value<DateTime?> startTime,
      Value<DateTime?> endTime,
      Value<String?> chargerType,
      Value<String?> chargingMethod,
      Value<double?> electricityPrice,
      Value<List<String>> photoPaths,
      Value<int?> bikeId,
      Value<String?> providerName,
      Value<double?> maxChargingPowerKw,
      Value<String> source,
      Value<int> rowid,
    });
typedef $$ChargeLogsTableTableUpdateCompanionBuilder =
    ChargeLogsTableCompanion Function({
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
      Value<DateTime?> startTime,
      Value<DateTime?> endTime,
      Value<String?> chargerType,
      Value<String?> chargingMethod,
      Value<double?> electricityPrice,
      Value<List<String>> photoPaths,
      Value<int?> bikeId,
      Value<String?> providerName,
      Value<double?> maxChargingPowerKw,
      Value<String> source,
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
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get kwhAdded => $composableBuilder(
    column: $table.kwhAdded,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cost => $composableBuilder(
    column: $table.cost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<PaymentMethod, PaymentMethod, int>
  get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<LocationType, LocationType, int>
  get locationType => $composableBuilder(
    column: $table.locationType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get startBattery => $composableBuilder(
    column: $table.startBattery,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get endBattery => $composableBuilder(
    column: $table.endBattery,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locationName => $composableBuilder(
    column: $table.locationName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get chargerType => $composableBuilder(
    column: $table.chargerType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get chargingMethod => $composableBuilder(
    column: $table.chargingMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get electricityPrice => $composableBuilder(
    column: $table.electricityPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
  get photoPaths => $composableBuilder(
    column: $table.photoPaths,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get bikeId => $composableBuilder(
    column: $table.bikeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get providerName => $composableBuilder(
    column: $table.providerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get maxChargingPowerKw => $composableBuilder(
    column: $table.maxChargingPowerKw,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );
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
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get kwhAdded => $composableBuilder(
    column: $table.kwhAdded,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cost => $composableBuilder(
    column: $table.cost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get locationType => $composableBuilder(
    column: $table.locationType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startBattery => $composableBuilder(
    column: $table.startBattery,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get endBattery => $composableBuilder(
    column: $table.endBattery,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locationName => $composableBuilder(
    column: $table.locationName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get chargerType => $composableBuilder(
    column: $table.chargerType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get chargingMethod => $composableBuilder(
    column: $table.chargingMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get electricityPrice => $composableBuilder(
    column: $table.electricityPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoPaths => $composableBuilder(
    column: $table.photoPaths,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bikeId => $composableBuilder(
    column: $table.bikeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get providerName => $composableBuilder(
    column: $table.providerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get maxChargingPowerKw => $composableBuilder(
    column: $table.maxChargingPowerKw,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );
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
    column: $table.durationMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<double> get kwhAdded =>
      $composableBuilder(column: $table.kwhAdded, builder: (column) => column);

  GeneratedColumn<double> get cost =>
      $composableBuilder(column: $table.cost, builder: (column) => column);

  GeneratedColumnWithTypeConverter<PaymentMethod, int> get paymentMethod =>
      $composableBuilder(
        column: $table.paymentMethod,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<LocationType, int> get locationType =>
      $composableBuilder(
        column: $table.locationType,
        builder: (column) => column,
      );

  GeneratedColumn<int> get startBattery => $composableBuilder(
    column: $table.startBattery,
    builder: (column) => column,
  );

  GeneratedColumn<int> get endBattery => $composableBuilder(
    column: $table.endBattery,
    builder: (column) => column,
  );

  GeneratedColumn<String> get locationName => $composableBuilder(
    column: $table.locationName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<DateTime> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<String> get chargerType => $composableBuilder(
    column: $table.chargerType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get chargingMethod => $composableBuilder(
    column: $table.chargingMethod,
    builder: (column) => column,
  );

  GeneratedColumn<double> get electricityPrice => $composableBuilder(
    column: $table.electricityPrice,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<List<String>, String> get photoPaths =>
      $composableBuilder(
        column: $table.photoPaths,
        builder: (column) => column,
      );

  GeneratedColumn<int> get bikeId =>
      $composableBuilder(column: $table.bikeId, builder: (column) => column);

  GeneratedColumn<String> get providerName => $composableBuilder(
    column: $table.providerName,
    builder: (column) => column,
  );

  GeneratedColumn<double> get maxChargingPowerKw => $composableBuilder(
    column: $table.maxChargingPowerKw,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);
}

class $$ChargeLogsTableTableTableManager
    extends
        RootTableManager<
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
            BaseReferences<
              _$AppDatabase,
              $ChargeLogsTableTable,
              ChargeLogsTableData
            >,
          ),
          ChargeLogsTableData,
          PrefetchHooks Function()
        > {
  $$ChargeLogsTableTableTableManager(
    _$AppDatabase db,
    $ChargeLogsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChargeLogsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChargeLogsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChargeLogsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
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
                Value<DateTime?> startTime = const Value.absent(),
                Value<DateTime?> endTime = const Value.absent(),
                Value<String?> chargerType = const Value.absent(),
                Value<String?> chargingMethod = const Value.absent(),
                Value<double?> electricityPrice = const Value.absent(),
                Value<List<String>> photoPaths = const Value.absent(),
                Value<int?> bikeId = const Value.absent(),
                Value<String?> providerName = const Value.absent(),
                Value<double?> maxChargingPowerKw = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChargeLogsTableCompanion(
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
                startTime: startTime,
                endTime: endTime,
                chargerType: chargerType,
                chargingMethod: chargingMethod,
                electricityPrice: electricityPrice,
                photoPaths: photoPaths,
                bikeId: bikeId,
                providerName: providerName,
                maxChargingPowerKw: maxChargingPowerKw,
                source: source,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
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
                Value<DateTime?> startTime = const Value.absent(),
                Value<DateTime?> endTime = const Value.absent(),
                Value<String?> chargerType = const Value.absent(),
                Value<String?> chargingMethod = const Value.absent(),
                Value<double?> electricityPrice = const Value.absent(),
                Value<List<String>> photoPaths = const Value.absent(),
                Value<int?> bikeId = const Value.absent(),
                Value<String?> providerName = const Value.absent(),
                Value<double?> maxChargingPowerKw = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChargeLogsTableCompanion.insert(
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
                startTime: startTime,
                endTime: endTime,
                chargerType: chargerType,
                chargingMethod: chargingMethod,
                electricityPrice: electricityPrice,
                photoPaths: photoPaths,
                bikeId: bikeId,
                providerName: providerName,
                maxChargingPowerKw: maxChargingPowerKw,
                source: source,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ChargeLogsTableTableProcessedTableManager =
    ProcessedTableManager<
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
        BaseReferences<
          _$AppDatabase,
          $ChargeLogsTableTable,
          ChargeLogsTableData
        >,
      ),
      ChargeLogsTableData,
      PrefetchHooks Function()
    >;
typedef $$ExpensesTableTableCreateCompanionBuilder =
    ExpensesTableCompanion Function({
      required String id,
      required DateTime date,
      required ExpenseCategory category,
      required double amount,
      Value<String?> notes,
      Value<String?> receiptPhotoPath,
      Value<String?> description,
      Value<int?> bikeId,
      Value<int> rowid,
    });
typedef $$ExpensesTableTableUpdateCompanionBuilder =
    ExpensesTableCompanion Function({
      Value<String> id,
      Value<DateTime> date,
      Value<ExpenseCategory> category,
      Value<double> amount,
      Value<String?> notes,
      Value<String?> receiptPhotoPath,
      Value<String?> description,
      Value<int?> bikeId,
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
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ExpenseCategory, ExpenseCategory, int>
  get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get receiptPhotoPath => $composableBuilder(
    column: $table.receiptPhotoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bikeId => $composableBuilder(
    column: $table.bikeId,
    builder: (column) => ColumnFilters(column),
  );
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
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get receiptPhotoPath => $composableBuilder(
    column: $table.receiptPhotoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bikeId => $composableBuilder(
    column: $table.bikeId,
    builder: (column) => ColumnOrderings(column),
  );
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
    column: $table.receiptPhotoPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get bikeId =>
      $composableBuilder(column: $table.bikeId, builder: (column) => column);
}

class $$ExpensesTableTableTableManager
    extends
        RootTableManager<
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
            BaseReferences<
              _$AppDatabase,
              $ExpensesTableTable,
              ExpensesTableData
            >,
          ),
          ExpensesTableData,
          PrefetchHooks Function()
        > {
  $$ExpensesTableTableTableManager(_$AppDatabase db, $ExpensesTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpensesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpensesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpensesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<ExpenseCategory> category = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> receiptPhotoPath = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<int?> bikeId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExpensesTableCompanion(
                id: id,
                date: date,
                category: category,
                amount: amount,
                notes: notes,
                receiptPhotoPath: receiptPhotoPath,
                description: description,
                bikeId: bikeId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime date,
                required ExpenseCategory category,
                required double amount,
                Value<String?> notes = const Value.absent(),
                Value<String?> receiptPhotoPath = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<int?> bikeId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExpensesTableCompanion.insert(
                id: id,
                date: date,
                category: category,
                amount: amount,
                notes: notes,
                receiptPhotoPath: receiptPhotoPath,
                description: description,
                bikeId: bikeId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExpensesTableTableProcessedTableManager =
    ProcessedTableManager<
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
        BaseReferences<_$AppDatabase, $ExpensesTableTable, ExpensesTableData>,
      ),
      ExpensesTableData,
      PrefetchHooks Function()
    >;
typedef $$MaintenanceLogsTableTableCreateCompanionBuilder =
    MaintenanceLogsTableCompanion Function({
      required String id,
      required DateTime date,
      required MaintenanceComponent component,
      required String description,
      required double odometerReading,
      required double cost,
      Value<String?> serviceCenter,
      Value<String?> partsReplaced,
      Value<double?> labourCost,
      Value<bool> warrantyClaim,
      Value<String?> technician,
      Value<String?> invoicePhotoPath,
      Value<String?> notes,
      Value<double?> nextServiceDueOdometer,
      Value<DateTime?> nextServiceDueDate,
      Value<bool> tyres,
      Value<bool> brakes,
      Value<bool> battery,
      Value<bool> suspension,
      Value<bool> motor,
      Value<bool> lights,
      Value<bool> horn,
      Value<bool> softwareUpdate,
      Value<bool> generalInspection,
      Value<int?> bikeId,
      Value<int> rowid,
    });
typedef $$MaintenanceLogsTableTableUpdateCompanionBuilder =
    MaintenanceLogsTableCompanion Function({
      Value<String> id,
      Value<DateTime> date,
      Value<MaintenanceComponent> component,
      Value<String> description,
      Value<double> odometerReading,
      Value<double> cost,
      Value<String?> serviceCenter,
      Value<String?> partsReplaced,
      Value<double?> labourCost,
      Value<bool> warrantyClaim,
      Value<String?> technician,
      Value<String?> invoicePhotoPath,
      Value<String?> notes,
      Value<double?> nextServiceDueOdometer,
      Value<DateTime?> nextServiceDueDate,
      Value<bool> tyres,
      Value<bool> brakes,
      Value<bool> battery,
      Value<bool> suspension,
      Value<bool> motor,
      Value<bool> lights,
      Value<bool> horn,
      Value<bool> softwareUpdate,
      Value<bool> generalInspection,
      Value<int?> bikeId,
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
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    MaintenanceComponent,
    MaintenanceComponent,
    int
  >
  get component => $composableBuilder(
    column: $table.component,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get odometerReading => $composableBuilder(
    column: $table.odometerReading,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cost => $composableBuilder(
    column: $table.cost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serviceCenter => $composableBuilder(
    column: $table.serviceCenter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get partsReplaced => $composableBuilder(
    column: $table.partsReplaced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get labourCost => $composableBuilder(
    column: $table.labourCost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get warrantyClaim => $composableBuilder(
    column: $table.warrantyClaim,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get technician => $composableBuilder(
    column: $table.technician,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get invoicePhotoPath => $composableBuilder(
    column: $table.invoicePhotoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get nextServiceDueOdometer => $composableBuilder(
    column: $table.nextServiceDueOdometer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextServiceDueDate => $composableBuilder(
    column: $table.nextServiceDueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get tyres => $composableBuilder(
    column: $table.tyres,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get brakes => $composableBuilder(
    column: $table.brakes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get battery => $composableBuilder(
    column: $table.battery,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get suspension => $composableBuilder(
    column: $table.suspension,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get motor => $composableBuilder(
    column: $table.motor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get lights => $composableBuilder(
    column: $table.lights,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get horn => $composableBuilder(
    column: $table.horn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get softwareUpdate => $composableBuilder(
    column: $table.softwareUpdate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get generalInspection => $composableBuilder(
    column: $table.generalInspection,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bikeId => $composableBuilder(
    column: $table.bikeId,
    builder: (column) => ColumnFilters(column),
  );
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
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get component => $composableBuilder(
    column: $table.component,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get odometerReading => $composableBuilder(
    column: $table.odometerReading,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cost => $composableBuilder(
    column: $table.cost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serviceCenter => $composableBuilder(
    column: $table.serviceCenter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get partsReplaced => $composableBuilder(
    column: $table.partsReplaced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get labourCost => $composableBuilder(
    column: $table.labourCost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get warrantyClaim => $composableBuilder(
    column: $table.warrantyClaim,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get technician => $composableBuilder(
    column: $table.technician,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get invoicePhotoPath => $composableBuilder(
    column: $table.invoicePhotoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get nextServiceDueOdometer => $composableBuilder(
    column: $table.nextServiceDueOdometer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextServiceDueDate => $composableBuilder(
    column: $table.nextServiceDueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get tyres => $composableBuilder(
    column: $table.tyres,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get brakes => $composableBuilder(
    column: $table.brakes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get battery => $composableBuilder(
    column: $table.battery,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get suspension => $composableBuilder(
    column: $table.suspension,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get motor => $composableBuilder(
    column: $table.motor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get lights => $composableBuilder(
    column: $table.lights,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get horn => $composableBuilder(
    column: $table.horn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get softwareUpdate => $composableBuilder(
    column: $table.softwareUpdate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get generalInspection => $composableBuilder(
    column: $table.generalInspection,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bikeId => $composableBuilder(
    column: $table.bikeId,
    builder: (column) => ColumnOrderings(column),
  );
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
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<double> get odometerReading => $composableBuilder(
    column: $table.odometerReading,
    builder: (column) => column,
  );

  GeneratedColumn<double> get cost =>
      $composableBuilder(column: $table.cost, builder: (column) => column);

  GeneratedColumn<String> get serviceCenter => $composableBuilder(
    column: $table.serviceCenter,
    builder: (column) => column,
  );

  GeneratedColumn<String> get partsReplaced => $composableBuilder(
    column: $table.partsReplaced,
    builder: (column) => column,
  );

  GeneratedColumn<double> get labourCost => $composableBuilder(
    column: $table.labourCost,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get warrantyClaim => $composableBuilder(
    column: $table.warrantyClaim,
    builder: (column) => column,
  );

  GeneratedColumn<String> get technician => $composableBuilder(
    column: $table.technician,
    builder: (column) => column,
  );

  GeneratedColumn<String> get invoicePhotoPath => $composableBuilder(
    column: $table.invoicePhotoPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<double> get nextServiceDueOdometer => $composableBuilder(
    column: $table.nextServiceDueOdometer,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get nextServiceDueDate => $composableBuilder(
    column: $table.nextServiceDueDate,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get tyres =>
      $composableBuilder(column: $table.tyres, builder: (column) => column);

  GeneratedColumn<bool> get brakes =>
      $composableBuilder(column: $table.brakes, builder: (column) => column);

  GeneratedColumn<bool> get battery =>
      $composableBuilder(column: $table.battery, builder: (column) => column);

  GeneratedColumn<bool> get suspension => $composableBuilder(
    column: $table.suspension,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get motor =>
      $composableBuilder(column: $table.motor, builder: (column) => column);

  GeneratedColumn<bool> get lights =>
      $composableBuilder(column: $table.lights, builder: (column) => column);

  GeneratedColumn<bool> get horn =>
      $composableBuilder(column: $table.horn, builder: (column) => column);

  GeneratedColumn<bool> get softwareUpdate => $composableBuilder(
    column: $table.softwareUpdate,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get generalInspection => $composableBuilder(
    column: $table.generalInspection,
    builder: (column) => column,
  );

  GeneratedColumn<int> get bikeId =>
      $composableBuilder(column: $table.bikeId, builder: (column) => column);
}

class $$MaintenanceLogsTableTableTableManager
    extends
        RootTableManager<
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
            BaseReferences<
              _$AppDatabase,
              $MaintenanceLogsTableTable,
              MaintenanceLogsTableData
            >,
          ),
          MaintenanceLogsTableData,
          PrefetchHooks Function()
        > {
  $$MaintenanceLogsTableTableTableManager(
    _$AppDatabase db,
    $MaintenanceLogsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MaintenanceLogsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MaintenanceLogsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$MaintenanceLogsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<MaintenanceComponent> component = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<double> odometerReading = const Value.absent(),
                Value<double> cost = const Value.absent(),
                Value<String?> serviceCenter = const Value.absent(),
                Value<String?> partsReplaced = const Value.absent(),
                Value<double?> labourCost = const Value.absent(),
                Value<bool> warrantyClaim = const Value.absent(),
                Value<String?> technician = const Value.absent(),
                Value<String?> invoicePhotoPath = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<double?> nextServiceDueOdometer = const Value.absent(),
                Value<DateTime?> nextServiceDueDate = const Value.absent(),
                Value<bool> tyres = const Value.absent(),
                Value<bool> brakes = const Value.absent(),
                Value<bool> battery = const Value.absent(),
                Value<bool> suspension = const Value.absent(),
                Value<bool> motor = const Value.absent(),
                Value<bool> lights = const Value.absent(),
                Value<bool> horn = const Value.absent(),
                Value<bool> softwareUpdate = const Value.absent(),
                Value<bool> generalInspection = const Value.absent(),
                Value<int?> bikeId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MaintenanceLogsTableCompanion(
                id: id,
                date: date,
                component: component,
                description: description,
                odometerReading: odometerReading,
                cost: cost,
                serviceCenter: serviceCenter,
                partsReplaced: partsReplaced,
                labourCost: labourCost,
                warrantyClaim: warrantyClaim,
                technician: technician,
                invoicePhotoPath: invoicePhotoPath,
                notes: notes,
                nextServiceDueOdometer: nextServiceDueOdometer,
                nextServiceDueDate: nextServiceDueDate,
                tyres: tyres,
                brakes: brakes,
                battery: battery,
                suspension: suspension,
                motor: motor,
                lights: lights,
                horn: horn,
                softwareUpdate: softwareUpdate,
                generalInspection: generalInspection,
                bikeId: bikeId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime date,
                required MaintenanceComponent component,
                required String description,
                required double odometerReading,
                required double cost,
                Value<String?> serviceCenter = const Value.absent(),
                Value<String?> partsReplaced = const Value.absent(),
                Value<double?> labourCost = const Value.absent(),
                Value<bool> warrantyClaim = const Value.absent(),
                Value<String?> technician = const Value.absent(),
                Value<String?> invoicePhotoPath = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<double?> nextServiceDueOdometer = const Value.absent(),
                Value<DateTime?> nextServiceDueDate = const Value.absent(),
                Value<bool> tyres = const Value.absent(),
                Value<bool> brakes = const Value.absent(),
                Value<bool> battery = const Value.absent(),
                Value<bool> suspension = const Value.absent(),
                Value<bool> motor = const Value.absent(),
                Value<bool> lights = const Value.absent(),
                Value<bool> horn = const Value.absent(),
                Value<bool> softwareUpdate = const Value.absent(),
                Value<bool> generalInspection = const Value.absent(),
                Value<int?> bikeId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MaintenanceLogsTableCompanion.insert(
                id: id,
                date: date,
                component: component,
                description: description,
                odometerReading: odometerReading,
                cost: cost,
                serviceCenter: serviceCenter,
                partsReplaced: partsReplaced,
                labourCost: labourCost,
                warrantyClaim: warrantyClaim,
                technician: technician,
                invoicePhotoPath: invoicePhotoPath,
                notes: notes,
                nextServiceDueOdometer: nextServiceDueOdometer,
                nextServiceDueDate: nextServiceDueDate,
                tyres: tyres,
                brakes: brakes,
                battery: battery,
                suspension: suspension,
                motor: motor,
                lights: lights,
                horn: horn,
                softwareUpdate: softwareUpdate,
                generalInspection: generalInspection,
                bikeId: bikeId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MaintenanceLogsTableTableProcessedTableManager =
    ProcessedTableManager<
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
        BaseReferences<
          _$AppDatabase,
          $MaintenanceLogsTableTable,
          MaintenanceLogsTableData
        >,
      ),
      MaintenanceLogsTableData,
      PrefetchHooks Function()
    >;
typedef $$DocumentsTableTableCreateCompanionBuilder =
    DocumentsTableCompanion Function({
      Value<int> id,
      required String name,
      required String category,
      required String filePath,
      required DateTime uploadDate,
      Value<String?> notes,
      Value<int?> bikeId,
      Value<DateTime?> expiryDate,
    });
typedef $$DocumentsTableTableUpdateCompanionBuilder =
    DocumentsTableCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> category,
      Value<String> filePath,
      Value<DateTime> uploadDate,
      Value<String?> notes,
      Value<int?> bikeId,
      Value<DateTime?> expiryDate,
    });

class $$DocumentsTableTableFilterComposer
    extends Composer<_$AppDatabase, $DocumentsTableTable> {
  $$DocumentsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get uploadDate => $composableBuilder(
    column: $table.uploadDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bikeId => $composableBuilder(
    column: $table.bikeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expiryDate => $composableBuilder(
    column: $table.expiryDate,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DocumentsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $DocumentsTableTable> {
  $$DocumentsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get uploadDate => $composableBuilder(
    column: $table.uploadDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bikeId => $composableBuilder(
    column: $table.bikeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expiryDate => $composableBuilder(
    column: $table.expiryDate,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DocumentsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $DocumentsTableTable> {
  $$DocumentsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get filePath =>
      $composableBuilder(column: $table.filePath, builder: (column) => column);

  GeneratedColumn<DateTime> get uploadDate => $composableBuilder(
    column: $table.uploadDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get bikeId =>
      $composableBuilder(column: $table.bikeId, builder: (column) => column);

  GeneratedColumn<DateTime> get expiryDate => $composableBuilder(
    column: $table.expiryDate,
    builder: (column) => column,
  );
}

class $$DocumentsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DocumentsTableTable,
          DocumentsTableData,
          $$DocumentsTableTableFilterComposer,
          $$DocumentsTableTableOrderingComposer,
          $$DocumentsTableTableAnnotationComposer,
          $$DocumentsTableTableCreateCompanionBuilder,
          $$DocumentsTableTableUpdateCompanionBuilder,
          (
            DocumentsTableData,
            BaseReferences<
              _$AppDatabase,
              $DocumentsTableTable,
              DocumentsTableData
            >,
          ),
          DocumentsTableData,
          PrefetchHooks Function()
        > {
  $$DocumentsTableTableTableManager(
    _$AppDatabase db,
    $DocumentsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DocumentsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DocumentsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DocumentsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> filePath = const Value.absent(),
                Value<DateTime> uploadDate = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int?> bikeId = const Value.absent(),
                Value<DateTime?> expiryDate = const Value.absent(),
              }) => DocumentsTableCompanion(
                id: id,
                name: name,
                category: category,
                filePath: filePath,
                uploadDate: uploadDate,
                notes: notes,
                bikeId: bikeId,
                expiryDate: expiryDate,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String category,
                required String filePath,
                required DateTime uploadDate,
                Value<String?> notes = const Value.absent(),
                Value<int?> bikeId = const Value.absent(),
                Value<DateTime?> expiryDate = const Value.absent(),
              }) => DocumentsTableCompanion.insert(
                id: id,
                name: name,
                category: category,
                filePath: filePath,
                uploadDate: uploadDate,
                notes: notes,
                bikeId: bikeId,
                expiryDate: expiryDate,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DocumentsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DocumentsTableTable,
      DocumentsTableData,
      $$DocumentsTableTableFilterComposer,
      $$DocumentsTableTableOrderingComposer,
      $$DocumentsTableTableAnnotationComposer,
      $$DocumentsTableTableCreateCompanionBuilder,
      $$DocumentsTableTableUpdateCompanionBuilder,
      (
        DocumentsTableData,
        BaseReferences<_$AppDatabase, $DocumentsTableTable, DocumentsTableData>,
      ),
      DocumentsTableData,
      PrefetchHooks Function()
    >;
typedef $$RemindersTableTableCreateCompanionBuilder =
    RemindersTableCompanion Function({
      required String id,
      required String title,
      required String body,
      Value<DateTime?> targetDate,
      Value<double?> targetOdometer,
      Value<bool> isCompleted,
      Value<bool> isNotified,
      Value<String?> type,
      Value<String?> note,
      Value<bool> isActive,
      Value<int?> bikeId,
      Value<int> rowid,
    });
typedef $$RemindersTableTableUpdateCompanionBuilder =
    RemindersTableCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String> body,
      Value<DateTime?> targetDate,
      Value<double?> targetOdometer,
      Value<bool> isCompleted,
      Value<bool> isNotified,
      Value<String?> type,
      Value<String?> note,
      Value<bool> isActive,
      Value<int?> bikeId,
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
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get targetDate => $composableBuilder(
    column: $table.targetDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get targetOdometer => $composableBuilder(
    column: $table.targetOdometer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isNotified => $composableBuilder(
    column: $table.isNotified,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bikeId => $composableBuilder(
    column: $table.bikeId,
    builder: (column) => ColumnFilters(column),
  );
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
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get targetDate => $composableBuilder(
    column: $table.targetDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get targetOdometer => $composableBuilder(
    column: $table.targetOdometer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isNotified => $composableBuilder(
    column: $table.isNotified,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bikeId => $composableBuilder(
    column: $table.bikeId,
    builder: (column) => ColumnOrderings(column),
  );
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
    column: $table.targetDate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get targetOdometer => $composableBuilder(
    column: $table.targetOdometer,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isNotified => $composableBuilder(
    column: $table.isNotified,
    builder: (column) => column,
  );

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<int> get bikeId =>
      $composableBuilder(column: $table.bikeId, builder: (column) => column);
}

class $$RemindersTableTableTableManager
    extends
        RootTableManager<
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
            BaseReferences<
              _$AppDatabase,
              $RemindersTableTable,
              RemindersTableData
            >,
          ),
          RemindersTableData,
          PrefetchHooks Function()
        > {
  $$RemindersTableTableTableManager(
    _$AppDatabase db,
    $RemindersTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RemindersTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RemindersTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RemindersTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<DateTime?> targetDate = const Value.absent(),
                Value<double?> targetOdometer = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<bool> isNotified = const Value.absent(),
                Value<String?> type = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int?> bikeId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RemindersTableCompanion(
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
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required String body,
                Value<DateTime?> targetDate = const Value.absent(),
                Value<double?> targetOdometer = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<bool> isNotified = const Value.absent(),
                Value<String?> type = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int?> bikeId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RemindersTableCompanion.insert(
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
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RemindersTableTableProcessedTableManager =
    ProcessedTableManager<
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
        BaseReferences<_$AppDatabase, $RemindersTableTable, RemindersTableData>,
      ),
      RemindersTableData,
      PrefetchHooks Function()
    >;
typedef $$BatteryHealthSnapshotsTableTableCreateCompanionBuilder =
    BatteryHealthSnapshotsTableCompanion Function({
      required String id,
      required DateTime date,
      required double healthPercent,
      required double rangeAtFullCharge,
      Value<int?> bikeId,
      Value<int> rowid,
    });
typedef $$BatteryHealthSnapshotsTableTableUpdateCompanionBuilder =
    BatteryHealthSnapshotsTableCompanion Function({
      Value<String> id,
      Value<DateTime> date,
      Value<double> healthPercent,
      Value<double> rangeAtFullCharge,
      Value<int?> bikeId,
      Value<int> rowid,
    });

class $$BatteryHealthSnapshotsTableTableFilterComposer
    extends Composer<_$AppDatabase, $BatteryHealthSnapshotsTableTable> {
  $$BatteryHealthSnapshotsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get healthPercent => $composableBuilder(
    column: $table.healthPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rangeAtFullCharge => $composableBuilder(
    column: $table.rangeAtFullCharge,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bikeId => $composableBuilder(
    column: $table.bikeId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BatteryHealthSnapshotsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $BatteryHealthSnapshotsTableTable> {
  $$BatteryHealthSnapshotsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get healthPercent => $composableBuilder(
    column: $table.healthPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rangeAtFullCharge => $composableBuilder(
    column: $table.rangeAtFullCharge,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bikeId => $composableBuilder(
    column: $table.bikeId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BatteryHealthSnapshotsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $BatteryHealthSnapshotsTableTable> {
  $$BatteryHealthSnapshotsTableTableAnnotationComposer({
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

  GeneratedColumn<double> get healthPercent => $composableBuilder(
    column: $table.healthPercent,
    builder: (column) => column,
  );

  GeneratedColumn<double> get rangeAtFullCharge => $composableBuilder(
    column: $table.rangeAtFullCharge,
    builder: (column) => column,
  );

  GeneratedColumn<int> get bikeId =>
      $composableBuilder(column: $table.bikeId, builder: (column) => column);
}

class $$BatteryHealthSnapshotsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BatteryHealthSnapshotsTableTable,
          BatteryHealthSnapshotsTableData,
          $$BatteryHealthSnapshotsTableTableFilterComposer,
          $$BatteryHealthSnapshotsTableTableOrderingComposer,
          $$BatteryHealthSnapshotsTableTableAnnotationComposer,
          $$BatteryHealthSnapshotsTableTableCreateCompanionBuilder,
          $$BatteryHealthSnapshotsTableTableUpdateCompanionBuilder,
          (
            BatteryHealthSnapshotsTableData,
            BaseReferences<
              _$AppDatabase,
              $BatteryHealthSnapshotsTableTable,
              BatteryHealthSnapshotsTableData
            >,
          ),
          BatteryHealthSnapshotsTableData,
          PrefetchHooks Function()
        > {
  $$BatteryHealthSnapshotsTableTableTableManager(
    _$AppDatabase db,
    $BatteryHealthSnapshotsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BatteryHealthSnapshotsTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$BatteryHealthSnapshotsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$BatteryHealthSnapshotsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<double> healthPercent = const Value.absent(),
                Value<double> rangeAtFullCharge = const Value.absent(),
                Value<int?> bikeId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BatteryHealthSnapshotsTableCompanion(
                id: id,
                date: date,
                healthPercent: healthPercent,
                rangeAtFullCharge: rangeAtFullCharge,
                bikeId: bikeId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime date,
                required double healthPercent,
                required double rangeAtFullCharge,
                Value<int?> bikeId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BatteryHealthSnapshotsTableCompanion.insert(
                id: id,
                date: date,
                healthPercent: healthPercent,
                rangeAtFullCharge: rangeAtFullCharge,
                bikeId: bikeId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BatteryHealthSnapshotsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BatteryHealthSnapshotsTableTable,
      BatteryHealthSnapshotsTableData,
      $$BatteryHealthSnapshotsTableTableFilterComposer,
      $$BatteryHealthSnapshotsTableTableOrderingComposer,
      $$BatteryHealthSnapshotsTableTableAnnotationComposer,
      $$BatteryHealthSnapshotsTableTableCreateCompanionBuilder,
      $$BatteryHealthSnapshotsTableTableUpdateCompanionBuilder,
      (
        BatteryHealthSnapshotsTableData,
        BaseReferences<
          _$AppDatabase,
          $BatteryHealthSnapshotsTableTable,
          BatteryHealthSnapshotsTableData
        >,
      ),
      BatteryHealthSnapshotsTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BikesTableTableTableManager get bikesTable =>
      $$BikesTableTableTableManager(_db, _db.bikesTable);
  $$RidesTableTableTableManager get ridesTable =>
      $$RidesTableTableTableManager(_db, _db.ridesTable);
  $$ChargeLogsTableTableTableManager get chargeLogsTable =>
      $$ChargeLogsTableTableTableManager(_db, _db.chargeLogsTable);
  $$ExpensesTableTableTableManager get expensesTable =>
      $$ExpensesTableTableTableManager(_db, _db.expensesTable);
  $$MaintenanceLogsTableTableTableManager get maintenanceLogsTable =>
      $$MaintenanceLogsTableTableTableManager(_db, _db.maintenanceLogsTable);
  $$DocumentsTableTableTableManager get documentsTable =>
      $$DocumentsTableTableTableManager(_db, _db.documentsTable);
  $$RemindersTableTableTableManager get remindersTable =>
      $$RemindersTableTableTableManager(_db, _db.remindersTable);
  $$BatteryHealthSnapshotsTableTableTableManager
  get batteryHealthSnapshotsTable =>
      $$BatteryHealthSnapshotsTableTableTableManager(
        _db,
        _db.batteryHealthSnapshotsTable,
      );
}
