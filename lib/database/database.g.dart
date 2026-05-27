// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ItemsTable extends Items with TableInfo<$ItemsTable, Item> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ItemsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _defaultBardanaMeta = const VerificationMeta(
    'defaultBardana',
  );
  @override
  late final GeneratedColumn<double> defaultBardana = GeneratedColumn<double>(
    'default_bardana',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _defaultGstMeta = const VerificationMeta(
    'defaultGst',
  );
  @override
  late final GeneratedColumn<double> defaultGst = GeneratedColumn<double>(
    'default_gst',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    type,
    defaultBardana,
    defaultGst,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'items';
  @override
  VerificationContext validateIntegrity(
    Insertable<Item> instance, {
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
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    }
    if (data.containsKey('default_bardana')) {
      context.handle(
        _defaultBardanaMeta,
        defaultBardana.isAcceptableOrUnknown(
          data['default_bardana']!,
          _defaultBardanaMeta,
        ),
      );
    }
    if (data.containsKey('default_gst')) {
      context.handle(
        _defaultGstMeta,
        defaultGst.isAcceptableOrUnknown(data['default_gst']!, _defaultGstMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Item map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Item(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      ),
      defaultBardana: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}default_bardana'],
      )!,
      defaultGst: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}default_gst'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ItemsTable createAlias(String alias) {
    return $ItemsTable(attachedDatabase, alias);
  }
}

class Item extends DataClass implements Insertable<Item> {
  final int id;
  final String name;
  final String? type;
  final double defaultBardana;
  final double defaultGst;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Item({
    required this.id,
    required this.name,
    this.type,
    required this.defaultBardana,
    required this.defaultGst,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<String>(type);
    }
    map['default_bardana'] = Variable<double>(defaultBardana);
    map['default_gst'] = Variable<double>(defaultGst);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ItemsCompanion toCompanion(bool nullToAbsent) {
    return ItemsCompanion(
      id: Value(id),
      name: Value(name),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      defaultBardana: Value(defaultBardana),
      defaultGst: Value(defaultGst),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Item.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Item(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String?>(json['type']),
      defaultBardana: serializer.fromJson<double>(json['defaultBardana']),
      defaultGst: serializer.fromJson<double>(json['defaultGst']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String?>(type),
      'defaultBardana': serializer.toJson<double>(defaultBardana),
      'defaultGst': serializer.toJson<double>(defaultGst),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Item copyWith({
    int? id,
    String? name,
    Value<String?> type = const Value.absent(),
    double? defaultBardana,
    double? defaultGst,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Item(
    id: id ?? this.id,
    name: name ?? this.name,
    type: type.present ? type.value : this.type,
    defaultBardana: defaultBardana ?? this.defaultBardana,
    defaultGst: defaultGst ?? this.defaultGst,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Item copyWithCompanion(ItemsCompanion data) {
    return Item(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      defaultBardana: data.defaultBardana.present
          ? data.defaultBardana.value
          : this.defaultBardana,
      defaultGst: data.defaultGst.present
          ? data.defaultGst.value
          : this.defaultGst,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Item(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('defaultBardana: $defaultBardana, ')
          ..write('defaultGst: $defaultGst, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    type,
    defaultBardana,
    defaultGst,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Item &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.defaultBardana == this.defaultBardana &&
          other.defaultGst == this.defaultGst &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ItemsCompanion extends UpdateCompanion<Item> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> type;
  final Value<double> defaultBardana;
  final Value<double> defaultGst;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ItemsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.defaultBardana = const Value.absent(),
    this.defaultGst = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ItemsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.type = const Value.absent(),
    this.defaultBardana = const Value.absent(),
    this.defaultGst = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Item> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? type,
    Expression<double>? defaultBardana,
    Expression<double>? defaultGst,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (defaultBardana != null) 'default_bardana': defaultBardana,
      if (defaultGst != null) 'default_gst': defaultGst,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ItemsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? type,
    Value<double>? defaultBardana,
    Value<double>? defaultGst,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return ItemsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      defaultBardana: defaultBardana ?? this.defaultBardana,
      defaultGst: defaultGst ?? this.defaultGst,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (defaultBardana.present) {
      map['default_bardana'] = Variable<double>(defaultBardana.value);
    }
    if (defaultGst.present) {
      map['default_gst'] = Variable<double>(defaultGst.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItemsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('defaultBardana: $defaultBardana, ')
          ..write('defaultGst: $defaultGst, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $WholesalersTable extends Wholesalers
    with TableInfo<$WholesalersTable, Wholesaler> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WholesalersTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    phone,
    address,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wholesalers';
  @override
  VerificationContext validateIntegrity(
    Insertable<Wholesaler> instance, {
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
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Wholesaler map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Wholesaler(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $WholesalersTable createAlias(String alias) {
    return $WholesalersTable(attachedDatabase, alias);
  }
}

class Wholesaler extends DataClass implements Insertable<Wholesaler> {
  final int id;
  final String name;
  final String? phone;
  final String? address;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Wholesaler({
    required this.id,
    required this.name,
    this.phone,
    this.address,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  WholesalersCompanion toCompanion(bool nullToAbsent) {
    return WholesalersCompanion(
      id: Value(id),
      name: Value(name),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Wholesaler.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Wholesaler(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String?>(json['phone']),
      address: serializer.fromJson<String?>(json['address']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String?>(phone),
      'address': serializer.toJson<String?>(address),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Wholesaler copyWith({
    int? id,
    String? name,
    Value<String?> phone = const Value.absent(),
    Value<String?> address = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Wholesaler(
    id: id ?? this.id,
    name: name ?? this.name,
    phone: phone.present ? phone.value : this.phone,
    address: address.present ? address.value : this.address,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Wholesaler copyWithCompanion(WholesalersCompanion data) {
    return Wholesaler(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      address: data.address.present ? data.address.value : this.address,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Wholesaler(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, phone, address, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Wholesaler &&
          other.id == this.id &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.address == this.address &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class WholesalersCompanion extends UpdateCompanion<Wholesaler> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> phone;
  final Value<String?> address;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const WholesalersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  WholesalersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Wholesaler> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? address,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  WholesalersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? phone,
    Value<String?>? address,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return WholesalersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WholesalersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $RetailersTable extends Retailers
    with TableInfo<$RetailersTable, Retailer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RetailersTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    phone,
    address,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'retailers';
  @override
  VerificationContext validateIntegrity(
    Insertable<Retailer> instance, {
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
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Retailer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Retailer(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $RetailersTable createAlias(String alias) {
    return $RetailersTable(attachedDatabase, alias);
  }
}

class Retailer extends DataClass implements Insertable<Retailer> {
  final int id;
  final String name;
  final String? phone;
  final String? address;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Retailer({
    required this.id,
    required this.name,
    this.phone,
    this.address,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RetailersCompanion toCompanion(bool nullToAbsent) {
    return RetailersCompanion(
      id: Value(id),
      name: Value(name),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Retailer.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Retailer(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String?>(json['phone']),
      address: serializer.fromJson<String?>(json['address']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String?>(phone),
      'address': serializer.toJson<String?>(address),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Retailer copyWith({
    int? id,
    String? name,
    Value<String?> phone = const Value.absent(),
    Value<String?> address = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Retailer(
    id: id ?? this.id,
    name: name ?? this.name,
    phone: phone.present ? phone.value : this.phone,
    address: address.present ? address.value : this.address,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Retailer copyWithCompanion(RetailersCompanion data) {
    return Retailer(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      address: data.address.present ? data.address.value : this.address,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Retailer(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, phone, address, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Retailer &&
          other.id == this.id &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.address == this.address &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RetailersCompanion extends UpdateCompanion<Retailer> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> phone;
  final Value<String?> address;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const RetailersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  RetailersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Retailer> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? address,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  RetailersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? phone,
    Value<String?>? address,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return RetailersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RetailersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $WholesalerInventoryTable extends WholesalerInventory
    with TableInfo<$WholesalerInventoryTable, WholesalerInventoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WholesalerInventoryTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<int> itemId = GeneratedColumn<int>(
    'item_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES items (id)',
    ),
  );
  static const VerificationMeta _wholesalerIdMeta = const VerificationMeta(
    'wholesalerId',
  );
  @override
  late final GeneratedColumn<int> wholesalerId = GeneratedColumn<int>(
    'wholesaler_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES wholesalers (id)',
    ),
  );
  static const VerificationMeta _quantityToSellMeta = const VerificationMeta(
    'quantityToSell',
  );
  @override
  late final GeneratedColumn<double> quantityToSell = GeneratedColumn<double>(
    'quantity_to_sell',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _purchasePriceMeta = const VerificationMeta(
    'purchasePrice',
  );
  @override
  late final GeneratedColumn<double> purchasePrice = GeneratedColumn<double>(
    'purchase_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bardanaMeta = const VerificationMeta(
    'bardana',
  );
  @override
  late final GeneratedColumn<double> bardana = GeneratedColumn<double>(
    'bardana',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _receivedAtMeta = const VerificationMeta(
    'receivedAt',
  );
  @override
  late final GeneratedColumn<DateTime> receivedAt = GeneratedColumn<DateTime>(
    'received_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    itemId,
    wholesalerId,
    quantityToSell,
    purchasePrice,
    bardana,
    receivedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wholesaler_inventory';
  @override
  VerificationContext validateIntegrity(
    Insertable<WholesalerInventoryData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('item_id')) {
      context.handle(
        _itemIdMeta,
        itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta),
      );
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('wholesaler_id')) {
      context.handle(
        _wholesalerIdMeta,
        wholesalerId.isAcceptableOrUnknown(
          data['wholesaler_id']!,
          _wholesalerIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_wholesalerIdMeta);
    }
    if (data.containsKey('quantity_to_sell')) {
      context.handle(
        _quantityToSellMeta,
        quantityToSell.isAcceptableOrUnknown(
          data['quantity_to_sell']!,
          _quantityToSellMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_quantityToSellMeta);
    }
    if (data.containsKey('purchase_price')) {
      context.handle(
        _purchasePriceMeta,
        purchasePrice.isAcceptableOrUnknown(
          data['purchase_price']!,
          _purchasePriceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_purchasePriceMeta);
    }
    if (data.containsKey('bardana')) {
      context.handle(
        _bardanaMeta,
        bardana.isAcceptableOrUnknown(data['bardana']!, _bardanaMeta),
      );
    }
    if (data.containsKey('received_at')) {
      context.handle(
        _receivedAtMeta,
        receivedAt.isAcceptableOrUnknown(data['received_at']!, _receivedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WholesalerInventoryData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WholesalerInventoryData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      itemId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}item_id'],
      )!,
      wholesalerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}wholesaler_id'],
      )!,
      quantityToSell: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantity_to_sell'],
      )!,
      purchasePrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}purchase_price'],
      )!,
      bardana: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}bardana'],
      )!,
      receivedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}received_at'],
      )!,
    );
  }

  @override
  $WholesalerInventoryTable createAlias(String alias) {
    return $WholesalerInventoryTable(attachedDatabase, alias);
  }
}

class WholesalerInventoryData extends DataClass
    implements Insertable<WholesalerInventoryData> {
  final int id;
  final int itemId;
  final int wholesalerId;
  final double quantityToSell;
  final double purchasePrice;
  final double bardana;
  final DateTime receivedAt;
  const WholesalerInventoryData({
    required this.id,
    required this.itemId,
    required this.wholesalerId,
    required this.quantityToSell,
    required this.purchasePrice,
    required this.bardana,
    required this.receivedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['item_id'] = Variable<int>(itemId);
    map['wholesaler_id'] = Variable<int>(wholesalerId);
    map['quantity_to_sell'] = Variable<double>(quantityToSell);
    map['purchase_price'] = Variable<double>(purchasePrice);
    map['bardana'] = Variable<double>(bardana);
    map['received_at'] = Variable<DateTime>(receivedAt);
    return map;
  }

  WholesalerInventoryCompanion toCompanion(bool nullToAbsent) {
    return WholesalerInventoryCompanion(
      id: Value(id),
      itemId: Value(itemId),
      wholesalerId: Value(wholesalerId),
      quantityToSell: Value(quantityToSell),
      purchasePrice: Value(purchasePrice),
      bardana: Value(bardana),
      receivedAt: Value(receivedAt),
    );
  }

  factory WholesalerInventoryData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WholesalerInventoryData(
      id: serializer.fromJson<int>(json['id']),
      itemId: serializer.fromJson<int>(json['itemId']),
      wholesalerId: serializer.fromJson<int>(json['wholesalerId']),
      quantityToSell: serializer.fromJson<double>(json['quantityToSell']),
      purchasePrice: serializer.fromJson<double>(json['purchasePrice']),
      bardana: serializer.fromJson<double>(json['bardana']),
      receivedAt: serializer.fromJson<DateTime>(json['receivedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'itemId': serializer.toJson<int>(itemId),
      'wholesalerId': serializer.toJson<int>(wholesalerId),
      'quantityToSell': serializer.toJson<double>(quantityToSell),
      'purchasePrice': serializer.toJson<double>(purchasePrice),
      'bardana': serializer.toJson<double>(bardana),
      'receivedAt': serializer.toJson<DateTime>(receivedAt),
    };
  }

  WholesalerInventoryData copyWith({
    int? id,
    int? itemId,
    int? wholesalerId,
    double? quantityToSell,
    double? purchasePrice,
    double? bardana,
    DateTime? receivedAt,
  }) => WholesalerInventoryData(
    id: id ?? this.id,
    itemId: itemId ?? this.itemId,
    wholesalerId: wholesalerId ?? this.wholesalerId,
    quantityToSell: quantityToSell ?? this.quantityToSell,
    purchasePrice: purchasePrice ?? this.purchasePrice,
    bardana: bardana ?? this.bardana,
    receivedAt: receivedAt ?? this.receivedAt,
  );
  WholesalerInventoryData copyWithCompanion(WholesalerInventoryCompanion data) {
    return WholesalerInventoryData(
      id: data.id.present ? data.id.value : this.id,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      wholesalerId: data.wholesalerId.present
          ? data.wholesalerId.value
          : this.wholesalerId,
      quantityToSell: data.quantityToSell.present
          ? data.quantityToSell.value
          : this.quantityToSell,
      purchasePrice: data.purchasePrice.present
          ? data.purchasePrice.value
          : this.purchasePrice,
      bardana: data.bardana.present ? data.bardana.value : this.bardana,
      receivedAt: data.receivedAt.present
          ? data.receivedAt.value
          : this.receivedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WholesalerInventoryData(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('wholesalerId: $wholesalerId, ')
          ..write('quantityToSell: $quantityToSell, ')
          ..write('purchasePrice: $purchasePrice, ')
          ..write('bardana: $bardana, ')
          ..write('receivedAt: $receivedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    itemId,
    wholesalerId,
    quantityToSell,
    purchasePrice,
    bardana,
    receivedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WholesalerInventoryData &&
          other.id == this.id &&
          other.itemId == this.itemId &&
          other.wholesalerId == this.wholesalerId &&
          other.quantityToSell == this.quantityToSell &&
          other.purchasePrice == this.purchasePrice &&
          other.bardana == this.bardana &&
          other.receivedAt == this.receivedAt);
}

class WholesalerInventoryCompanion
    extends UpdateCompanion<WholesalerInventoryData> {
  final Value<int> id;
  final Value<int> itemId;
  final Value<int> wholesalerId;
  final Value<double> quantityToSell;
  final Value<double> purchasePrice;
  final Value<double> bardana;
  final Value<DateTime> receivedAt;
  const WholesalerInventoryCompanion({
    this.id = const Value.absent(),
    this.itemId = const Value.absent(),
    this.wholesalerId = const Value.absent(),
    this.quantityToSell = const Value.absent(),
    this.purchasePrice = const Value.absent(),
    this.bardana = const Value.absent(),
    this.receivedAt = const Value.absent(),
  });
  WholesalerInventoryCompanion.insert({
    this.id = const Value.absent(),
    required int itemId,
    required int wholesalerId,
    required double quantityToSell,
    required double purchasePrice,
    this.bardana = const Value.absent(),
    this.receivedAt = const Value.absent(),
  }) : itemId = Value(itemId),
       wholesalerId = Value(wholesalerId),
       quantityToSell = Value(quantityToSell),
       purchasePrice = Value(purchasePrice);
  static Insertable<WholesalerInventoryData> custom({
    Expression<int>? id,
    Expression<int>? itemId,
    Expression<int>? wholesalerId,
    Expression<double>? quantityToSell,
    Expression<double>? purchasePrice,
    Expression<double>? bardana,
    Expression<DateTime>? receivedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (itemId != null) 'item_id': itemId,
      if (wholesalerId != null) 'wholesaler_id': wholesalerId,
      if (quantityToSell != null) 'quantity_to_sell': quantityToSell,
      if (purchasePrice != null) 'purchase_price': purchasePrice,
      if (bardana != null) 'bardana': bardana,
      if (receivedAt != null) 'received_at': receivedAt,
    });
  }

  WholesalerInventoryCompanion copyWith({
    Value<int>? id,
    Value<int>? itemId,
    Value<int>? wholesalerId,
    Value<double>? quantityToSell,
    Value<double>? purchasePrice,
    Value<double>? bardana,
    Value<DateTime>? receivedAt,
  }) {
    return WholesalerInventoryCompanion(
      id: id ?? this.id,
      itemId: itemId ?? this.itemId,
      wholesalerId: wholesalerId ?? this.wholesalerId,
      quantityToSell: quantityToSell ?? this.quantityToSell,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      bardana: bardana ?? this.bardana,
      receivedAt: receivedAt ?? this.receivedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<int>(itemId.value);
    }
    if (wholesalerId.present) {
      map['wholesaler_id'] = Variable<int>(wholesalerId.value);
    }
    if (quantityToSell.present) {
      map['quantity_to_sell'] = Variable<double>(quantityToSell.value);
    }
    if (purchasePrice.present) {
      map['purchase_price'] = Variable<double>(purchasePrice.value);
    }
    if (bardana.present) {
      map['bardana'] = Variable<double>(bardana.value);
    }
    if (receivedAt.present) {
      map['received_at'] = Variable<DateTime>(receivedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WholesalerInventoryCompanion(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('wholesalerId: $wholesalerId, ')
          ..write('quantityToSell: $quantityToSell, ')
          ..write('purchasePrice: $purchasePrice, ')
          ..write('bardana: $bardana, ')
          ..write('receivedAt: $receivedAt')
          ..write(')'))
        .toString();
  }
}

class $RetailerBillsTable extends RetailerBills
    with TableInfo<$RetailerBillsTable, RetailerBill> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RetailerBillsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _retailerIdMeta = const VerificationMeta(
    'retailerId',
  );
  @override
  late final GeneratedColumn<int> retailerId = GeneratedColumn<int>(
    'retailer_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES retailers (id)',
    ),
  );
  static const VerificationMeta _totalAmountMeta = const VerificationMeta(
    'totalAmount',
  );
  @override
  late final GeneratedColumn<double> totalAmount = GeneratedColumn<double>(
    'total_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _taxAmountMeta = const VerificationMeta(
    'taxAmount',
  );
  @override
  late final GeneratedColumn<double> taxAmount = GeneratedColumn<double>(
    'tax_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _bardanaAmountMeta = const VerificationMeta(
    'bardanaAmount',
  );
  @override
  late final GeneratedColumn<double> bardanaAmount = GeneratedColumn<double>(
    'bardana_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _pdfPathMeta = const VerificationMeta(
    'pdfPath',
  );
  @override
  late final GeneratedColumn<String> pdfPath = GeneratedColumn<String>(
    'pdf_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    retailerId,
    totalAmount,
    taxAmount,
    bardanaAmount,
    date,
    pdfPath,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'retailer_bills';
  @override
  VerificationContext validateIntegrity(
    Insertable<RetailerBill> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('retailer_id')) {
      context.handle(
        _retailerIdMeta,
        retailerId.isAcceptableOrUnknown(data['retailer_id']!, _retailerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_retailerIdMeta);
    }
    if (data.containsKey('total_amount')) {
      context.handle(
        _totalAmountMeta,
        totalAmount.isAcceptableOrUnknown(
          data['total_amount']!,
          _totalAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalAmountMeta);
    }
    if (data.containsKey('tax_amount')) {
      context.handle(
        _taxAmountMeta,
        taxAmount.isAcceptableOrUnknown(data['tax_amount']!, _taxAmountMeta),
      );
    }
    if (data.containsKey('bardana_amount')) {
      context.handle(
        _bardanaAmountMeta,
        bardanaAmount.isAcceptableOrUnknown(
          data['bardana_amount']!,
          _bardanaAmountMeta,
        ),
      );
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    }
    if (data.containsKey('pdf_path')) {
      context.handle(
        _pdfPathMeta,
        pdfPath.isAcceptableOrUnknown(data['pdf_path']!, _pdfPathMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RetailerBill map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RetailerBill(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      retailerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}retailer_id'],
      )!,
      totalAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_amount'],
      )!,
      taxAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tax_amount'],
      )!,
      bardanaAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}bardana_amount'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      pdfPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pdf_path'],
      ),
    );
  }

  @override
  $RetailerBillsTable createAlias(String alias) {
    return $RetailerBillsTable(attachedDatabase, alias);
  }
}

class RetailerBill extends DataClass implements Insertable<RetailerBill> {
  final int id;
  final int retailerId;
  final double totalAmount;
  final double taxAmount;
  final double bardanaAmount;
  final DateTime date;
  final String? pdfPath;
  const RetailerBill({
    required this.id,
    required this.retailerId,
    required this.totalAmount,
    required this.taxAmount,
    required this.bardanaAmount,
    required this.date,
    this.pdfPath,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['retailer_id'] = Variable<int>(retailerId);
    map['total_amount'] = Variable<double>(totalAmount);
    map['tax_amount'] = Variable<double>(taxAmount);
    map['bardana_amount'] = Variable<double>(bardanaAmount);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || pdfPath != null) {
      map['pdf_path'] = Variable<String>(pdfPath);
    }
    return map;
  }

  RetailerBillsCompanion toCompanion(bool nullToAbsent) {
    return RetailerBillsCompanion(
      id: Value(id),
      retailerId: Value(retailerId),
      totalAmount: Value(totalAmount),
      taxAmount: Value(taxAmount),
      bardanaAmount: Value(bardanaAmount),
      date: Value(date),
      pdfPath: pdfPath == null && nullToAbsent
          ? const Value.absent()
          : Value(pdfPath),
    );
  }

  factory RetailerBill.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RetailerBill(
      id: serializer.fromJson<int>(json['id']),
      retailerId: serializer.fromJson<int>(json['retailerId']),
      totalAmount: serializer.fromJson<double>(json['totalAmount']),
      taxAmount: serializer.fromJson<double>(json['taxAmount']),
      bardanaAmount: serializer.fromJson<double>(json['bardanaAmount']),
      date: serializer.fromJson<DateTime>(json['date']),
      pdfPath: serializer.fromJson<String?>(json['pdfPath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'retailerId': serializer.toJson<int>(retailerId),
      'totalAmount': serializer.toJson<double>(totalAmount),
      'taxAmount': serializer.toJson<double>(taxAmount),
      'bardanaAmount': serializer.toJson<double>(bardanaAmount),
      'date': serializer.toJson<DateTime>(date),
      'pdfPath': serializer.toJson<String?>(pdfPath),
    };
  }

  RetailerBill copyWith({
    int? id,
    int? retailerId,
    double? totalAmount,
    double? taxAmount,
    double? bardanaAmount,
    DateTime? date,
    Value<String?> pdfPath = const Value.absent(),
  }) => RetailerBill(
    id: id ?? this.id,
    retailerId: retailerId ?? this.retailerId,
    totalAmount: totalAmount ?? this.totalAmount,
    taxAmount: taxAmount ?? this.taxAmount,
    bardanaAmount: bardanaAmount ?? this.bardanaAmount,
    date: date ?? this.date,
    pdfPath: pdfPath.present ? pdfPath.value : this.pdfPath,
  );
  RetailerBill copyWithCompanion(RetailerBillsCompanion data) {
    return RetailerBill(
      id: data.id.present ? data.id.value : this.id,
      retailerId: data.retailerId.present
          ? data.retailerId.value
          : this.retailerId,
      totalAmount: data.totalAmount.present
          ? data.totalAmount.value
          : this.totalAmount,
      taxAmount: data.taxAmount.present ? data.taxAmount.value : this.taxAmount,
      bardanaAmount: data.bardanaAmount.present
          ? data.bardanaAmount.value
          : this.bardanaAmount,
      date: data.date.present ? data.date.value : this.date,
      pdfPath: data.pdfPath.present ? data.pdfPath.value : this.pdfPath,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RetailerBill(')
          ..write('id: $id, ')
          ..write('retailerId: $retailerId, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('taxAmount: $taxAmount, ')
          ..write('bardanaAmount: $bardanaAmount, ')
          ..write('date: $date, ')
          ..write('pdfPath: $pdfPath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    retailerId,
    totalAmount,
    taxAmount,
    bardanaAmount,
    date,
    pdfPath,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RetailerBill &&
          other.id == this.id &&
          other.retailerId == this.retailerId &&
          other.totalAmount == this.totalAmount &&
          other.taxAmount == this.taxAmount &&
          other.bardanaAmount == this.bardanaAmount &&
          other.date == this.date &&
          other.pdfPath == this.pdfPath);
}

class RetailerBillsCompanion extends UpdateCompanion<RetailerBill> {
  final Value<int> id;
  final Value<int> retailerId;
  final Value<double> totalAmount;
  final Value<double> taxAmount;
  final Value<double> bardanaAmount;
  final Value<DateTime> date;
  final Value<String?> pdfPath;
  const RetailerBillsCompanion({
    this.id = const Value.absent(),
    this.retailerId = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.taxAmount = const Value.absent(),
    this.bardanaAmount = const Value.absent(),
    this.date = const Value.absent(),
    this.pdfPath = const Value.absent(),
  });
  RetailerBillsCompanion.insert({
    this.id = const Value.absent(),
    required int retailerId,
    required double totalAmount,
    this.taxAmount = const Value.absent(),
    this.bardanaAmount = const Value.absent(),
    this.date = const Value.absent(),
    this.pdfPath = const Value.absent(),
  }) : retailerId = Value(retailerId),
       totalAmount = Value(totalAmount);
  static Insertable<RetailerBill> custom({
    Expression<int>? id,
    Expression<int>? retailerId,
    Expression<double>? totalAmount,
    Expression<double>? taxAmount,
    Expression<double>? bardanaAmount,
    Expression<DateTime>? date,
    Expression<String>? pdfPath,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (retailerId != null) 'retailer_id': retailerId,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (taxAmount != null) 'tax_amount': taxAmount,
      if (bardanaAmount != null) 'bardana_amount': bardanaAmount,
      if (date != null) 'date': date,
      if (pdfPath != null) 'pdf_path': pdfPath,
    });
  }

  RetailerBillsCompanion copyWith({
    Value<int>? id,
    Value<int>? retailerId,
    Value<double>? totalAmount,
    Value<double>? taxAmount,
    Value<double>? bardanaAmount,
    Value<DateTime>? date,
    Value<String?>? pdfPath,
  }) {
    return RetailerBillsCompanion(
      id: id ?? this.id,
      retailerId: retailerId ?? this.retailerId,
      totalAmount: totalAmount ?? this.totalAmount,
      taxAmount: taxAmount ?? this.taxAmount,
      bardanaAmount: bardanaAmount ?? this.bardanaAmount,
      date: date ?? this.date,
      pdfPath: pdfPath ?? this.pdfPath,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (retailerId.present) {
      map['retailer_id'] = Variable<int>(retailerId.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<double>(totalAmount.value);
    }
    if (taxAmount.present) {
      map['tax_amount'] = Variable<double>(taxAmount.value);
    }
    if (bardanaAmount.present) {
      map['bardana_amount'] = Variable<double>(bardanaAmount.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (pdfPath.present) {
      map['pdf_path'] = Variable<String>(pdfPath.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RetailerBillsCompanion(')
          ..write('id: $id, ')
          ..write('retailerId: $retailerId, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('taxAmount: $taxAmount, ')
          ..write('bardanaAmount: $bardanaAmount, ')
          ..write('date: $date, ')
          ..write('pdfPath: $pdfPath')
          ..write(')'))
        .toString();
  }
}

class $RetailerBillItemsTable extends RetailerBillItems
    with TableInfo<$RetailerBillItemsTable, RetailerBillItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RetailerBillItemsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _billIdMeta = const VerificationMeta('billId');
  @override
  late final GeneratedColumn<int> billId = GeneratedColumn<int>(
    'bill_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES retailer_bills (id)',
    ),
  );
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<int> itemId = GeneratedColumn<int>(
    'item_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES items (id)',
    ),
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sellingPriceMeta = const VerificationMeta(
    'sellingPrice',
  );
  @override
  late final GeneratedColumn<double> sellingPrice = GeneratedColumn<double>(
    'selling_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gstRateMeta = const VerificationMeta(
    'gstRate',
  );
  @override
  late final GeneratedColumn<double> gstRate = GeneratedColumn<double>(
    'gst_rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bardanaMeta = const VerificationMeta(
    'bardana',
  );
  @override
  late final GeneratedColumn<double> bardana = GeneratedColumn<double>(
    'bardana',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    billId,
    itemId,
    quantity,
    sellingPrice,
    gstRate,
    bardana,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'retailer_bill_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<RetailerBillItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('bill_id')) {
      context.handle(
        _billIdMeta,
        billId.isAcceptableOrUnknown(data['bill_id']!, _billIdMeta),
      );
    } else if (isInserting) {
      context.missing(_billIdMeta);
    }
    if (data.containsKey('item_id')) {
      context.handle(
        _itemIdMeta,
        itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta),
      );
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('selling_price')) {
      context.handle(
        _sellingPriceMeta,
        sellingPrice.isAcceptableOrUnknown(
          data['selling_price']!,
          _sellingPriceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sellingPriceMeta);
    }
    if (data.containsKey('gst_rate')) {
      context.handle(
        _gstRateMeta,
        gstRate.isAcceptableOrUnknown(data['gst_rate']!, _gstRateMeta),
      );
    } else if (isInserting) {
      context.missing(_gstRateMeta);
    }
    if (data.containsKey('bardana')) {
      context.handle(
        _bardanaMeta,
        bardana.isAcceptableOrUnknown(data['bardana']!, _bardanaMeta),
      );
    } else if (isInserting) {
      context.missing(_bardanaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RetailerBillItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RetailerBillItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      billId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bill_id'],
      )!,
      itemId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}item_id'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantity'],
      )!,
      sellingPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}selling_price'],
      )!,
      gstRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}gst_rate'],
      )!,
      bardana: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}bardana'],
      )!,
    );
  }

  @override
  $RetailerBillItemsTable createAlias(String alias) {
    return $RetailerBillItemsTable(attachedDatabase, alias);
  }
}

class RetailerBillItem extends DataClass
    implements Insertable<RetailerBillItem> {
  final int id;
  final int billId;
  final int itemId;
  final double quantity;
  final double sellingPrice;
  final double gstRate;
  final double bardana;
  const RetailerBillItem({
    required this.id,
    required this.billId,
    required this.itemId,
    required this.quantity,
    required this.sellingPrice,
    required this.gstRate,
    required this.bardana,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['bill_id'] = Variable<int>(billId);
    map['item_id'] = Variable<int>(itemId);
    map['quantity'] = Variable<double>(quantity);
    map['selling_price'] = Variable<double>(sellingPrice);
    map['gst_rate'] = Variable<double>(gstRate);
    map['bardana'] = Variable<double>(bardana);
    return map;
  }

  RetailerBillItemsCompanion toCompanion(bool nullToAbsent) {
    return RetailerBillItemsCompanion(
      id: Value(id),
      billId: Value(billId),
      itemId: Value(itemId),
      quantity: Value(quantity),
      sellingPrice: Value(sellingPrice),
      gstRate: Value(gstRate),
      bardana: Value(bardana),
    );
  }

  factory RetailerBillItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RetailerBillItem(
      id: serializer.fromJson<int>(json['id']),
      billId: serializer.fromJson<int>(json['billId']),
      itemId: serializer.fromJson<int>(json['itemId']),
      quantity: serializer.fromJson<double>(json['quantity']),
      sellingPrice: serializer.fromJson<double>(json['sellingPrice']),
      gstRate: serializer.fromJson<double>(json['gstRate']),
      bardana: serializer.fromJson<double>(json['bardana']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'billId': serializer.toJson<int>(billId),
      'itemId': serializer.toJson<int>(itemId),
      'quantity': serializer.toJson<double>(quantity),
      'sellingPrice': serializer.toJson<double>(sellingPrice),
      'gstRate': serializer.toJson<double>(gstRate),
      'bardana': serializer.toJson<double>(bardana),
    };
  }

  RetailerBillItem copyWith({
    int? id,
    int? billId,
    int? itemId,
    double? quantity,
    double? sellingPrice,
    double? gstRate,
    double? bardana,
  }) => RetailerBillItem(
    id: id ?? this.id,
    billId: billId ?? this.billId,
    itemId: itemId ?? this.itemId,
    quantity: quantity ?? this.quantity,
    sellingPrice: sellingPrice ?? this.sellingPrice,
    gstRate: gstRate ?? this.gstRate,
    bardana: bardana ?? this.bardana,
  );
  RetailerBillItem copyWithCompanion(RetailerBillItemsCompanion data) {
    return RetailerBillItem(
      id: data.id.present ? data.id.value : this.id,
      billId: data.billId.present ? data.billId.value : this.billId,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      sellingPrice: data.sellingPrice.present
          ? data.sellingPrice.value
          : this.sellingPrice,
      gstRate: data.gstRate.present ? data.gstRate.value : this.gstRate,
      bardana: data.bardana.present ? data.bardana.value : this.bardana,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RetailerBillItem(')
          ..write('id: $id, ')
          ..write('billId: $billId, ')
          ..write('itemId: $itemId, ')
          ..write('quantity: $quantity, ')
          ..write('sellingPrice: $sellingPrice, ')
          ..write('gstRate: $gstRate, ')
          ..write('bardana: $bardana')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, billId, itemId, quantity, sellingPrice, gstRate, bardana);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RetailerBillItem &&
          other.id == this.id &&
          other.billId == this.billId &&
          other.itemId == this.itemId &&
          other.quantity == this.quantity &&
          other.sellingPrice == this.sellingPrice &&
          other.gstRate == this.gstRate &&
          other.bardana == this.bardana);
}

class RetailerBillItemsCompanion extends UpdateCompanion<RetailerBillItem> {
  final Value<int> id;
  final Value<int> billId;
  final Value<int> itemId;
  final Value<double> quantity;
  final Value<double> sellingPrice;
  final Value<double> gstRate;
  final Value<double> bardana;
  const RetailerBillItemsCompanion({
    this.id = const Value.absent(),
    this.billId = const Value.absent(),
    this.itemId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.sellingPrice = const Value.absent(),
    this.gstRate = const Value.absent(),
    this.bardana = const Value.absent(),
  });
  RetailerBillItemsCompanion.insert({
    this.id = const Value.absent(),
    required int billId,
    required int itemId,
    required double quantity,
    required double sellingPrice,
    required double gstRate,
    required double bardana,
  }) : billId = Value(billId),
       itemId = Value(itemId),
       quantity = Value(quantity),
       sellingPrice = Value(sellingPrice),
       gstRate = Value(gstRate),
       bardana = Value(bardana);
  static Insertable<RetailerBillItem> custom({
    Expression<int>? id,
    Expression<int>? billId,
    Expression<int>? itemId,
    Expression<double>? quantity,
    Expression<double>? sellingPrice,
    Expression<double>? gstRate,
    Expression<double>? bardana,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (billId != null) 'bill_id': billId,
      if (itemId != null) 'item_id': itemId,
      if (quantity != null) 'quantity': quantity,
      if (sellingPrice != null) 'selling_price': sellingPrice,
      if (gstRate != null) 'gst_rate': gstRate,
      if (bardana != null) 'bardana': bardana,
    });
  }

  RetailerBillItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? billId,
    Value<int>? itemId,
    Value<double>? quantity,
    Value<double>? sellingPrice,
    Value<double>? gstRate,
    Value<double>? bardana,
  }) {
    return RetailerBillItemsCompanion(
      id: id ?? this.id,
      billId: billId ?? this.billId,
      itemId: itemId ?? this.itemId,
      quantity: quantity ?? this.quantity,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      gstRate: gstRate ?? this.gstRate,
      bardana: bardana ?? this.bardana,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (billId.present) {
      map['bill_id'] = Variable<int>(billId.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<int>(itemId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (sellingPrice.present) {
      map['selling_price'] = Variable<double>(sellingPrice.value);
    }
    if (gstRate.present) {
      map['gst_rate'] = Variable<double>(gstRate.value);
    }
    if (bardana.present) {
      map['bardana'] = Variable<double>(bardana.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RetailerBillItemsCompanion(')
          ..write('id: $id, ')
          ..write('billId: $billId, ')
          ..write('itemId: $itemId, ')
          ..write('quantity: $quantity, ')
          ..write('sellingPrice: $sellingPrice, ')
          ..write('gstRate: $gstRate, ')
          ..write('bardana: $bardana')
          ..write(')'))
        .toString();
  }
}

class $ItemPurchaseSourcesTable extends ItemPurchaseSources
    with TableInfo<$ItemPurchaseSourcesTable, ItemPurchaseSource> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ItemPurchaseSourcesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<int> itemId = GeneratedColumn<int>(
    'item_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES items (id)',
    ),
  );
  static const VerificationMeta _wholesalerIdMeta = const VerificationMeta(
    'wholesalerId',
  );
  @override
  late final GeneratedColumn<int> wholesalerId = GeneratedColumn<int>(
    'wholesaler_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES wholesalers (id)',
    ),
  );
  static const VerificationMeta _purchasePriceMeta = const VerificationMeta(
    'purchasePrice',
  );
  @override
  late final GeneratedColumn<double> purchasePrice = GeneratedColumn<double>(
    'purchase_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gstRateMeta = const VerificationMeta(
    'gstRate',
  );
  @override
  late final GeneratedColumn<double> gstRate = GeneratedColumn<double>(
    'gst_rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _bardanaMeta = const VerificationMeta(
    'bardana',
  );
  @override
  late final GeneratedColumn<double> bardana = GeneratedColumn<double>(
    'bardana',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
    'quantity',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isQuantityNaMeta = const VerificationMeta(
    'isQuantityNa',
  );
  @override
  late final GeneratedColumn<bool> isQuantityNa = GeneratedColumn<bool>(
    'is_quantity_na',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_quantity_na" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _originalInventoryIdMeta =
      const VerificationMeta('originalInventoryId');
  @override
  late final GeneratedColumn<int> originalInventoryId = GeneratedColumn<int>(
    'original_inventory_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    itemId,
    wholesalerId,
    purchasePrice,
    gstRate,
    bardana,
    quantity,
    isQuantityNa,
    createdAt,
    updatedAt,
    originalInventoryId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'item_purchase_sources';
  @override
  VerificationContext validateIntegrity(
    Insertable<ItemPurchaseSource> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('item_id')) {
      context.handle(
        _itemIdMeta,
        itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta),
      );
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('wholesaler_id')) {
      context.handle(
        _wholesalerIdMeta,
        wholesalerId.isAcceptableOrUnknown(
          data['wholesaler_id']!,
          _wholesalerIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_wholesalerIdMeta);
    }
    if (data.containsKey('purchase_price')) {
      context.handle(
        _purchasePriceMeta,
        purchasePrice.isAcceptableOrUnknown(
          data['purchase_price']!,
          _purchasePriceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_purchasePriceMeta);
    }
    if (data.containsKey('gst_rate')) {
      context.handle(
        _gstRateMeta,
        gstRate.isAcceptableOrUnknown(data['gst_rate']!, _gstRateMeta),
      );
    }
    if (data.containsKey('bardana')) {
      context.handle(
        _bardanaMeta,
        bardana.isAcceptableOrUnknown(data['bardana']!, _bardanaMeta),
      );
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    if (data.containsKey('is_quantity_na')) {
      context.handle(
        _isQuantityNaMeta,
        isQuantityNa.isAcceptableOrUnknown(
          data['is_quantity_na']!,
          _isQuantityNaMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('original_inventory_id')) {
      context.handle(
        _originalInventoryIdMeta,
        originalInventoryId.isAcceptableOrUnknown(
          data['original_inventory_id']!,
          _originalInventoryIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ItemPurchaseSource map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ItemPurchaseSource(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      itemId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}item_id'],
      )!,
      wholesalerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}wholesaler_id'],
      )!,
      purchasePrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}purchase_price'],
      )!,
      gstRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}gst_rate'],
      )!,
      bardana: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}bardana'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantity'],
      ),
      isQuantityNa: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_quantity_na'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      originalInventoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}original_inventory_id'],
      ),
    );
  }

  @override
  $ItemPurchaseSourcesTable createAlias(String alias) {
    return $ItemPurchaseSourcesTable(attachedDatabase, alias);
  }
}

class ItemPurchaseSource extends DataClass
    implements Insertable<ItemPurchaseSource> {
  final int id;
  final int itemId;
  final int wholesalerId;
  final double purchasePrice;
  final double gstRate;
  final double bardana;
  final double? quantity;
  final bool isQuantityNa;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? originalInventoryId;
  const ItemPurchaseSource({
    required this.id,
    required this.itemId,
    required this.wholesalerId,
    required this.purchasePrice,
    required this.gstRate,
    required this.bardana,
    this.quantity,
    required this.isQuantityNa,
    required this.createdAt,
    required this.updatedAt,
    this.originalInventoryId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['item_id'] = Variable<int>(itemId);
    map['wholesaler_id'] = Variable<int>(wholesalerId);
    map['purchase_price'] = Variable<double>(purchasePrice);
    map['gst_rate'] = Variable<double>(gstRate);
    map['bardana'] = Variable<double>(bardana);
    if (!nullToAbsent || quantity != null) {
      map['quantity'] = Variable<double>(quantity);
    }
    map['is_quantity_na'] = Variable<bool>(isQuantityNa);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || originalInventoryId != null) {
      map['original_inventory_id'] = Variable<int>(originalInventoryId);
    }
    return map;
  }

  ItemPurchaseSourcesCompanion toCompanion(bool nullToAbsent) {
    return ItemPurchaseSourcesCompanion(
      id: Value(id),
      itemId: Value(itemId),
      wholesalerId: Value(wholesalerId),
      purchasePrice: Value(purchasePrice),
      gstRate: Value(gstRate),
      bardana: Value(bardana),
      quantity: quantity == null && nullToAbsent
          ? const Value.absent()
          : Value(quantity),
      isQuantityNa: Value(isQuantityNa),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      originalInventoryId: originalInventoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(originalInventoryId),
    );
  }

  factory ItemPurchaseSource.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ItemPurchaseSource(
      id: serializer.fromJson<int>(json['id']),
      itemId: serializer.fromJson<int>(json['itemId']),
      wholesalerId: serializer.fromJson<int>(json['wholesalerId']),
      purchasePrice: serializer.fromJson<double>(json['purchasePrice']),
      gstRate: serializer.fromJson<double>(json['gstRate']),
      bardana: serializer.fromJson<double>(json['bardana']),
      quantity: serializer.fromJson<double?>(json['quantity']),
      isQuantityNa: serializer.fromJson<bool>(json['isQuantityNa']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      originalInventoryId: serializer.fromJson<int?>(
        json['originalInventoryId'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'itemId': serializer.toJson<int>(itemId),
      'wholesalerId': serializer.toJson<int>(wholesalerId),
      'purchasePrice': serializer.toJson<double>(purchasePrice),
      'gstRate': serializer.toJson<double>(gstRate),
      'bardana': serializer.toJson<double>(bardana),
      'quantity': serializer.toJson<double?>(quantity),
      'isQuantityNa': serializer.toJson<bool>(isQuantityNa),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'originalInventoryId': serializer.toJson<int?>(originalInventoryId),
    };
  }

  ItemPurchaseSource copyWith({
    int? id,
    int? itemId,
    int? wholesalerId,
    double? purchasePrice,
    double? gstRate,
    double? bardana,
    Value<double?> quantity = const Value.absent(),
    bool? isQuantityNa,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<int?> originalInventoryId = const Value.absent(),
  }) => ItemPurchaseSource(
    id: id ?? this.id,
    itemId: itemId ?? this.itemId,
    wholesalerId: wholesalerId ?? this.wholesalerId,
    purchasePrice: purchasePrice ?? this.purchasePrice,
    gstRate: gstRate ?? this.gstRate,
    bardana: bardana ?? this.bardana,
    quantity: quantity.present ? quantity.value : this.quantity,
    isQuantityNa: isQuantityNa ?? this.isQuantityNa,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    originalInventoryId: originalInventoryId.present
        ? originalInventoryId.value
        : this.originalInventoryId,
  );
  ItemPurchaseSource copyWithCompanion(ItemPurchaseSourcesCompanion data) {
    return ItemPurchaseSource(
      id: data.id.present ? data.id.value : this.id,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      wholesalerId: data.wholesalerId.present
          ? data.wholesalerId.value
          : this.wholesalerId,
      purchasePrice: data.purchasePrice.present
          ? data.purchasePrice.value
          : this.purchasePrice,
      gstRate: data.gstRate.present ? data.gstRate.value : this.gstRate,
      bardana: data.bardana.present ? data.bardana.value : this.bardana,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      isQuantityNa: data.isQuantityNa.present
          ? data.isQuantityNa.value
          : this.isQuantityNa,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      originalInventoryId: data.originalInventoryId.present
          ? data.originalInventoryId.value
          : this.originalInventoryId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ItemPurchaseSource(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('wholesalerId: $wholesalerId, ')
          ..write('purchasePrice: $purchasePrice, ')
          ..write('gstRate: $gstRate, ')
          ..write('bardana: $bardana, ')
          ..write('quantity: $quantity, ')
          ..write('isQuantityNa: $isQuantityNa, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('originalInventoryId: $originalInventoryId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    itemId,
    wholesalerId,
    purchasePrice,
    gstRate,
    bardana,
    quantity,
    isQuantityNa,
    createdAt,
    updatedAt,
    originalInventoryId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ItemPurchaseSource &&
          other.id == this.id &&
          other.itemId == this.itemId &&
          other.wholesalerId == this.wholesalerId &&
          other.purchasePrice == this.purchasePrice &&
          other.gstRate == this.gstRate &&
          other.bardana == this.bardana &&
          other.quantity == this.quantity &&
          other.isQuantityNa == this.isQuantityNa &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.originalInventoryId == this.originalInventoryId);
}

class ItemPurchaseSourcesCompanion extends UpdateCompanion<ItemPurchaseSource> {
  final Value<int> id;
  final Value<int> itemId;
  final Value<int> wholesalerId;
  final Value<double> purchasePrice;
  final Value<double> gstRate;
  final Value<double> bardana;
  final Value<double?> quantity;
  final Value<bool> isQuantityNa;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int?> originalInventoryId;
  const ItemPurchaseSourcesCompanion({
    this.id = const Value.absent(),
    this.itemId = const Value.absent(),
    this.wholesalerId = const Value.absent(),
    this.purchasePrice = const Value.absent(),
    this.gstRate = const Value.absent(),
    this.bardana = const Value.absent(),
    this.quantity = const Value.absent(),
    this.isQuantityNa = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.originalInventoryId = const Value.absent(),
  });
  ItemPurchaseSourcesCompanion.insert({
    this.id = const Value.absent(),
    required int itemId,
    required int wholesalerId,
    required double purchasePrice,
    this.gstRate = const Value.absent(),
    this.bardana = const Value.absent(),
    this.quantity = const Value.absent(),
    this.isQuantityNa = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.originalInventoryId = const Value.absent(),
  }) : itemId = Value(itemId),
       wholesalerId = Value(wholesalerId),
       purchasePrice = Value(purchasePrice);
  static Insertable<ItemPurchaseSource> custom({
    Expression<int>? id,
    Expression<int>? itemId,
    Expression<int>? wholesalerId,
    Expression<double>? purchasePrice,
    Expression<double>? gstRate,
    Expression<double>? bardana,
    Expression<double>? quantity,
    Expression<bool>? isQuantityNa,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? originalInventoryId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (itemId != null) 'item_id': itemId,
      if (wholesalerId != null) 'wholesaler_id': wholesalerId,
      if (purchasePrice != null) 'purchase_price': purchasePrice,
      if (gstRate != null) 'gst_rate': gstRate,
      if (bardana != null) 'bardana': bardana,
      if (quantity != null) 'quantity': quantity,
      if (isQuantityNa != null) 'is_quantity_na': isQuantityNa,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (originalInventoryId != null)
        'original_inventory_id': originalInventoryId,
    });
  }

  ItemPurchaseSourcesCompanion copyWith({
    Value<int>? id,
    Value<int>? itemId,
    Value<int>? wholesalerId,
    Value<double>? purchasePrice,
    Value<double>? gstRate,
    Value<double>? bardana,
    Value<double?>? quantity,
    Value<bool>? isQuantityNa,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int?>? originalInventoryId,
  }) {
    return ItemPurchaseSourcesCompanion(
      id: id ?? this.id,
      itemId: itemId ?? this.itemId,
      wholesalerId: wholesalerId ?? this.wholesalerId,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      gstRate: gstRate ?? this.gstRate,
      bardana: bardana ?? this.bardana,
      quantity: quantity ?? this.quantity,
      isQuantityNa: isQuantityNa ?? this.isQuantityNa,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      originalInventoryId: originalInventoryId ?? this.originalInventoryId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<int>(itemId.value);
    }
    if (wholesalerId.present) {
      map['wholesaler_id'] = Variable<int>(wholesalerId.value);
    }
    if (purchasePrice.present) {
      map['purchase_price'] = Variable<double>(purchasePrice.value);
    }
    if (gstRate.present) {
      map['gst_rate'] = Variable<double>(gstRate.value);
    }
    if (bardana.present) {
      map['bardana'] = Variable<double>(bardana.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (isQuantityNa.present) {
      map['is_quantity_na'] = Variable<bool>(isQuantityNa.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (originalInventoryId.present) {
      map['original_inventory_id'] = Variable<int>(originalInventoryId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItemPurchaseSourcesCompanion(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('wholesalerId: $wholesalerId, ')
          ..write('purchasePrice: $purchasePrice, ')
          ..write('gstRate: $gstRate, ')
          ..write('bardana: $bardana, ')
          ..write('quantity: $quantity, ')
          ..write('isQuantityNa: $isQuantityNa, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('originalInventoryId: $originalInventoryId')
          ..write(')'))
        .toString();
  }
}

class $BillItemSourcesTable extends BillItemSources
    with TableInfo<$BillItemSourcesTable, BillItemSource> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BillItemSourcesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _billItemIdMeta = const VerificationMeta(
    'billItemId',
  );
  @override
  late final GeneratedColumn<int> billItemId = GeneratedColumn<int>(
    'bill_item_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES retailer_bill_items (id)',
    ),
  );
  static const VerificationMeta _inventoryIdMeta = const VerificationMeta(
    'inventoryId',
  );
  @override
  late final GeneratedColumn<int> inventoryId = GeneratedColumn<int>(
    'inventory_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES wholesaler_inventory (id)',
    ),
  );
  static const VerificationMeta _purchaseSourceIdMeta = const VerificationMeta(
    'purchaseSourceId',
  );
  @override
  late final GeneratedColumn<int> purchaseSourceId = GeneratedColumn<int>(
    'purchase_source_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES item_purchase_sources (id)',
    ),
  );
  static const VerificationMeta _quantityAllocatedMeta = const VerificationMeta(
    'quantityAllocated',
  );
  @override
  late final GeneratedColumn<double> quantityAllocated =
      GeneratedColumn<double>(
        'quantity_allocated',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _purchasePriceAtTimeMeta =
      const VerificationMeta('purchasePriceAtTime');
  @override
  late final GeneratedColumn<double> purchasePriceAtTime =
      GeneratedColumn<double>(
        'purchase_price_at_time',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    billItemId,
    inventoryId,
    purchaseSourceId,
    quantityAllocated,
    purchasePriceAtTime,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bill_item_sources';
  @override
  VerificationContext validateIntegrity(
    Insertable<BillItemSource> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('bill_item_id')) {
      context.handle(
        _billItemIdMeta,
        billItemId.isAcceptableOrUnknown(
          data['bill_item_id']!,
          _billItemIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_billItemIdMeta);
    }
    if (data.containsKey('inventory_id')) {
      context.handle(
        _inventoryIdMeta,
        inventoryId.isAcceptableOrUnknown(
          data['inventory_id']!,
          _inventoryIdMeta,
        ),
      );
    }
    if (data.containsKey('purchase_source_id')) {
      context.handle(
        _purchaseSourceIdMeta,
        purchaseSourceId.isAcceptableOrUnknown(
          data['purchase_source_id']!,
          _purchaseSourceIdMeta,
        ),
      );
    }
    if (data.containsKey('quantity_allocated')) {
      context.handle(
        _quantityAllocatedMeta,
        quantityAllocated.isAcceptableOrUnknown(
          data['quantity_allocated']!,
          _quantityAllocatedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_quantityAllocatedMeta);
    }
    if (data.containsKey('purchase_price_at_time')) {
      context.handle(
        _purchasePriceAtTimeMeta,
        purchasePriceAtTime.isAcceptableOrUnknown(
          data['purchase_price_at_time']!,
          _purchasePriceAtTimeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_purchasePriceAtTimeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BillItemSource map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BillItemSource(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      billItemId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bill_item_id'],
      )!,
      inventoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}inventory_id'],
      ),
      purchaseSourceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}purchase_source_id'],
      ),
      quantityAllocated: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantity_allocated'],
      )!,
      purchasePriceAtTime: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}purchase_price_at_time'],
      )!,
    );
  }

  @override
  $BillItemSourcesTable createAlias(String alias) {
    return $BillItemSourcesTable(attachedDatabase, alias);
  }
}

class BillItemSource extends DataClass implements Insertable<BillItemSource> {
  final int id;
  final int billItemId;
  final int? inventoryId;
  final int? purchaseSourceId;
  final double quantityAllocated;
  final double purchasePriceAtTime;
  const BillItemSource({
    required this.id,
    required this.billItemId,
    this.inventoryId,
    this.purchaseSourceId,
    required this.quantityAllocated,
    required this.purchasePriceAtTime,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['bill_item_id'] = Variable<int>(billItemId);
    if (!nullToAbsent || inventoryId != null) {
      map['inventory_id'] = Variable<int>(inventoryId);
    }
    if (!nullToAbsent || purchaseSourceId != null) {
      map['purchase_source_id'] = Variable<int>(purchaseSourceId);
    }
    map['quantity_allocated'] = Variable<double>(quantityAllocated);
    map['purchase_price_at_time'] = Variable<double>(purchasePriceAtTime);
    return map;
  }

  BillItemSourcesCompanion toCompanion(bool nullToAbsent) {
    return BillItemSourcesCompanion(
      id: Value(id),
      billItemId: Value(billItemId),
      inventoryId: inventoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(inventoryId),
      purchaseSourceId: purchaseSourceId == null && nullToAbsent
          ? const Value.absent()
          : Value(purchaseSourceId),
      quantityAllocated: Value(quantityAllocated),
      purchasePriceAtTime: Value(purchasePriceAtTime),
    );
  }

  factory BillItemSource.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BillItemSource(
      id: serializer.fromJson<int>(json['id']),
      billItemId: serializer.fromJson<int>(json['billItemId']),
      inventoryId: serializer.fromJson<int?>(json['inventoryId']),
      purchaseSourceId: serializer.fromJson<int?>(json['purchaseSourceId']),
      quantityAllocated: serializer.fromJson<double>(json['quantityAllocated']),
      purchasePriceAtTime: serializer.fromJson<double>(
        json['purchasePriceAtTime'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'billItemId': serializer.toJson<int>(billItemId),
      'inventoryId': serializer.toJson<int?>(inventoryId),
      'purchaseSourceId': serializer.toJson<int?>(purchaseSourceId),
      'quantityAllocated': serializer.toJson<double>(quantityAllocated),
      'purchasePriceAtTime': serializer.toJson<double>(purchasePriceAtTime),
    };
  }

  BillItemSource copyWith({
    int? id,
    int? billItemId,
    Value<int?> inventoryId = const Value.absent(),
    Value<int?> purchaseSourceId = const Value.absent(),
    double? quantityAllocated,
    double? purchasePriceAtTime,
  }) => BillItemSource(
    id: id ?? this.id,
    billItemId: billItemId ?? this.billItemId,
    inventoryId: inventoryId.present ? inventoryId.value : this.inventoryId,
    purchaseSourceId: purchaseSourceId.present
        ? purchaseSourceId.value
        : this.purchaseSourceId,
    quantityAllocated: quantityAllocated ?? this.quantityAllocated,
    purchasePriceAtTime: purchasePriceAtTime ?? this.purchasePriceAtTime,
  );
  BillItemSource copyWithCompanion(BillItemSourcesCompanion data) {
    return BillItemSource(
      id: data.id.present ? data.id.value : this.id,
      billItemId: data.billItemId.present
          ? data.billItemId.value
          : this.billItemId,
      inventoryId: data.inventoryId.present
          ? data.inventoryId.value
          : this.inventoryId,
      purchaseSourceId: data.purchaseSourceId.present
          ? data.purchaseSourceId.value
          : this.purchaseSourceId,
      quantityAllocated: data.quantityAllocated.present
          ? data.quantityAllocated.value
          : this.quantityAllocated,
      purchasePriceAtTime: data.purchasePriceAtTime.present
          ? data.purchasePriceAtTime.value
          : this.purchasePriceAtTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BillItemSource(')
          ..write('id: $id, ')
          ..write('billItemId: $billItemId, ')
          ..write('inventoryId: $inventoryId, ')
          ..write('purchaseSourceId: $purchaseSourceId, ')
          ..write('quantityAllocated: $quantityAllocated, ')
          ..write('purchasePriceAtTime: $purchasePriceAtTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    billItemId,
    inventoryId,
    purchaseSourceId,
    quantityAllocated,
    purchasePriceAtTime,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BillItemSource &&
          other.id == this.id &&
          other.billItemId == this.billItemId &&
          other.inventoryId == this.inventoryId &&
          other.purchaseSourceId == this.purchaseSourceId &&
          other.quantityAllocated == this.quantityAllocated &&
          other.purchasePriceAtTime == this.purchasePriceAtTime);
}

class BillItemSourcesCompanion extends UpdateCompanion<BillItemSource> {
  final Value<int> id;
  final Value<int> billItemId;
  final Value<int?> inventoryId;
  final Value<int?> purchaseSourceId;
  final Value<double> quantityAllocated;
  final Value<double> purchasePriceAtTime;
  const BillItemSourcesCompanion({
    this.id = const Value.absent(),
    this.billItemId = const Value.absent(),
    this.inventoryId = const Value.absent(),
    this.purchaseSourceId = const Value.absent(),
    this.quantityAllocated = const Value.absent(),
    this.purchasePriceAtTime = const Value.absent(),
  });
  BillItemSourcesCompanion.insert({
    this.id = const Value.absent(),
    required int billItemId,
    this.inventoryId = const Value.absent(),
    this.purchaseSourceId = const Value.absent(),
    required double quantityAllocated,
    required double purchasePriceAtTime,
  }) : billItemId = Value(billItemId),
       quantityAllocated = Value(quantityAllocated),
       purchasePriceAtTime = Value(purchasePriceAtTime);
  static Insertable<BillItemSource> custom({
    Expression<int>? id,
    Expression<int>? billItemId,
    Expression<int>? inventoryId,
    Expression<int>? purchaseSourceId,
    Expression<double>? quantityAllocated,
    Expression<double>? purchasePriceAtTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (billItemId != null) 'bill_item_id': billItemId,
      if (inventoryId != null) 'inventory_id': inventoryId,
      if (purchaseSourceId != null) 'purchase_source_id': purchaseSourceId,
      if (quantityAllocated != null) 'quantity_allocated': quantityAllocated,
      if (purchasePriceAtTime != null)
        'purchase_price_at_time': purchasePriceAtTime,
    });
  }

  BillItemSourcesCompanion copyWith({
    Value<int>? id,
    Value<int>? billItemId,
    Value<int?>? inventoryId,
    Value<int?>? purchaseSourceId,
    Value<double>? quantityAllocated,
    Value<double>? purchasePriceAtTime,
  }) {
    return BillItemSourcesCompanion(
      id: id ?? this.id,
      billItemId: billItemId ?? this.billItemId,
      inventoryId: inventoryId ?? this.inventoryId,
      purchaseSourceId: purchaseSourceId ?? this.purchaseSourceId,
      quantityAllocated: quantityAllocated ?? this.quantityAllocated,
      purchasePriceAtTime: purchasePriceAtTime ?? this.purchasePriceAtTime,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (billItemId.present) {
      map['bill_item_id'] = Variable<int>(billItemId.value);
    }
    if (inventoryId.present) {
      map['inventory_id'] = Variable<int>(inventoryId.value);
    }
    if (purchaseSourceId.present) {
      map['purchase_source_id'] = Variable<int>(purchaseSourceId.value);
    }
    if (quantityAllocated.present) {
      map['quantity_allocated'] = Variable<double>(quantityAllocated.value);
    }
    if (purchasePriceAtTime.present) {
      map['purchase_price_at_time'] = Variable<double>(
        purchasePriceAtTime.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BillItemSourcesCompanion(')
          ..write('id: $id, ')
          ..write('billItemId: $billItemId, ')
          ..write('inventoryId: $inventoryId, ')
          ..write('purchaseSourceId: $purchaseSourceId, ')
          ..write('quantityAllocated: $quantityAllocated, ')
          ..write('purchasePriceAtTime: $purchasePriceAtTime')
          ..write(')'))
        .toString();
  }
}

class $LedgersTable extends Ledgers with TableInfo<$LedgersTable, Ledger> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LedgersTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _ledgerTypeMeta = const VerificationMeta(
    'ledgerType',
  );
  @override
  late final GeneratedColumn<String> ledgerType = GeneratedColumn<String>(
    'ledger_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _partyTypeMeta = const VerificationMeta(
    'partyType',
  );
  @override
  late final GeneratedColumn<String> partyType = GeneratedColumn<String>(
    'party_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _partyIdMeta = const VerificationMeta(
    'partyId',
  );
  @override
  late final GeneratedColumn<int> partyId = GeneratedColumn<int>(
    'party_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalAmountMeta = const VerificationMeta(
    'totalAmount',
  );
  @override
  late final GeneratedColumn<double> totalAmount = GeneratedColumn<double>(
    'total_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountPaidMeta = const VerificationMeta(
    'amountPaid',
  );
  @override
  late final GeneratedColumn<double> amountPaid = GeneratedColumn<double>(
    'amount_paid',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _remainingAmountMeta = const VerificationMeta(
    'remainingAmount',
  );
  @override
  late final GeneratedColumn<double> remainingAmount = GeneratedColumn<double>(
    'remaining_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _interestMeta = const VerificationMeta(
    'interest',
  );
  @override
  late final GeneratedColumn<double> interest = GeneratedColumn<double>(
    'interest',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _paymentModeMeta = const VerificationMeta(
    'paymentMode',
  );
  @override
  late final GeneratedColumn<String> paymentMode = GeneratedColumn<String>(
    'payment_mode',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isFullyPaidMeta = const VerificationMeta(
    'isFullyPaid',
  );
  @override
  late final GeneratedColumn<bool> isFullyPaid = GeneratedColumn<bool>(
    'is_fully_paid',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_fully_paid" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ledgerType,
    partyType,
    partyId,
    totalAmount,
    amountPaid,
    remainingAmount,
    interest,
    paymentMode,
    isFullyPaid,
    date,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ledgers';
  @override
  VerificationContext validateIntegrity(
    Insertable<Ledger> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('ledger_type')) {
      context.handle(
        _ledgerTypeMeta,
        ledgerType.isAcceptableOrUnknown(data['ledger_type']!, _ledgerTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_ledgerTypeMeta);
    }
    if (data.containsKey('party_type')) {
      context.handle(
        _partyTypeMeta,
        partyType.isAcceptableOrUnknown(data['party_type']!, _partyTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_partyTypeMeta);
    }
    if (data.containsKey('party_id')) {
      context.handle(
        _partyIdMeta,
        partyId.isAcceptableOrUnknown(data['party_id']!, _partyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_partyIdMeta);
    }
    if (data.containsKey('total_amount')) {
      context.handle(
        _totalAmountMeta,
        totalAmount.isAcceptableOrUnknown(
          data['total_amount']!,
          _totalAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalAmountMeta);
    }
    if (data.containsKey('amount_paid')) {
      context.handle(
        _amountPaidMeta,
        amountPaid.isAcceptableOrUnknown(data['amount_paid']!, _amountPaidMeta),
      );
    }
    if (data.containsKey('remaining_amount')) {
      context.handle(
        _remainingAmountMeta,
        remainingAmount.isAcceptableOrUnknown(
          data['remaining_amount']!,
          _remainingAmountMeta,
        ),
      );
    }
    if (data.containsKey('interest')) {
      context.handle(
        _interestMeta,
        interest.isAcceptableOrUnknown(data['interest']!, _interestMeta),
      );
    }
    if (data.containsKey('payment_mode')) {
      context.handle(
        _paymentModeMeta,
        paymentMode.isAcceptableOrUnknown(
          data['payment_mode']!,
          _paymentModeMeta,
        ),
      );
    }
    if (data.containsKey('is_fully_paid')) {
      context.handle(
        _isFullyPaidMeta,
        isFullyPaid.isAcceptableOrUnknown(
          data['is_fully_paid']!,
          _isFullyPaidMeta,
        ),
      );
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Ledger map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Ledger(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      ledgerType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ledger_type'],
      )!,
      partyType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}party_type'],
      )!,
      partyId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}party_id'],
      )!,
      totalAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_amount'],
      )!,
      amountPaid: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount_paid'],
      )!,
      remainingAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}remaining_amount'],
      )!,
      interest: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}interest'],
      )!,
      paymentMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_mode'],
      ),
      isFullyPaid: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_fully_paid'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $LedgersTable createAlias(String alias) {
    return $LedgersTable(attachedDatabase, alias);
  }
}

class Ledger extends DataClass implements Insertable<Ledger> {
  final int id;
  final String ledgerType;
  final String partyType;
  final int partyId;
  final double totalAmount;
  final double amountPaid;
  final double remainingAmount;
  final double interest;
  final String? paymentMode;
  final bool isFullyPaid;
  final DateTime date;
  final DateTime createdAt;
  const Ledger({
    required this.id,
    required this.ledgerType,
    required this.partyType,
    required this.partyId,
    required this.totalAmount,
    required this.amountPaid,
    required this.remainingAmount,
    required this.interest,
    this.paymentMode,
    required this.isFullyPaid,
    required this.date,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['ledger_type'] = Variable<String>(ledgerType);
    map['party_type'] = Variable<String>(partyType);
    map['party_id'] = Variable<int>(partyId);
    map['total_amount'] = Variable<double>(totalAmount);
    map['amount_paid'] = Variable<double>(amountPaid);
    map['remaining_amount'] = Variable<double>(remainingAmount);
    map['interest'] = Variable<double>(interest);
    if (!nullToAbsent || paymentMode != null) {
      map['payment_mode'] = Variable<String>(paymentMode);
    }
    map['is_fully_paid'] = Variable<bool>(isFullyPaid);
    map['date'] = Variable<DateTime>(date);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  LedgersCompanion toCompanion(bool nullToAbsent) {
    return LedgersCompanion(
      id: Value(id),
      ledgerType: Value(ledgerType),
      partyType: Value(partyType),
      partyId: Value(partyId),
      totalAmount: Value(totalAmount),
      amountPaid: Value(amountPaid),
      remainingAmount: Value(remainingAmount),
      interest: Value(interest),
      paymentMode: paymentMode == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentMode),
      isFullyPaid: Value(isFullyPaid),
      date: Value(date),
      createdAt: Value(createdAt),
    );
  }

  factory Ledger.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Ledger(
      id: serializer.fromJson<int>(json['id']),
      ledgerType: serializer.fromJson<String>(json['ledgerType']),
      partyType: serializer.fromJson<String>(json['partyType']),
      partyId: serializer.fromJson<int>(json['partyId']),
      totalAmount: serializer.fromJson<double>(json['totalAmount']),
      amountPaid: serializer.fromJson<double>(json['amountPaid']),
      remainingAmount: serializer.fromJson<double>(json['remainingAmount']),
      interest: serializer.fromJson<double>(json['interest']),
      paymentMode: serializer.fromJson<String?>(json['paymentMode']),
      isFullyPaid: serializer.fromJson<bool>(json['isFullyPaid']),
      date: serializer.fromJson<DateTime>(json['date']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ledgerType': serializer.toJson<String>(ledgerType),
      'partyType': serializer.toJson<String>(partyType),
      'partyId': serializer.toJson<int>(partyId),
      'totalAmount': serializer.toJson<double>(totalAmount),
      'amountPaid': serializer.toJson<double>(amountPaid),
      'remainingAmount': serializer.toJson<double>(remainingAmount),
      'interest': serializer.toJson<double>(interest),
      'paymentMode': serializer.toJson<String?>(paymentMode),
      'isFullyPaid': serializer.toJson<bool>(isFullyPaid),
      'date': serializer.toJson<DateTime>(date),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Ledger copyWith({
    int? id,
    String? ledgerType,
    String? partyType,
    int? partyId,
    double? totalAmount,
    double? amountPaid,
    double? remainingAmount,
    double? interest,
    Value<String?> paymentMode = const Value.absent(),
    bool? isFullyPaid,
    DateTime? date,
    DateTime? createdAt,
  }) => Ledger(
    id: id ?? this.id,
    ledgerType: ledgerType ?? this.ledgerType,
    partyType: partyType ?? this.partyType,
    partyId: partyId ?? this.partyId,
    totalAmount: totalAmount ?? this.totalAmount,
    amountPaid: amountPaid ?? this.amountPaid,
    remainingAmount: remainingAmount ?? this.remainingAmount,
    interest: interest ?? this.interest,
    paymentMode: paymentMode.present ? paymentMode.value : this.paymentMode,
    isFullyPaid: isFullyPaid ?? this.isFullyPaid,
    date: date ?? this.date,
    createdAt: createdAt ?? this.createdAt,
  );
  Ledger copyWithCompanion(LedgersCompanion data) {
    return Ledger(
      id: data.id.present ? data.id.value : this.id,
      ledgerType: data.ledgerType.present
          ? data.ledgerType.value
          : this.ledgerType,
      partyType: data.partyType.present ? data.partyType.value : this.partyType,
      partyId: data.partyId.present ? data.partyId.value : this.partyId,
      totalAmount: data.totalAmount.present
          ? data.totalAmount.value
          : this.totalAmount,
      amountPaid: data.amountPaid.present
          ? data.amountPaid.value
          : this.amountPaid,
      remainingAmount: data.remainingAmount.present
          ? data.remainingAmount.value
          : this.remainingAmount,
      interest: data.interest.present ? data.interest.value : this.interest,
      paymentMode: data.paymentMode.present
          ? data.paymentMode.value
          : this.paymentMode,
      isFullyPaid: data.isFullyPaid.present
          ? data.isFullyPaid.value
          : this.isFullyPaid,
      date: data.date.present ? data.date.value : this.date,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Ledger(')
          ..write('id: $id, ')
          ..write('ledgerType: $ledgerType, ')
          ..write('partyType: $partyType, ')
          ..write('partyId: $partyId, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('amountPaid: $amountPaid, ')
          ..write('remainingAmount: $remainingAmount, ')
          ..write('interest: $interest, ')
          ..write('paymentMode: $paymentMode, ')
          ..write('isFullyPaid: $isFullyPaid, ')
          ..write('date: $date, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    ledgerType,
    partyType,
    partyId,
    totalAmount,
    amountPaid,
    remainingAmount,
    interest,
    paymentMode,
    isFullyPaid,
    date,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Ledger &&
          other.id == this.id &&
          other.ledgerType == this.ledgerType &&
          other.partyType == this.partyType &&
          other.partyId == this.partyId &&
          other.totalAmount == this.totalAmount &&
          other.amountPaid == this.amountPaid &&
          other.remainingAmount == this.remainingAmount &&
          other.interest == this.interest &&
          other.paymentMode == this.paymentMode &&
          other.isFullyPaid == this.isFullyPaid &&
          other.date == this.date &&
          other.createdAt == this.createdAt);
}

class LedgersCompanion extends UpdateCompanion<Ledger> {
  final Value<int> id;
  final Value<String> ledgerType;
  final Value<String> partyType;
  final Value<int> partyId;
  final Value<double> totalAmount;
  final Value<double> amountPaid;
  final Value<double> remainingAmount;
  final Value<double> interest;
  final Value<String?> paymentMode;
  final Value<bool> isFullyPaid;
  final Value<DateTime> date;
  final Value<DateTime> createdAt;
  const LedgersCompanion({
    this.id = const Value.absent(),
    this.ledgerType = const Value.absent(),
    this.partyType = const Value.absent(),
    this.partyId = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.amountPaid = const Value.absent(),
    this.remainingAmount = const Value.absent(),
    this.interest = const Value.absent(),
    this.paymentMode = const Value.absent(),
    this.isFullyPaid = const Value.absent(),
    this.date = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  LedgersCompanion.insert({
    this.id = const Value.absent(),
    required String ledgerType,
    required String partyType,
    required int partyId,
    required double totalAmount,
    this.amountPaid = const Value.absent(),
    this.remainingAmount = const Value.absent(),
    this.interest = const Value.absent(),
    this.paymentMode = const Value.absent(),
    this.isFullyPaid = const Value.absent(),
    this.date = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : ledgerType = Value(ledgerType),
       partyType = Value(partyType),
       partyId = Value(partyId),
       totalAmount = Value(totalAmount);
  static Insertable<Ledger> custom({
    Expression<int>? id,
    Expression<String>? ledgerType,
    Expression<String>? partyType,
    Expression<int>? partyId,
    Expression<double>? totalAmount,
    Expression<double>? amountPaid,
    Expression<double>? remainingAmount,
    Expression<double>? interest,
    Expression<String>? paymentMode,
    Expression<bool>? isFullyPaid,
    Expression<DateTime>? date,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ledgerType != null) 'ledger_type': ledgerType,
      if (partyType != null) 'party_type': partyType,
      if (partyId != null) 'party_id': partyId,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (amountPaid != null) 'amount_paid': amountPaid,
      if (remainingAmount != null) 'remaining_amount': remainingAmount,
      if (interest != null) 'interest': interest,
      if (paymentMode != null) 'payment_mode': paymentMode,
      if (isFullyPaid != null) 'is_fully_paid': isFullyPaid,
      if (date != null) 'date': date,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  LedgersCompanion copyWith({
    Value<int>? id,
    Value<String>? ledgerType,
    Value<String>? partyType,
    Value<int>? partyId,
    Value<double>? totalAmount,
    Value<double>? amountPaid,
    Value<double>? remainingAmount,
    Value<double>? interest,
    Value<String?>? paymentMode,
    Value<bool>? isFullyPaid,
    Value<DateTime>? date,
    Value<DateTime>? createdAt,
  }) {
    return LedgersCompanion(
      id: id ?? this.id,
      ledgerType: ledgerType ?? this.ledgerType,
      partyType: partyType ?? this.partyType,
      partyId: partyId ?? this.partyId,
      totalAmount: totalAmount ?? this.totalAmount,
      amountPaid: amountPaid ?? this.amountPaid,
      remainingAmount: remainingAmount ?? this.remainingAmount,
      interest: interest ?? this.interest,
      paymentMode: paymentMode ?? this.paymentMode,
      isFullyPaid: isFullyPaid ?? this.isFullyPaid,
      date: date ?? this.date,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ledgerType.present) {
      map['ledger_type'] = Variable<String>(ledgerType.value);
    }
    if (partyType.present) {
      map['party_type'] = Variable<String>(partyType.value);
    }
    if (partyId.present) {
      map['party_id'] = Variable<int>(partyId.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<double>(totalAmount.value);
    }
    if (amountPaid.present) {
      map['amount_paid'] = Variable<double>(amountPaid.value);
    }
    if (remainingAmount.present) {
      map['remaining_amount'] = Variable<double>(remainingAmount.value);
    }
    if (interest.present) {
      map['interest'] = Variable<double>(interest.value);
    }
    if (paymentMode.present) {
      map['payment_mode'] = Variable<String>(paymentMode.value);
    }
    if (isFullyPaid.present) {
      map['is_fully_paid'] = Variable<bool>(isFullyPaid.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LedgersCompanion(')
          ..write('id: $id, ')
          ..write('ledgerType: $ledgerType, ')
          ..write('partyType: $partyType, ')
          ..write('partyId: $partyId, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('amountPaid: $amountPaid, ')
          ..write('remainingAmount: $remainingAmount, ')
          ..write('interest: $interest, ')
          ..write('paymentMode: $paymentMode, ')
          ..write('isFullyPaid: $isFullyPaid, ')
          ..write('date: $date, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $PaymentsTable extends Payments with TableInfo<$PaymentsTable, Payment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _ledgerIdMeta = const VerificationMeta(
    'ledgerId',
  );
  @override
  late final GeneratedColumn<int> ledgerId = GeneratedColumn<int>(
    'ledger_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES ledgers (id)',
    ),
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paymentModeMeta = const VerificationMeta(
    'paymentMode',
  );
  @override
  late final GeneratedColumn<String> paymentMode = GeneratedColumn<String>(
    'payment_mode',
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
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
  static const VerificationMeta _isFullPaymentMeta = const VerificationMeta(
    'isFullPayment',
  );
  @override
  late final GeneratedColumn<bool> isFullPayment = GeneratedColumn<bool>(
    'is_full_payment',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_full_payment" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ledgerId,
    amount,
    paymentMode,
    date,
    note,
    isFullPayment,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payments';
  @override
  VerificationContext validateIntegrity(
    Insertable<Payment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('ledger_id')) {
      context.handle(
        _ledgerIdMeta,
        ledgerId.isAcceptableOrUnknown(data['ledger_id']!, _ledgerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ledgerIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('payment_mode')) {
      context.handle(
        _paymentModeMeta,
        paymentMode.isAcceptableOrUnknown(
          data['payment_mode']!,
          _paymentModeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_paymentModeMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('is_full_payment')) {
      context.handle(
        _isFullPaymentMeta,
        isFullPayment.isAcceptableOrUnknown(
          data['is_full_payment']!,
          _isFullPaymentMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Payment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Payment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      ledgerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ledger_id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      paymentMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_mode'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      isFullPayment: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_full_payment'],
      )!,
    );
  }

  @override
  $PaymentsTable createAlias(String alias) {
    return $PaymentsTable(attachedDatabase, alias);
  }
}

class Payment extends DataClass implements Insertable<Payment> {
  final int id;
  final int ledgerId;
  final double amount;
  final String paymentMode;
  final DateTime date;
  final String? note;
  final bool isFullPayment;
  const Payment({
    required this.id,
    required this.ledgerId,
    required this.amount,
    required this.paymentMode,
    required this.date,
    this.note,
    required this.isFullPayment,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['ledger_id'] = Variable<int>(ledgerId);
    map['amount'] = Variable<double>(amount);
    map['payment_mode'] = Variable<String>(paymentMode);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['is_full_payment'] = Variable<bool>(isFullPayment);
    return map;
  }

  PaymentsCompanion toCompanion(bool nullToAbsent) {
    return PaymentsCompanion(
      id: Value(id),
      ledgerId: Value(ledgerId),
      amount: Value(amount),
      paymentMode: Value(paymentMode),
      date: Value(date),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      isFullPayment: Value(isFullPayment),
    );
  }

  factory Payment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Payment(
      id: serializer.fromJson<int>(json['id']),
      ledgerId: serializer.fromJson<int>(json['ledgerId']),
      amount: serializer.fromJson<double>(json['amount']),
      paymentMode: serializer.fromJson<String>(json['paymentMode']),
      date: serializer.fromJson<DateTime>(json['date']),
      note: serializer.fromJson<String?>(json['note']),
      isFullPayment: serializer.fromJson<bool>(json['isFullPayment']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ledgerId': serializer.toJson<int>(ledgerId),
      'amount': serializer.toJson<double>(amount),
      'paymentMode': serializer.toJson<String>(paymentMode),
      'date': serializer.toJson<DateTime>(date),
      'note': serializer.toJson<String?>(note),
      'isFullPayment': serializer.toJson<bool>(isFullPayment),
    };
  }

  Payment copyWith({
    int? id,
    int? ledgerId,
    double? amount,
    String? paymentMode,
    DateTime? date,
    Value<String?> note = const Value.absent(),
    bool? isFullPayment,
  }) => Payment(
    id: id ?? this.id,
    ledgerId: ledgerId ?? this.ledgerId,
    amount: amount ?? this.amount,
    paymentMode: paymentMode ?? this.paymentMode,
    date: date ?? this.date,
    note: note.present ? note.value : this.note,
    isFullPayment: isFullPayment ?? this.isFullPayment,
  );
  Payment copyWithCompanion(PaymentsCompanion data) {
    return Payment(
      id: data.id.present ? data.id.value : this.id,
      ledgerId: data.ledgerId.present ? data.ledgerId.value : this.ledgerId,
      amount: data.amount.present ? data.amount.value : this.amount,
      paymentMode: data.paymentMode.present
          ? data.paymentMode.value
          : this.paymentMode,
      date: data.date.present ? data.date.value : this.date,
      note: data.note.present ? data.note.value : this.note,
      isFullPayment: data.isFullPayment.present
          ? data.isFullPayment.value
          : this.isFullPayment,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Payment(')
          ..write('id: $id, ')
          ..write('ledgerId: $ledgerId, ')
          ..write('amount: $amount, ')
          ..write('paymentMode: $paymentMode, ')
          ..write('date: $date, ')
          ..write('note: $note, ')
          ..write('isFullPayment: $isFullPayment')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, ledgerId, amount, paymentMode, date, note, isFullPayment);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Payment &&
          other.id == this.id &&
          other.ledgerId == this.ledgerId &&
          other.amount == this.amount &&
          other.paymentMode == this.paymentMode &&
          other.date == this.date &&
          other.note == this.note &&
          other.isFullPayment == this.isFullPayment);
}

class PaymentsCompanion extends UpdateCompanion<Payment> {
  final Value<int> id;
  final Value<int> ledgerId;
  final Value<double> amount;
  final Value<String> paymentMode;
  final Value<DateTime> date;
  final Value<String?> note;
  final Value<bool> isFullPayment;
  const PaymentsCompanion({
    this.id = const Value.absent(),
    this.ledgerId = const Value.absent(),
    this.amount = const Value.absent(),
    this.paymentMode = const Value.absent(),
    this.date = const Value.absent(),
    this.note = const Value.absent(),
    this.isFullPayment = const Value.absent(),
  });
  PaymentsCompanion.insert({
    this.id = const Value.absent(),
    required int ledgerId,
    required double amount,
    required String paymentMode,
    this.date = const Value.absent(),
    this.note = const Value.absent(),
    this.isFullPayment = const Value.absent(),
  }) : ledgerId = Value(ledgerId),
       amount = Value(amount),
       paymentMode = Value(paymentMode);
  static Insertable<Payment> custom({
    Expression<int>? id,
    Expression<int>? ledgerId,
    Expression<double>? amount,
    Expression<String>? paymentMode,
    Expression<DateTime>? date,
    Expression<String>? note,
    Expression<bool>? isFullPayment,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ledgerId != null) 'ledger_id': ledgerId,
      if (amount != null) 'amount': amount,
      if (paymentMode != null) 'payment_mode': paymentMode,
      if (date != null) 'date': date,
      if (note != null) 'note': note,
      if (isFullPayment != null) 'is_full_payment': isFullPayment,
    });
  }

  PaymentsCompanion copyWith({
    Value<int>? id,
    Value<int>? ledgerId,
    Value<double>? amount,
    Value<String>? paymentMode,
    Value<DateTime>? date,
    Value<String?>? note,
    Value<bool>? isFullPayment,
  }) {
    return PaymentsCompanion(
      id: id ?? this.id,
      ledgerId: ledgerId ?? this.ledgerId,
      amount: amount ?? this.amount,
      paymentMode: paymentMode ?? this.paymentMode,
      date: date ?? this.date,
      note: note ?? this.note,
      isFullPayment: isFullPayment ?? this.isFullPayment,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ledgerId.present) {
      map['ledger_id'] = Variable<int>(ledgerId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (paymentMode.present) {
      map['payment_mode'] = Variable<String>(paymentMode.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (isFullPayment.present) {
      map['is_full_payment'] = Variable<bool>(isFullPayment.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentsCompanion(')
          ..write('id: $id, ')
          ..write('ledgerId: $ledgerId, ')
          ..write('amount: $amount, ')
          ..write('paymentMode: $paymentMode, ')
          ..write('date: $date, ')
          ..write('note: $note, ')
          ..write('isFullPayment: $isFullPayment')
          ..write(')'))
        .toString();
  }
}

class $InventoryTransactionsTable extends InventoryTransactions
    with TableInfo<$InventoryTransactionsTable, InventoryTransaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InventoryTransactionsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<int> itemId = GeneratedColumn<int>(
    'item_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES items (id)',
    ),
  );
  static const VerificationMeta _wholesalerIdMeta = const VerificationMeta(
    'wholesalerId',
  );
  @override
  late final GeneratedColumn<int> wholesalerId = GeneratedColumn<int>(
    'wholesaler_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES wholesalers (id)',
    ),
  );
  static const VerificationMeta _retailerIdMeta = const VerificationMeta(
    'retailerId',
  );
  @override
  late final GeneratedColumn<int> retailerId = GeneratedColumn<int>(
    'retailer_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES retailers (id)',
    ),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _referenceIdMeta = const VerificationMeta(
    'referenceId',
  );
  @override
  late final GeneratedColumn<String> referenceId = GeneratedColumn<String>(
    'reference_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    itemId,
    wholesalerId,
    retailerId,
    type,
    quantity,
    referenceId,
    date,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inventory_transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<InventoryTransaction> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('item_id')) {
      context.handle(
        _itemIdMeta,
        itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta),
      );
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('wholesaler_id')) {
      context.handle(
        _wholesalerIdMeta,
        wholesalerId.isAcceptableOrUnknown(
          data['wholesaler_id']!,
          _wholesalerIdMeta,
        ),
      );
    }
    if (data.containsKey('retailer_id')) {
      context.handle(
        _retailerIdMeta,
        retailerId.isAcceptableOrUnknown(data['retailer_id']!, _retailerIdMeta),
      );
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('reference_id')) {
      context.handle(
        _referenceIdMeta,
        referenceId.isAcceptableOrUnknown(
          data['reference_id']!,
          _referenceIdMeta,
        ),
      );
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InventoryTransaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InventoryTransaction(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      itemId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}item_id'],
      )!,
      wholesalerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}wholesaler_id'],
      ),
      retailerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}retailer_id'],
      ),
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantity'],
      )!,
      referenceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference_id'],
      ),
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
    );
  }

  @override
  $InventoryTransactionsTable createAlias(String alias) {
    return $InventoryTransactionsTable(attachedDatabase, alias);
  }
}

class InventoryTransaction extends DataClass
    implements Insertable<InventoryTransaction> {
  final int id;
  final int itemId;
  final int? wholesalerId;
  final int? retailerId;
  final String type;
  final double quantity;
  final String? referenceId;
  final DateTime date;
  const InventoryTransaction({
    required this.id,
    required this.itemId,
    this.wholesalerId,
    this.retailerId,
    required this.type,
    required this.quantity,
    this.referenceId,
    required this.date,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['item_id'] = Variable<int>(itemId);
    if (!nullToAbsent || wholesalerId != null) {
      map['wholesaler_id'] = Variable<int>(wholesalerId);
    }
    if (!nullToAbsent || retailerId != null) {
      map['retailer_id'] = Variable<int>(retailerId);
    }
    map['type'] = Variable<String>(type);
    map['quantity'] = Variable<double>(quantity);
    if (!nullToAbsent || referenceId != null) {
      map['reference_id'] = Variable<String>(referenceId);
    }
    map['date'] = Variable<DateTime>(date);
    return map;
  }

  InventoryTransactionsCompanion toCompanion(bool nullToAbsent) {
    return InventoryTransactionsCompanion(
      id: Value(id),
      itemId: Value(itemId),
      wholesalerId: wholesalerId == null && nullToAbsent
          ? const Value.absent()
          : Value(wholesalerId),
      retailerId: retailerId == null && nullToAbsent
          ? const Value.absent()
          : Value(retailerId),
      type: Value(type),
      quantity: Value(quantity),
      referenceId: referenceId == null && nullToAbsent
          ? const Value.absent()
          : Value(referenceId),
      date: Value(date),
    );
  }

  factory InventoryTransaction.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InventoryTransaction(
      id: serializer.fromJson<int>(json['id']),
      itemId: serializer.fromJson<int>(json['itemId']),
      wholesalerId: serializer.fromJson<int?>(json['wholesalerId']),
      retailerId: serializer.fromJson<int?>(json['retailerId']),
      type: serializer.fromJson<String>(json['type']),
      quantity: serializer.fromJson<double>(json['quantity']),
      referenceId: serializer.fromJson<String?>(json['referenceId']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'itemId': serializer.toJson<int>(itemId),
      'wholesalerId': serializer.toJson<int?>(wholesalerId),
      'retailerId': serializer.toJson<int?>(retailerId),
      'type': serializer.toJson<String>(type),
      'quantity': serializer.toJson<double>(quantity),
      'referenceId': serializer.toJson<String?>(referenceId),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  InventoryTransaction copyWith({
    int? id,
    int? itemId,
    Value<int?> wholesalerId = const Value.absent(),
    Value<int?> retailerId = const Value.absent(),
    String? type,
    double? quantity,
    Value<String?> referenceId = const Value.absent(),
    DateTime? date,
  }) => InventoryTransaction(
    id: id ?? this.id,
    itemId: itemId ?? this.itemId,
    wholesalerId: wholesalerId.present ? wholesalerId.value : this.wholesalerId,
    retailerId: retailerId.present ? retailerId.value : this.retailerId,
    type: type ?? this.type,
    quantity: quantity ?? this.quantity,
    referenceId: referenceId.present ? referenceId.value : this.referenceId,
    date: date ?? this.date,
  );
  InventoryTransaction copyWithCompanion(InventoryTransactionsCompanion data) {
    return InventoryTransaction(
      id: data.id.present ? data.id.value : this.id,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      wholesalerId: data.wholesalerId.present
          ? data.wholesalerId.value
          : this.wholesalerId,
      retailerId: data.retailerId.present
          ? data.retailerId.value
          : this.retailerId,
      type: data.type.present ? data.type.value : this.type,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      referenceId: data.referenceId.present
          ? data.referenceId.value
          : this.referenceId,
      date: data.date.present ? data.date.value : this.date,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InventoryTransaction(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('wholesalerId: $wholesalerId, ')
          ..write('retailerId: $retailerId, ')
          ..write('type: $type, ')
          ..write('quantity: $quantity, ')
          ..write('referenceId: $referenceId, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    itemId,
    wholesalerId,
    retailerId,
    type,
    quantity,
    referenceId,
    date,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InventoryTransaction &&
          other.id == this.id &&
          other.itemId == this.itemId &&
          other.wholesalerId == this.wholesalerId &&
          other.retailerId == this.retailerId &&
          other.type == this.type &&
          other.quantity == this.quantity &&
          other.referenceId == this.referenceId &&
          other.date == this.date);
}

class InventoryTransactionsCompanion
    extends UpdateCompanion<InventoryTransaction> {
  final Value<int> id;
  final Value<int> itemId;
  final Value<int?> wholesalerId;
  final Value<int?> retailerId;
  final Value<String> type;
  final Value<double> quantity;
  final Value<String?> referenceId;
  final Value<DateTime> date;
  const InventoryTransactionsCompanion({
    this.id = const Value.absent(),
    this.itemId = const Value.absent(),
    this.wholesalerId = const Value.absent(),
    this.retailerId = const Value.absent(),
    this.type = const Value.absent(),
    this.quantity = const Value.absent(),
    this.referenceId = const Value.absent(),
    this.date = const Value.absent(),
  });
  InventoryTransactionsCompanion.insert({
    this.id = const Value.absent(),
    required int itemId,
    this.wholesalerId = const Value.absent(),
    this.retailerId = const Value.absent(),
    required String type,
    required double quantity,
    this.referenceId = const Value.absent(),
    this.date = const Value.absent(),
  }) : itemId = Value(itemId),
       type = Value(type),
       quantity = Value(quantity);
  static Insertable<InventoryTransaction> custom({
    Expression<int>? id,
    Expression<int>? itemId,
    Expression<int>? wholesalerId,
    Expression<int>? retailerId,
    Expression<String>? type,
    Expression<double>? quantity,
    Expression<String>? referenceId,
    Expression<DateTime>? date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (itemId != null) 'item_id': itemId,
      if (wholesalerId != null) 'wholesaler_id': wholesalerId,
      if (retailerId != null) 'retailer_id': retailerId,
      if (type != null) 'type': type,
      if (quantity != null) 'quantity': quantity,
      if (referenceId != null) 'reference_id': referenceId,
      if (date != null) 'date': date,
    });
  }

  InventoryTransactionsCompanion copyWith({
    Value<int>? id,
    Value<int>? itemId,
    Value<int?>? wholesalerId,
    Value<int?>? retailerId,
    Value<String>? type,
    Value<double>? quantity,
    Value<String?>? referenceId,
    Value<DateTime>? date,
  }) {
    return InventoryTransactionsCompanion(
      id: id ?? this.id,
      itemId: itemId ?? this.itemId,
      wholesalerId: wholesalerId ?? this.wholesalerId,
      retailerId: retailerId ?? this.retailerId,
      type: type ?? this.type,
      quantity: quantity ?? this.quantity,
      referenceId: referenceId ?? this.referenceId,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<int>(itemId.value);
    }
    if (wholesalerId.present) {
      map['wholesaler_id'] = Variable<int>(wholesalerId.value);
    }
    if (retailerId.present) {
      map['retailer_id'] = Variable<int>(retailerId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (referenceId.present) {
      map['reference_id'] = Variable<String>(referenceId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InventoryTransactionsCompanion(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('wholesalerId: $wholesalerId, ')
          ..write('retailerId: $retailerId, ')
          ..write('type: $type, ')
          ..write('quantity: $quantity, ')
          ..write('referenceId: $referenceId, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ItemsTable items = $ItemsTable(this);
  late final $WholesalersTable wholesalers = $WholesalersTable(this);
  late final $RetailersTable retailers = $RetailersTable(this);
  late final $WholesalerInventoryTable wholesalerInventory =
      $WholesalerInventoryTable(this);
  late final $RetailerBillsTable retailerBills = $RetailerBillsTable(this);
  late final $RetailerBillItemsTable retailerBillItems =
      $RetailerBillItemsTable(this);
  late final $ItemPurchaseSourcesTable itemPurchaseSources =
      $ItemPurchaseSourcesTable(this);
  late final $BillItemSourcesTable billItemSources = $BillItemSourcesTable(
    this,
  );
  late final $LedgersTable ledgers = $LedgersTable(this);
  late final $PaymentsTable payments = $PaymentsTable(this);
  late final $InventoryTransactionsTable inventoryTransactions =
      $InventoryTransactionsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    items,
    wholesalers,
    retailers,
    wholesalerInventory,
    retailerBills,
    retailerBillItems,
    itemPurchaseSources,
    billItemSources,
    ledgers,
    payments,
    inventoryTransactions,
  ];
}

typedef $$ItemsTableCreateCompanionBuilder =
    ItemsCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> type,
      Value<double> defaultBardana,
      Value<double> defaultGst,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$ItemsTableUpdateCompanionBuilder =
    ItemsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> type,
      Value<double> defaultBardana,
      Value<double> defaultGst,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$ItemsTableReferences
    extends BaseReferences<_$AppDatabase, $ItemsTable, Item> {
  $$ItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $WholesalerInventoryTable,
    List<WholesalerInventoryData>
  >
  _wholesalerInventoryRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.wholesalerInventory,
        aliasName: $_aliasNameGenerator(
          db.items.id,
          db.wholesalerInventory.itemId,
        ),
      );

  $$WholesalerInventoryTableProcessedTableManager get wholesalerInventoryRefs {
    final manager = $$WholesalerInventoryTableTableManager(
      $_db,
      $_db.wholesalerInventory,
    ).filter((f) => f.itemId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _wholesalerInventoryRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RetailerBillItemsTable, List<RetailerBillItem>>
  _retailerBillItemsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.retailerBillItems,
        aliasName: $_aliasNameGenerator(
          db.items.id,
          db.retailerBillItems.itemId,
        ),
      );

  $$RetailerBillItemsTableProcessedTableManager get retailerBillItemsRefs {
    final manager = $$RetailerBillItemsTableTableManager(
      $_db,
      $_db.retailerBillItems,
    ).filter((f) => f.itemId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _retailerBillItemsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $ItemPurchaseSourcesTable,
    List<ItemPurchaseSource>
  >
  _itemPurchaseSourcesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.itemPurchaseSources,
        aliasName: $_aliasNameGenerator(
          db.items.id,
          db.itemPurchaseSources.itemId,
        ),
      );

  $$ItemPurchaseSourcesTableProcessedTableManager get itemPurchaseSourcesRefs {
    final manager = $$ItemPurchaseSourcesTableTableManager(
      $_db,
      $_db.itemPurchaseSources,
    ).filter((f) => f.itemId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _itemPurchaseSourcesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $InventoryTransactionsTable,
    List<InventoryTransaction>
  >
  _inventoryTransactionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.inventoryTransactions,
        aliasName: $_aliasNameGenerator(
          db.items.id,
          db.inventoryTransactions.itemId,
        ),
      );

  $$InventoryTransactionsTableProcessedTableManager
  get inventoryTransactionsRefs {
    final manager = $$InventoryTransactionsTableTableManager(
      $_db,
      $_db.inventoryTransactions,
    ).filter((f) => f.itemId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _inventoryTransactionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ItemsTableFilterComposer extends Composer<_$AppDatabase, $ItemsTable> {
  $$ItemsTableFilterComposer({
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

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get defaultBardana => $composableBuilder(
    column: $table.defaultBardana,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get defaultGst => $composableBuilder(
    column: $table.defaultGst,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> wholesalerInventoryRefs(
    Expression<bool> Function($$WholesalerInventoryTableFilterComposer f) f,
  ) {
    final $$WholesalerInventoryTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.wholesalerInventory,
      getReferencedColumn: (t) => t.itemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WholesalerInventoryTableFilterComposer(
            $db: $db,
            $table: $db.wholesalerInventory,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> retailerBillItemsRefs(
    Expression<bool> Function($$RetailerBillItemsTableFilterComposer f) f,
  ) {
    final $$RetailerBillItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.retailerBillItems,
      getReferencedColumn: (t) => t.itemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RetailerBillItemsTableFilterComposer(
            $db: $db,
            $table: $db.retailerBillItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> itemPurchaseSourcesRefs(
    Expression<bool> Function($$ItemPurchaseSourcesTableFilterComposer f) f,
  ) {
    final $$ItemPurchaseSourcesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.itemPurchaseSources,
      getReferencedColumn: (t) => t.itemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemPurchaseSourcesTableFilterComposer(
            $db: $db,
            $table: $db.itemPurchaseSources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> inventoryTransactionsRefs(
    Expression<bool> Function($$InventoryTransactionsTableFilterComposer f) f,
  ) {
    final $$InventoryTransactionsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.inventoryTransactions,
          getReferencedColumn: (t) => t.itemId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InventoryTransactionsTableFilterComposer(
                $db: $db,
                $table: $db.inventoryTransactions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $ItemsTable> {
  $$ItemsTableOrderingComposer({
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

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get defaultBardana => $composableBuilder(
    column: $table.defaultBardana,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get defaultGst => $composableBuilder(
    column: $table.defaultGst,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ItemsTable> {
  $$ItemsTableAnnotationComposer({
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

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<double> get defaultBardana => $composableBuilder(
    column: $table.defaultBardana,
    builder: (column) => column,
  );

  GeneratedColumn<double> get defaultGst => $composableBuilder(
    column: $table.defaultGst,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> wholesalerInventoryRefs<T extends Object>(
    Expression<T> Function($$WholesalerInventoryTableAnnotationComposer a) f,
  ) {
    final $$WholesalerInventoryTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.wholesalerInventory,
          getReferencedColumn: (t) => t.itemId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$WholesalerInventoryTableAnnotationComposer(
                $db: $db,
                $table: $db.wholesalerInventory,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> retailerBillItemsRefs<T extends Object>(
    Expression<T> Function($$RetailerBillItemsTableAnnotationComposer a) f,
  ) {
    final $$RetailerBillItemsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.retailerBillItems,
          getReferencedColumn: (t) => t.itemId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$RetailerBillItemsTableAnnotationComposer(
                $db: $db,
                $table: $db.retailerBillItems,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> itemPurchaseSourcesRefs<T extends Object>(
    Expression<T> Function($$ItemPurchaseSourcesTableAnnotationComposer a) f,
  ) {
    final $$ItemPurchaseSourcesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.itemPurchaseSources,
          getReferencedColumn: (t) => t.itemId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ItemPurchaseSourcesTableAnnotationComposer(
                $db: $db,
                $table: $db.itemPurchaseSources,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> inventoryTransactionsRefs<T extends Object>(
    Expression<T> Function($$InventoryTransactionsTableAnnotationComposer a) f,
  ) {
    final $$InventoryTransactionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.inventoryTransactions,
          getReferencedColumn: (t) => t.itemId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InventoryTransactionsTableAnnotationComposer(
                $db: $db,
                $table: $db.inventoryTransactions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ItemsTable,
          Item,
          $$ItemsTableFilterComposer,
          $$ItemsTableOrderingComposer,
          $$ItemsTableAnnotationComposer,
          $$ItemsTableCreateCompanionBuilder,
          $$ItemsTableUpdateCompanionBuilder,
          (Item, $$ItemsTableReferences),
          Item,
          PrefetchHooks Function({
            bool wholesalerInventoryRefs,
            bool retailerBillItemsRefs,
            bool itemPurchaseSourcesRefs,
            bool inventoryTransactionsRefs,
          })
        > {
  $$ItemsTableTableManager(_$AppDatabase db, $ItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> type = const Value.absent(),
                Value<double> defaultBardana = const Value.absent(),
                Value<double> defaultGst = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ItemsCompanion(
                id: id,
                name: name,
                type: type,
                defaultBardana: defaultBardana,
                defaultGst: defaultGst,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> type = const Value.absent(),
                Value<double> defaultBardana = const Value.absent(),
                Value<double> defaultGst = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ItemsCompanion.insert(
                id: id,
                name: name,
                type: type,
                defaultBardana: defaultBardana,
                defaultGst: defaultGst,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$ItemsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                wholesalerInventoryRefs = false,
                retailerBillItemsRefs = false,
                itemPurchaseSourcesRefs = false,
                inventoryTransactionsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (wholesalerInventoryRefs) db.wholesalerInventory,
                    if (retailerBillItemsRefs) db.retailerBillItems,
                    if (itemPurchaseSourcesRefs) db.itemPurchaseSources,
                    if (inventoryTransactionsRefs) db.inventoryTransactions,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (wholesalerInventoryRefs)
                        await $_getPrefetchedData<
                          Item,
                          $ItemsTable,
                          WholesalerInventoryData
                        >(
                          currentTable: table,
                          referencedTable: $$ItemsTableReferences
                              ._wholesalerInventoryRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).wholesalerInventoryRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.itemId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (retailerBillItemsRefs)
                        await $_getPrefetchedData<
                          Item,
                          $ItemsTable,
                          RetailerBillItem
                        >(
                          currentTable: table,
                          referencedTable: $$ItemsTableReferences
                              ._retailerBillItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).retailerBillItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.itemId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (itemPurchaseSourcesRefs)
                        await $_getPrefetchedData<
                          Item,
                          $ItemsTable,
                          ItemPurchaseSource
                        >(
                          currentTable: table,
                          referencedTable: $$ItemsTableReferences
                              ._itemPurchaseSourcesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).itemPurchaseSourcesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.itemId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (inventoryTransactionsRefs)
                        await $_getPrefetchedData<
                          Item,
                          $ItemsTable,
                          InventoryTransaction
                        >(
                          currentTable: table,
                          referencedTable: $$ItemsTableReferences
                              ._inventoryTransactionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).inventoryTransactionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.itemId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ItemsTable,
      Item,
      $$ItemsTableFilterComposer,
      $$ItemsTableOrderingComposer,
      $$ItemsTableAnnotationComposer,
      $$ItemsTableCreateCompanionBuilder,
      $$ItemsTableUpdateCompanionBuilder,
      (Item, $$ItemsTableReferences),
      Item,
      PrefetchHooks Function({
        bool wholesalerInventoryRefs,
        bool retailerBillItemsRefs,
        bool itemPurchaseSourcesRefs,
        bool inventoryTransactionsRefs,
      })
    >;
typedef $$WholesalersTableCreateCompanionBuilder =
    WholesalersCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> phone,
      Value<String?> address,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$WholesalersTableUpdateCompanionBuilder =
    WholesalersCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> phone,
      Value<String?> address,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$WholesalersTableReferences
    extends BaseReferences<_$AppDatabase, $WholesalersTable, Wholesaler> {
  $$WholesalersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $WholesalerInventoryTable,
    List<WholesalerInventoryData>
  >
  _wholesalerInventoryRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.wholesalerInventory,
        aliasName: $_aliasNameGenerator(
          db.wholesalers.id,
          db.wholesalerInventory.wholesalerId,
        ),
      );

  $$WholesalerInventoryTableProcessedTableManager get wholesalerInventoryRefs {
    final manager = $$WholesalerInventoryTableTableManager(
      $_db,
      $_db.wholesalerInventory,
    ).filter((f) => f.wholesalerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _wholesalerInventoryRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $ItemPurchaseSourcesTable,
    List<ItemPurchaseSource>
  >
  _itemPurchaseSourcesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.itemPurchaseSources,
        aliasName: $_aliasNameGenerator(
          db.wholesalers.id,
          db.itemPurchaseSources.wholesalerId,
        ),
      );

  $$ItemPurchaseSourcesTableProcessedTableManager get itemPurchaseSourcesRefs {
    final manager = $$ItemPurchaseSourcesTableTableManager(
      $_db,
      $_db.itemPurchaseSources,
    ).filter((f) => f.wholesalerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _itemPurchaseSourcesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $InventoryTransactionsTable,
    List<InventoryTransaction>
  >
  _inventoryTransactionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.inventoryTransactions,
        aliasName: $_aliasNameGenerator(
          db.wholesalers.id,
          db.inventoryTransactions.wholesalerId,
        ),
      );

  $$InventoryTransactionsTableProcessedTableManager
  get inventoryTransactionsRefs {
    final manager = $$InventoryTransactionsTableTableManager(
      $_db,
      $_db.inventoryTransactions,
    ).filter((f) => f.wholesalerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _inventoryTransactionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$WholesalersTableFilterComposer
    extends Composer<_$AppDatabase, $WholesalersTable> {
  $$WholesalersTableFilterComposer({
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

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> wholesalerInventoryRefs(
    Expression<bool> Function($$WholesalerInventoryTableFilterComposer f) f,
  ) {
    final $$WholesalerInventoryTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.wholesalerInventory,
      getReferencedColumn: (t) => t.wholesalerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WholesalerInventoryTableFilterComposer(
            $db: $db,
            $table: $db.wholesalerInventory,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> itemPurchaseSourcesRefs(
    Expression<bool> Function($$ItemPurchaseSourcesTableFilterComposer f) f,
  ) {
    final $$ItemPurchaseSourcesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.itemPurchaseSources,
      getReferencedColumn: (t) => t.wholesalerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemPurchaseSourcesTableFilterComposer(
            $db: $db,
            $table: $db.itemPurchaseSources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> inventoryTransactionsRefs(
    Expression<bool> Function($$InventoryTransactionsTableFilterComposer f) f,
  ) {
    final $$InventoryTransactionsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.inventoryTransactions,
          getReferencedColumn: (t) => t.wholesalerId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InventoryTransactionsTableFilterComposer(
                $db: $db,
                $table: $db.inventoryTransactions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$WholesalersTableOrderingComposer
    extends Composer<_$AppDatabase, $WholesalersTable> {
  $$WholesalersTableOrderingComposer({
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

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WholesalersTableAnnotationComposer
    extends Composer<_$AppDatabase, $WholesalersTable> {
  $$WholesalersTableAnnotationComposer({
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

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> wholesalerInventoryRefs<T extends Object>(
    Expression<T> Function($$WholesalerInventoryTableAnnotationComposer a) f,
  ) {
    final $$WholesalerInventoryTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.wholesalerInventory,
          getReferencedColumn: (t) => t.wholesalerId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$WholesalerInventoryTableAnnotationComposer(
                $db: $db,
                $table: $db.wholesalerInventory,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> itemPurchaseSourcesRefs<T extends Object>(
    Expression<T> Function($$ItemPurchaseSourcesTableAnnotationComposer a) f,
  ) {
    final $$ItemPurchaseSourcesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.itemPurchaseSources,
          getReferencedColumn: (t) => t.wholesalerId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ItemPurchaseSourcesTableAnnotationComposer(
                $db: $db,
                $table: $db.itemPurchaseSources,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> inventoryTransactionsRefs<T extends Object>(
    Expression<T> Function($$InventoryTransactionsTableAnnotationComposer a) f,
  ) {
    final $$InventoryTransactionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.inventoryTransactions,
          getReferencedColumn: (t) => t.wholesalerId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InventoryTransactionsTableAnnotationComposer(
                $db: $db,
                $table: $db.inventoryTransactions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$WholesalersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WholesalersTable,
          Wholesaler,
          $$WholesalersTableFilterComposer,
          $$WholesalersTableOrderingComposer,
          $$WholesalersTableAnnotationComposer,
          $$WholesalersTableCreateCompanionBuilder,
          $$WholesalersTableUpdateCompanionBuilder,
          (Wholesaler, $$WholesalersTableReferences),
          Wholesaler,
          PrefetchHooks Function({
            bool wholesalerInventoryRefs,
            bool itemPurchaseSourcesRefs,
            bool inventoryTransactionsRefs,
          })
        > {
  $$WholesalersTableTableManager(_$AppDatabase db, $WholesalersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WholesalersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WholesalersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WholesalersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => WholesalersCompanion(
                id: id,
                name: name,
                phone: phone,
                address: address,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> phone = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => WholesalersCompanion.insert(
                id: id,
                name: name,
                phone: phone,
                address: address,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WholesalersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                wholesalerInventoryRefs = false,
                itemPurchaseSourcesRefs = false,
                inventoryTransactionsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (wholesalerInventoryRefs) db.wholesalerInventory,
                    if (itemPurchaseSourcesRefs) db.itemPurchaseSources,
                    if (inventoryTransactionsRefs) db.inventoryTransactions,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (wholesalerInventoryRefs)
                        await $_getPrefetchedData<
                          Wholesaler,
                          $WholesalersTable,
                          WholesalerInventoryData
                        >(
                          currentTable: table,
                          referencedTable: $$WholesalersTableReferences
                              ._wholesalerInventoryRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WholesalersTableReferences(
                                db,
                                table,
                                p0,
                              ).wholesalerInventoryRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.wholesalerId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (itemPurchaseSourcesRefs)
                        await $_getPrefetchedData<
                          Wholesaler,
                          $WholesalersTable,
                          ItemPurchaseSource
                        >(
                          currentTable: table,
                          referencedTable: $$WholesalersTableReferences
                              ._itemPurchaseSourcesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WholesalersTableReferences(
                                db,
                                table,
                                p0,
                              ).itemPurchaseSourcesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.wholesalerId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (inventoryTransactionsRefs)
                        await $_getPrefetchedData<
                          Wholesaler,
                          $WholesalersTable,
                          InventoryTransaction
                        >(
                          currentTable: table,
                          referencedTable: $$WholesalersTableReferences
                              ._inventoryTransactionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WholesalersTableReferences(
                                db,
                                table,
                                p0,
                              ).inventoryTransactionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.wholesalerId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$WholesalersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WholesalersTable,
      Wholesaler,
      $$WholesalersTableFilterComposer,
      $$WholesalersTableOrderingComposer,
      $$WholesalersTableAnnotationComposer,
      $$WholesalersTableCreateCompanionBuilder,
      $$WholesalersTableUpdateCompanionBuilder,
      (Wholesaler, $$WholesalersTableReferences),
      Wholesaler,
      PrefetchHooks Function({
        bool wholesalerInventoryRefs,
        bool itemPurchaseSourcesRefs,
        bool inventoryTransactionsRefs,
      })
    >;
typedef $$RetailersTableCreateCompanionBuilder =
    RetailersCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> phone,
      Value<String?> address,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$RetailersTableUpdateCompanionBuilder =
    RetailersCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> phone,
      Value<String?> address,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$RetailersTableReferences
    extends BaseReferences<_$AppDatabase, $RetailersTable, Retailer> {
  $$RetailersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RetailerBillsTable, List<RetailerBill>>
  _retailerBillsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.retailerBills,
    aliasName: $_aliasNameGenerator(
      db.retailers.id,
      db.retailerBills.retailerId,
    ),
  );

  $$RetailerBillsTableProcessedTableManager get retailerBillsRefs {
    final manager = $$RetailerBillsTableTableManager(
      $_db,
      $_db.retailerBills,
    ).filter((f) => f.retailerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_retailerBillsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $InventoryTransactionsTable,
    List<InventoryTransaction>
  >
  _inventoryTransactionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.inventoryTransactions,
        aliasName: $_aliasNameGenerator(
          db.retailers.id,
          db.inventoryTransactions.retailerId,
        ),
      );

  $$InventoryTransactionsTableProcessedTableManager
  get inventoryTransactionsRefs {
    final manager = $$InventoryTransactionsTableTableManager(
      $_db,
      $_db.inventoryTransactions,
    ).filter((f) => f.retailerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _inventoryTransactionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RetailersTableFilterComposer
    extends Composer<_$AppDatabase, $RetailersTable> {
  $$RetailersTableFilterComposer({
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

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> retailerBillsRefs(
    Expression<bool> Function($$RetailerBillsTableFilterComposer f) f,
  ) {
    final $$RetailerBillsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.retailerBills,
      getReferencedColumn: (t) => t.retailerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RetailerBillsTableFilterComposer(
            $db: $db,
            $table: $db.retailerBills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> inventoryTransactionsRefs(
    Expression<bool> Function($$InventoryTransactionsTableFilterComposer f) f,
  ) {
    final $$InventoryTransactionsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.inventoryTransactions,
          getReferencedColumn: (t) => t.retailerId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InventoryTransactionsTableFilterComposer(
                $db: $db,
                $table: $db.inventoryTransactions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$RetailersTableOrderingComposer
    extends Composer<_$AppDatabase, $RetailersTable> {
  $$RetailersTableOrderingComposer({
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

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RetailersTableAnnotationComposer
    extends Composer<_$AppDatabase, $RetailersTable> {
  $$RetailersTableAnnotationComposer({
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

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> retailerBillsRefs<T extends Object>(
    Expression<T> Function($$RetailerBillsTableAnnotationComposer a) f,
  ) {
    final $$RetailerBillsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.retailerBills,
      getReferencedColumn: (t) => t.retailerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RetailerBillsTableAnnotationComposer(
            $db: $db,
            $table: $db.retailerBills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> inventoryTransactionsRefs<T extends Object>(
    Expression<T> Function($$InventoryTransactionsTableAnnotationComposer a) f,
  ) {
    final $$InventoryTransactionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.inventoryTransactions,
          getReferencedColumn: (t) => t.retailerId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InventoryTransactionsTableAnnotationComposer(
                $db: $db,
                $table: $db.inventoryTransactions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$RetailersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RetailersTable,
          Retailer,
          $$RetailersTableFilterComposer,
          $$RetailersTableOrderingComposer,
          $$RetailersTableAnnotationComposer,
          $$RetailersTableCreateCompanionBuilder,
          $$RetailersTableUpdateCompanionBuilder,
          (Retailer, $$RetailersTableReferences),
          Retailer,
          PrefetchHooks Function({
            bool retailerBillsRefs,
            bool inventoryTransactionsRefs,
          })
        > {
  $$RetailersTableTableManager(_$AppDatabase db, $RetailersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RetailersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RetailersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RetailersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => RetailersCompanion(
                id: id,
                name: name,
                phone: phone,
                address: address,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> phone = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => RetailersCompanion.insert(
                id: id,
                name: name,
                phone: phone,
                address: address,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RetailersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({retailerBillsRefs = false, inventoryTransactionsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (retailerBillsRefs) db.retailerBills,
                    if (inventoryTransactionsRefs) db.inventoryTransactions,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (retailerBillsRefs)
                        await $_getPrefetchedData<
                          Retailer,
                          $RetailersTable,
                          RetailerBill
                        >(
                          currentTable: table,
                          referencedTable: $$RetailersTableReferences
                              ._retailerBillsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RetailersTableReferences(
                                db,
                                table,
                                p0,
                              ).retailerBillsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.retailerId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (inventoryTransactionsRefs)
                        await $_getPrefetchedData<
                          Retailer,
                          $RetailersTable,
                          InventoryTransaction
                        >(
                          currentTable: table,
                          referencedTable: $$RetailersTableReferences
                              ._inventoryTransactionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RetailersTableReferences(
                                db,
                                table,
                                p0,
                              ).inventoryTransactionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.retailerId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$RetailersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RetailersTable,
      Retailer,
      $$RetailersTableFilterComposer,
      $$RetailersTableOrderingComposer,
      $$RetailersTableAnnotationComposer,
      $$RetailersTableCreateCompanionBuilder,
      $$RetailersTableUpdateCompanionBuilder,
      (Retailer, $$RetailersTableReferences),
      Retailer,
      PrefetchHooks Function({
        bool retailerBillsRefs,
        bool inventoryTransactionsRefs,
      })
    >;
typedef $$WholesalerInventoryTableCreateCompanionBuilder =
    WholesalerInventoryCompanion Function({
      Value<int> id,
      required int itemId,
      required int wholesalerId,
      required double quantityToSell,
      required double purchasePrice,
      Value<double> bardana,
      Value<DateTime> receivedAt,
    });
typedef $$WholesalerInventoryTableUpdateCompanionBuilder =
    WholesalerInventoryCompanion Function({
      Value<int> id,
      Value<int> itemId,
      Value<int> wholesalerId,
      Value<double> quantityToSell,
      Value<double> purchasePrice,
      Value<double> bardana,
      Value<DateTime> receivedAt,
    });

final class $$WholesalerInventoryTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $WholesalerInventoryTable,
          WholesalerInventoryData
        > {
  $$WholesalerInventoryTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ItemsTable _itemIdTable(_$AppDatabase db) => db.items.createAlias(
    $_aliasNameGenerator(db.wholesalerInventory.itemId, db.items.id),
  );

  $$ItemsTableProcessedTableManager get itemId {
    final $_column = $_itemColumn<int>('item_id')!;

    final manager = $$ItemsTableTableManager(
      $_db,
      $_db.items,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_itemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $WholesalersTable _wholesalerIdTable(_$AppDatabase db) =>
      db.wholesalers.createAlias(
        $_aliasNameGenerator(
          db.wholesalerInventory.wholesalerId,
          db.wholesalers.id,
        ),
      );

  $$WholesalersTableProcessedTableManager get wholesalerId {
    final $_column = $_itemColumn<int>('wholesaler_id')!;

    final manager = $$WholesalersTableTableManager(
      $_db,
      $_db.wholesalers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_wholesalerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$BillItemSourcesTable, List<BillItemSource>>
  _billItemSourcesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.billItemSources,
    aliasName: $_aliasNameGenerator(
      db.wholesalerInventory.id,
      db.billItemSources.inventoryId,
    ),
  );

  $$BillItemSourcesTableProcessedTableManager get billItemSourcesRefs {
    final manager = $$BillItemSourcesTableTableManager(
      $_db,
      $_db.billItemSources,
    ).filter((f) => f.inventoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _billItemSourcesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$WholesalerInventoryTableFilterComposer
    extends Composer<_$AppDatabase, $WholesalerInventoryTable> {
  $$WholesalerInventoryTableFilterComposer({
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

  ColumnFilters<double> get quantityToSell => $composableBuilder(
    column: $table.quantityToSell,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get bardana => $composableBuilder(
    column: $table.bardana,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get receivedAt => $composableBuilder(
    column: $table.receivedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ItemsTableFilterComposer get itemId {
    final $$ItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableFilterComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WholesalersTableFilterComposer get wholesalerId {
    final $$WholesalersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wholesalerId,
      referencedTable: $db.wholesalers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WholesalersTableFilterComposer(
            $db: $db,
            $table: $db.wholesalers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> billItemSourcesRefs(
    Expression<bool> Function($$BillItemSourcesTableFilterComposer f) f,
  ) {
    final $$BillItemSourcesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.billItemSources,
      getReferencedColumn: (t) => t.inventoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BillItemSourcesTableFilterComposer(
            $db: $db,
            $table: $db.billItemSources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WholesalerInventoryTableOrderingComposer
    extends Composer<_$AppDatabase, $WholesalerInventoryTable> {
  $$WholesalerInventoryTableOrderingComposer({
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

  ColumnOrderings<double> get quantityToSell => $composableBuilder(
    column: $table.quantityToSell,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get bardana => $composableBuilder(
    column: $table.bardana,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get receivedAt => $composableBuilder(
    column: $table.receivedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ItemsTableOrderingComposer get itemId {
    final $$ItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableOrderingComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WholesalersTableOrderingComposer get wholesalerId {
    final $$WholesalersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wholesalerId,
      referencedTable: $db.wholesalers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WholesalersTableOrderingComposer(
            $db: $db,
            $table: $db.wholesalers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WholesalerInventoryTableAnnotationComposer
    extends Composer<_$AppDatabase, $WholesalerInventoryTable> {
  $$WholesalerInventoryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get quantityToSell => $composableBuilder(
    column: $table.quantityToSell,
    builder: (column) => column,
  );

  GeneratedColumn<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get bardana =>
      $composableBuilder(column: $table.bardana, builder: (column) => column);

  GeneratedColumn<DateTime> get receivedAt => $composableBuilder(
    column: $table.receivedAt,
    builder: (column) => column,
  );

  $$ItemsTableAnnotationComposer get itemId {
    final $$ItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WholesalersTableAnnotationComposer get wholesalerId {
    final $$WholesalersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wholesalerId,
      referencedTable: $db.wholesalers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WholesalersTableAnnotationComposer(
            $db: $db,
            $table: $db.wholesalers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> billItemSourcesRefs<T extends Object>(
    Expression<T> Function($$BillItemSourcesTableAnnotationComposer a) f,
  ) {
    final $$BillItemSourcesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.billItemSources,
      getReferencedColumn: (t) => t.inventoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BillItemSourcesTableAnnotationComposer(
            $db: $db,
            $table: $db.billItemSources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WholesalerInventoryTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WholesalerInventoryTable,
          WholesalerInventoryData,
          $$WholesalerInventoryTableFilterComposer,
          $$WholesalerInventoryTableOrderingComposer,
          $$WholesalerInventoryTableAnnotationComposer,
          $$WholesalerInventoryTableCreateCompanionBuilder,
          $$WholesalerInventoryTableUpdateCompanionBuilder,
          (WholesalerInventoryData, $$WholesalerInventoryTableReferences),
          WholesalerInventoryData,
          PrefetchHooks Function({
            bool itemId,
            bool wholesalerId,
            bool billItemSourcesRefs,
          })
        > {
  $$WholesalerInventoryTableTableManager(
    _$AppDatabase db,
    $WholesalerInventoryTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WholesalerInventoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WholesalerInventoryTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$WholesalerInventoryTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> itemId = const Value.absent(),
                Value<int> wholesalerId = const Value.absent(),
                Value<double> quantityToSell = const Value.absent(),
                Value<double> purchasePrice = const Value.absent(),
                Value<double> bardana = const Value.absent(),
                Value<DateTime> receivedAt = const Value.absent(),
              }) => WholesalerInventoryCompanion(
                id: id,
                itemId: itemId,
                wholesalerId: wholesalerId,
                quantityToSell: quantityToSell,
                purchasePrice: purchasePrice,
                bardana: bardana,
                receivedAt: receivedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int itemId,
                required int wholesalerId,
                required double quantityToSell,
                required double purchasePrice,
                Value<double> bardana = const Value.absent(),
                Value<DateTime> receivedAt = const Value.absent(),
              }) => WholesalerInventoryCompanion.insert(
                id: id,
                itemId: itemId,
                wholesalerId: wholesalerId,
                quantityToSell: quantityToSell,
                purchasePrice: purchasePrice,
                bardana: bardana,
                receivedAt: receivedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WholesalerInventoryTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                itemId = false,
                wholesalerId = false,
                billItemSourcesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (billItemSourcesRefs) db.billItemSources,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (itemId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.itemId,
                                    referencedTable:
                                        $$WholesalerInventoryTableReferences
                                            ._itemIdTable(db),
                                    referencedColumn:
                                        $$WholesalerInventoryTableReferences
                                            ._itemIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (wholesalerId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.wholesalerId,
                                    referencedTable:
                                        $$WholesalerInventoryTableReferences
                                            ._wholesalerIdTable(db),
                                    referencedColumn:
                                        $$WholesalerInventoryTableReferences
                                            ._wholesalerIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (billItemSourcesRefs)
                        await $_getPrefetchedData<
                          WholesalerInventoryData,
                          $WholesalerInventoryTable,
                          BillItemSource
                        >(
                          currentTable: table,
                          referencedTable: $$WholesalerInventoryTableReferences
                              ._billItemSourcesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WholesalerInventoryTableReferences(
                                db,
                                table,
                                p0,
                              ).billItemSourcesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.inventoryId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$WholesalerInventoryTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WholesalerInventoryTable,
      WholesalerInventoryData,
      $$WholesalerInventoryTableFilterComposer,
      $$WholesalerInventoryTableOrderingComposer,
      $$WholesalerInventoryTableAnnotationComposer,
      $$WholesalerInventoryTableCreateCompanionBuilder,
      $$WholesalerInventoryTableUpdateCompanionBuilder,
      (WholesalerInventoryData, $$WholesalerInventoryTableReferences),
      WholesalerInventoryData,
      PrefetchHooks Function({
        bool itemId,
        bool wholesalerId,
        bool billItemSourcesRefs,
      })
    >;
typedef $$RetailerBillsTableCreateCompanionBuilder =
    RetailerBillsCompanion Function({
      Value<int> id,
      required int retailerId,
      required double totalAmount,
      Value<double> taxAmount,
      Value<double> bardanaAmount,
      Value<DateTime> date,
      Value<String?> pdfPath,
    });
typedef $$RetailerBillsTableUpdateCompanionBuilder =
    RetailerBillsCompanion Function({
      Value<int> id,
      Value<int> retailerId,
      Value<double> totalAmount,
      Value<double> taxAmount,
      Value<double> bardanaAmount,
      Value<DateTime> date,
      Value<String?> pdfPath,
    });

final class $$RetailerBillsTableReferences
    extends BaseReferences<_$AppDatabase, $RetailerBillsTable, RetailerBill> {
  $$RetailerBillsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $RetailersTable _retailerIdTable(_$AppDatabase db) =>
      db.retailers.createAlias(
        $_aliasNameGenerator(db.retailerBills.retailerId, db.retailers.id),
      );

  $$RetailersTableProcessedTableManager get retailerId {
    final $_column = $_itemColumn<int>('retailer_id')!;

    final manager = $$RetailersTableTableManager(
      $_db,
      $_db.retailers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_retailerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$RetailerBillItemsTable, List<RetailerBillItem>>
  _retailerBillItemsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.retailerBillItems,
        aliasName: $_aliasNameGenerator(
          db.retailerBills.id,
          db.retailerBillItems.billId,
        ),
      );

  $$RetailerBillItemsTableProcessedTableManager get retailerBillItemsRefs {
    final manager = $$RetailerBillItemsTableTableManager(
      $_db,
      $_db.retailerBillItems,
    ).filter((f) => f.billId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _retailerBillItemsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RetailerBillsTableFilterComposer
    extends Composer<_$AppDatabase, $RetailerBillsTable> {
  $$RetailerBillsTableFilterComposer({
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

  ColumnFilters<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get taxAmount => $composableBuilder(
    column: $table.taxAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get bardanaAmount => $composableBuilder(
    column: $table.bardanaAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pdfPath => $composableBuilder(
    column: $table.pdfPath,
    builder: (column) => ColumnFilters(column),
  );

  $$RetailersTableFilterComposer get retailerId {
    final $$RetailersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.retailerId,
      referencedTable: $db.retailers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RetailersTableFilterComposer(
            $db: $db,
            $table: $db.retailers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> retailerBillItemsRefs(
    Expression<bool> Function($$RetailerBillItemsTableFilterComposer f) f,
  ) {
    final $$RetailerBillItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.retailerBillItems,
      getReferencedColumn: (t) => t.billId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RetailerBillItemsTableFilterComposer(
            $db: $db,
            $table: $db.retailerBillItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RetailerBillsTableOrderingComposer
    extends Composer<_$AppDatabase, $RetailerBillsTable> {
  $$RetailerBillsTableOrderingComposer({
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

  ColumnOrderings<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get taxAmount => $composableBuilder(
    column: $table.taxAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get bardanaAmount => $composableBuilder(
    column: $table.bardanaAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pdfPath => $composableBuilder(
    column: $table.pdfPath,
    builder: (column) => ColumnOrderings(column),
  );

  $$RetailersTableOrderingComposer get retailerId {
    final $$RetailersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.retailerId,
      referencedTable: $db.retailers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RetailersTableOrderingComposer(
            $db: $db,
            $table: $db.retailers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RetailerBillsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RetailerBillsTable> {
  $$RetailerBillsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get taxAmount =>
      $composableBuilder(column: $table.taxAmount, builder: (column) => column);

  GeneratedColumn<double> get bardanaAmount => $composableBuilder(
    column: $table.bardanaAmount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get pdfPath =>
      $composableBuilder(column: $table.pdfPath, builder: (column) => column);

  $$RetailersTableAnnotationComposer get retailerId {
    final $$RetailersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.retailerId,
      referencedTable: $db.retailers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RetailersTableAnnotationComposer(
            $db: $db,
            $table: $db.retailers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> retailerBillItemsRefs<T extends Object>(
    Expression<T> Function($$RetailerBillItemsTableAnnotationComposer a) f,
  ) {
    final $$RetailerBillItemsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.retailerBillItems,
          getReferencedColumn: (t) => t.billId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$RetailerBillItemsTableAnnotationComposer(
                $db: $db,
                $table: $db.retailerBillItems,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$RetailerBillsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RetailerBillsTable,
          RetailerBill,
          $$RetailerBillsTableFilterComposer,
          $$RetailerBillsTableOrderingComposer,
          $$RetailerBillsTableAnnotationComposer,
          $$RetailerBillsTableCreateCompanionBuilder,
          $$RetailerBillsTableUpdateCompanionBuilder,
          (RetailerBill, $$RetailerBillsTableReferences),
          RetailerBill,
          PrefetchHooks Function({bool retailerId, bool retailerBillItemsRefs})
        > {
  $$RetailerBillsTableTableManager(_$AppDatabase db, $RetailerBillsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RetailerBillsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RetailerBillsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RetailerBillsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> retailerId = const Value.absent(),
                Value<double> totalAmount = const Value.absent(),
                Value<double> taxAmount = const Value.absent(),
                Value<double> bardanaAmount = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String?> pdfPath = const Value.absent(),
              }) => RetailerBillsCompanion(
                id: id,
                retailerId: retailerId,
                totalAmount: totalAmount,
                taxAmount: taxAmount,
                bardanaAmount: bardanaAmount,
                date: date,
                pdfPath: pdfPath,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int retailerId,
                required double totalAmount,
                Value<double> taxAmount = const Value.absent(),
                Value<double> bardanaAmount = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String?> pdfPath = const Value.absent(),
              }) => RetailerBillsCompanion.insert(
                id: id,
                retailerId: retailerId,
                totalAmount: totalAmount,
                taxAmount: taxAmount,
                bardanaAmount: bardanaAmount,
                date: date,
                pdfPath: pdfPath,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RetailerBillsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({retailerId = false, retailerBillItemsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (retailerBillItemsRefs) db.retailerBillItems,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (retailerId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.retailerId,
                                    referencedTable:
                                        $$RetailerBillsTableReferences
                                            ._retailerIdTable(db),
                                    referencedColumn:
                                        $$RetailerBillsTableReferences
                                            ._retailerIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (retailerBillItemsRefs)
                        await $_getPrefetchedData<
                          RetailerBill,
                          $RetailerBillsTable,
                          RetailerBillItem
                        >(
                          currentTable: table,
                          referencedTable: $$RetailerBillsTableReferences
                              ._retailerBillItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RetailerBillsTableReferences(
                                db,
                                table,
                                p0,
                              ).retailerBillItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.billId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$RetailerBillsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RetailerBillsTable,
      RetailerBill,
      $$RetailerBillsTableFilterComposer,
      $$RetailerBillsTableOrderingComposer,
      $$RetailerBillsTableAnnotationComposer,
      $$RetailerBillsTableCreateCompanionBuilder,
      $$RetailerBillsTableUpdateCompanionBuilder,
      (RetailerBill, $$RetailerBillsTableReferences),
      RetailerBill,
      PrefetchHooks Function({bool retailerId, bool retailerBillItemsRefs})
    >;
typedef $$RetailerBillItemsTableCreateCompanionBuilder =
    RetailerBillItemsCompanion Function({
      Value<int> id,
      required int billId,
      required int itemId,
      required double quantity,
      required double sellingPrice,
      required double gstRate,
      required double bardana,
    });
typedef $$RetailerBillItemsTableUpdateCompanionBuilder =
    RetailerBillItemsCompanion Function({
      Value<int> id,
      Value<int> billId,
      Value<int> itemId,
      Value<double> quantity,
      Value<double> sellingPrice,
      Value<double> gstRate,
      Value<double> bardana,
    });

final class $$RetailerBillItemsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $RetailerBillItemsTable,
          RetailerBillItem
        > {
  $$RetailerBillItemsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $RetailerBillsTable _billIdTable(_$AppDatabase db) =>
      db.retailerBills.createAlias(
        $_aliasNameGenerator(db.retailerBillItems.billId, db.retailerBills.id),
      );

  $$RetailerBillsTableProcessedTableManager get billId {
    final $_column = $_itemColumn<int>('bill_id')!;

    final manager = $$RetailerBillsTableTableManager(
      $_db,
      $_db.retailerBills,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_billIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ItemsTable _itemIdTable(_$AppDatabase db) => db.items.createAlias(
    $_aliasNameGenerator(db.retailerBillItems.itemId, db.items.id),
  );

  $$ItemsTableProcessedTableManager get itemId {
    final $_column = $_itemColumn<int>('item_id')!;

    final manager = $$ItemsTableTableManager(
      $_db,
      $_db.items,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_itemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$BillItemSourcesTable, List<BillItemSource>>
  _billItemSourcesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.billItemSources,
    aliasName: $_aliasNameGenerator(
      db.retailerBillItems.id,
      db.billItemSources.billItemId,
    ),
  );

  $$BillItemSourcesTableProcessedTableManager get billItemSourcesRefs {
    final manager = $$BillItemSourcesTableTableManager(
      $_db,
      $_db.billItemSources,
    ).filter((f) => f.billItemId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _billItemSourcesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RetailerBillItemsTableFilterComposer
    extends Composer<_$AppDatabase, $RetailerBillItemsTable> {
  $$RetailerBillItemsTableFilterComposer({
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

  ColumnFilters<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get sellingPrice => $composableBuilder(
    column: $table.sellingPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get gstRate => $composableBuilder(
    column: $table.gstRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get bardana => $composableBuilder(
    column: $table.bardana,
    builder: (column) => ColumnFilters(column),
  );

  $$RetailerBillsTableFilterComposer get billId {
    final $$RetailerBillsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.billId,
      referencedTable: $db.retailerBills,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RetailerBillsTableFilterComposer(
            $db: $db,
            $table: $db.retailerBills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ItemsTableFilterComposer get itemId {
    final $$ItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableFilterComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> billItemSourcesRefs(
    Expression<bool> Function($$BillItemSourcesTableFilterComposer f) f,
  ) {
    final $$BillItemSourcesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.billItemSources,
      getReferencedColumn: (t) => t.billItemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BillItemSourcesTableFilterComposer(
            $db: $db,
            $table: $db.billItemSources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RetailerBillItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $RetailerBillItemsTable> {
  $$RetailerBillItemsTableOrderingComposer({
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

  ColumnOrderings<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get sellingPrice => $composableBuilder(
    column: $table.sellingPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get gstRate => $composableBuilder(
    column: $table.gstRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get bardana => $composableBuilder(
    column: $table.bardana,
    builder: (column) => ColumnOrderings(column),
  );

  $$RetailerBillsTableOrderingComposer get billId {
    final $$RetailerBillsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.billId,
      referencedTable: $db.retailerBills,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RetailerBillsTableOrderingComposer(
            $db: $db,
            $table: $db.retailerBills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ItemsTableOrderingComposer get itemId {
    final $$ItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableOrderingComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RetailerBillItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RetailerBillItemsTable> {
  $$RetailerBillItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get sellingPrice => $composableBuilder(
    column: $table.sellingPrice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get gstRate =>
      $composableBuilder(column: $table.gstRate, builder: (column) => column);

  GeneratedColumn<double> get bardana =>
      $composableBuilder(column: $table.bardana, builder: (column) => column);

  $$RetailerBillsTableAnnotationComposer get billId {
    final $$RetailerBillsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.billId,
      referencedTable: $db.retailerBills,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RetailerBillsTableAnnotationComposer(
            $db: $db,
            $table: $db.retailerBills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ItemsTableAnnotationComposer get itemId {
    final $$ItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> billItemSourcesRefs<T extends Object>(
    Expression<T> Function($$BillItemSourcesTableAnnotationComposer a) f,
  ) {
    final $$BillItemSourcesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.billItemSources,
      getReferencedColumn: (t) => t.billItemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BillItemSourcesTableAnnotationComposer(
            $db: $db,
            $table: $db.billItemSources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RetailerBillItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RetailerBillItemsTable,
          RetailerBillItem,
          $$RetailerBillItemsTableFilterComposer,
          $$RetailerBillItemsTableOrderingComposer,
          $$RetailerBillItemsTableAnnotationComposer,
          $$RetailerBillItemsTableCreateCompanionBuilder,
          $$RetailerBillItemsTableUpdateCompanionBuilder,
          (RetailerBillItem, $$RetailerBillItemsTableReferences),
          RetailerBillItem,
          PrefetchHooks Function({
            bool billId,
            bool itemId,
            bool billItemSourcesRefs,
          })
        > {
  $$RetailerBillItemsTableTableManager(
    _$AppDatabase db,
    $RetailerBillItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RetailerBillItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RetailerBillItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RetailerBillItemsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> billId = const Value.absent(),
                Value<int> itemId = const Value.absent(),
                Value<double> quantity = const Value.absent(),
                Value<double> sellingPrice = const Value.absent(),
                Value<double> gstRate = const Value.absent(),
                Value<double> bardana = const Value.absent(),
              }) => RetailerBillItemsCompanion(
                id: id,
                billId: billId,
                itemId: itemId,
                quantity: quantity,
                sellingPrice: sellingPrice,
                gstRate: gstRate,
                bardana: bardana,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int billId,
                required int itemId,
                required double quantity,
                required double sellingPrice,
                required double gstRate,
                required double bardana,
              }) => RetailerBillItemsCompanion.insert(
                id: id,
                billId: billId,
                itemId: itemId,
                quantity: quantity,
                sellingPrice: sellingPrice,
                gstRate: gstRate,
                bardana: bardana,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RetailerBillItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({billId = false, itemId = false, billItemSourcesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (billItemSourcesRefs) db.billItemSources,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (billId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.billId,
                                    referencedTable:
                                        $$RetailerBillItemsTableReferences
                                            ._billIdTable(db),
                                    referencedColumn:
                                        $$RetailerBillItemsTableReferences
                                            ._billIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (itemId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.itemId,
                                    referencedTable:
                                        $$RetailerBillItemsTableReferences
                                            ._itemIdTable(db),
                                    referencedColumn:
                                        $$RetailerBillItemsTableReferences
                                            ._itemIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (billItemSourcesRefs)
                        await $_getPrefetchedData<
                          RetailerBillItem,
                          $RetailerBillItemsTable,
                          BillItemSource
                        >(
                          currentTable: table,
                          referencedTable: $$RetailerBillItemsTableReferences
                              ._billItemSourcesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RetailerBillItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).billItemSourcesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.billItemId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$RetailerBillItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RetailerBillItemsTable,
      RetailerBillItem,
      $$RetailerBillItemsTableFilterComposer,
      $$RetailerBillItemsTableOrderingComposer,
      $$RetailerBillItemsTableAnnotationComposer,
      $$RetailerBillItemsTableCreateCompanionBuilder,
      $$RetailerBillItemsTableUpdateCompanionBuilder,
      (RetailerBillItem, $$RetailerBillItemsTableReferences),
      RetailerBillItem,
      PrefetchHooks Function({
        bool billId,
        bool itemId,
        bool billItemSourcesRefs,
      })
    >;
typedef $$ItemPurchaseSourcesTableCreateCompanionBuilder =
    ItemPurchaseSourcesCompanion Function({
      Value<int> id,
      required int itemId,
      required int wholesalerId,
      required double purchasePrice,
      Value<double> gstRate,
      Value<double> bardana,
      Value<double?> quantity,
      Value<bool> isQuantityNa,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int?> originalInventoryId,
    });
typedef $$ItemPurchaseSourcesTableUpdateCompanionBuilder =
    ItemPurchaseSourcesCompanion Function({
      Value<int> id,
      Value<int> itemId,
      Value<int> wholesalerId,
      Value<double> purchasePrice,
      Value<double> gstRate,
      Value<double> bardana,
      Value<double?> quantity,
      Value<bool> isQuantityNa,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int?> originalInventoryId,
    });

final class $$ItemPurchaseSourcesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ItemPurchaseSourcesTable,
          ItemPurchaseSource
        > {
  $$ItemPurchaseSourcesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ItemsTable _itemIdTable(_$AppDatabase db) => db.items.createAlias(
    $_aliasNameGenerator(db.itemPurchaseSources.itemId, db.items.id),
  );

  $$ItemsTableProcessedTableManager get itemId {
    final $_column = $_itemColumn<int>('item_id')!;

    final manager = $$ItemsTableTableManager(
      $_db,
      $_db.items,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_itemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $WholesalersTable _wholesalerIdTable(_$AppDatabase db) =>
      db.wholesalers.createAlias(
        $_aliasNameGenerator(
          db.itemPurchaseSources.wholesalerId,
          db.wholesalers.id,
        ),
      );

  $$WholesalersTableProcessedTableManager get wholesalerId {
    final $_column = $_itemColumn<int>('wholesaler_id')!;

    final manager = $$WholesalersTableTableManager(
      $_db,
      $_db.wholesalers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_wholesalerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$BillItemSourcesTable, List<BillItemSource>>
  _billItemSourcesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.billItemSources,
    aliasName: $_aliasNameGenerator(
      db.itemPurchaseSources.id,
      db.billItemSources.purchaseSourceId,
    ),
  );

  $$BillItemSourcesTableProcessedTableManager get billItemSourcesRefs {
    final manager = $$BillItemSourcesTableTableManager(
      $_db,
      $_db.billItemSources,
    ).filter((f) => f.purchaseSourceId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _billItemSourcesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ItemPurchaseSourcesTableFilterComposer
    extends Composer<_$AppDatabase, $ItemPurchaseSourcesTable> {
  $$ItemPurchaseSourcesTableFilterComposer({
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

  ColumnFilters<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get gstRate => $composableBuilder(
    column: $table.gstRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get bardana => $composableBuilder(
    column: $table.bardana,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isQuantityNa => $composableBuilder(
    column: $table.isQuantityNa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get originalInventoryId => $composableBuilder(
    column: $table.originalInventoryId,
    builder: (column) => ColumnFilters(column),
  );

  $$ItemsTableFilterComposer get itemId {
    final $$ItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableFilterComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WholesalersTableFilterComposer get wholesalerId {
    final $$WholesalersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wholesalerId,
      referencedTable: $db.wholesalers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WholesalersTableFilterComposer(
            $db: $db,
            $table: $db.wholesalers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> billItemSourcesRefs(
    Expression<bool> Function($$BillItemSourcesTableFilterComposer f) f,
  ) {
    final $$BillItemSourcesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.billItemSources,
      getReferencedColumn: (t) => t.purchaseSourceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BillItemSourcesTableFilterComposer(
            $db: $db,
            $table: $db.billItemSources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ItemPurchaseSourcesTableOrderingComposer
    extends Composer<_$AppDatabase, $ItemPurchaseSourcesTable> {
  $$ItemPurchaseSourcesTableOrderingComposer({
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

  ColumnOrderings<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get gstRate => $composableBuilder(
    column: $table.gstRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get bardana => $composableBuilder(
    column: $table.bardana,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isQuantityNa => $composableBuilder(
    column: $table.isQuantityNa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get originalInventoryId => $composableBuilder(
    column: $table.originalInventoryId,
    builder: (column) => ColumnOrderings(column),
  );

  $$ItemsTableOrderingComposer get itemId {
    final $$ItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableOrderingComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WholesalersTableOrderingComposer get wholesalerId {
    final $$WholesalersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wholesalerId,
      referencedTable: $db.wholesalers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WholesalersTableOrderingComposer(
            $db: $db,
            $table: $db.wholesalers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ItemPurchaseSourcesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ItemPurchaseSourcesTable> {
  $$ItemPurchaseSourcesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get gstRate =>
      $composableBuilder(column: $table.gstRate, builder: (column) => column);

  GeneratedColumn<double> get bardana =>
      $composableBuilder(column: $table.bardana, builder: (column) => column);

  GeneratedColumn<double> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<bool> get isQuantityNa => $composableBuilder(
    column: $table.isQuantityNa,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get originalInventoryId => $composableBuilder(
    column: $table.originalInventoryId,
    builder: (column) => column,
  );

  $$ItemsTableAnnotationComposer get itemId {
    final $$ItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WholesalersTableAnnotationComposer get wholesalerId {
    final $$WholesalersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wholesalerId,
      referencedTable: $db.wholesalers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WholesalersTableAnnotationComposer(
            $db: $db,
            $table: $db.wholesalers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> billItemSourcesRefs<T extends Object>(
    Expression<T> Function($$BillItemSourcesTableAnnotationComposer a) f,
  ) {
    final $$BillItemSourcesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.billItemSources,
      getReferencedColumn: (t) => t.purchaseSourceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BillItemSourcesTableAnnotationComposer(
            $db: $db,
            $table: $db.billItemSources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ItemPurchaseSourcesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ItemPurchaseSourcesTable,
          ItemPurchaseSource,
          $$ItemPurchaseSourcesTableFilterComposer,
          $$ItemPurchaseSourcesTableOrderingComposer,
          $$ItemPurchaseSourcesTableAnnotationComposer,
          $$ItemPurchaseSourcesTableCreateCompanionBuilder,
          $$ItemPurchaseSourcesTableUpdateCompanionBuilder,
          (ItemPurchaseSource, $$ItemPurchaseSourcesTableReferences),
          ItemPurchaseSource,
          PrefetchHooks Function({
            bool itemId,
            bool wholesalerId,
            bool billItemSourcesRefs,
          })
        > {
  $$ItemPurchaseSourcesTableTableManager(
    _$AppDatabase db,
    $ItemPurchaseSourcesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ItemPurchaseSourcesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ItemPurchaseSourcesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ItemPurchaseSourcesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> itemId = const Value.absent(),
                Value<int> wholesalerId = const Value.absent(),
                Value<double> purchasePrice = const Value.absent(),
                Value<double> gstRate = const Value.absent(),
                Value<double> bardana = const Value.absent(),
                Value<double?> quantity = const Value.absent(),
                Value<bool> isQuantityNa = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int?> originalInventoryId = const Value.absent(),
              }) => ItemPurchaseSourcesCompanion(
                id: id,
                itemId: itemId,
                wholesalerId: wholesalerId,
                purchasePrice: purchasePrice,
                gstRate: gstRate,
                bardana: bardana,
                quantity: quantity,
                isQuantityNa: isQuantityNa,
                createdAt: createdAt,
                updatedAt: updatedAt,
                originalInventoryId: originalInventoryId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int itemId,
                required int wholesalerId,
                required double purchasePrice,
                Value<double> gstRate = const Value.absent(),
                Value<double> bardana = const Value.absent(),
                Value<double?> quantity = const Value.absent(),
                Value<bool> isQuantityNa = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int?> originalInventoryId = const Value.absent(),
              }) => ItemPurchaseSourcesCompanion.insert(
                id: id,
                itemId: itemId,
                wholesalerId: wholesalerId,
                purchasePrice: purchasePrice,
                gstRate: gstRate,
                bardana: bardana,
                quantity: quantity,
                isQuantityNa: isQuantityNa,
                createdAt: createdAt,
                updatedAt: updatedAt,
                originalInventoryId: originalInventoryId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ItemPurchaseSourcesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                itemId = false,
                wholesalerId = false,
                billItemSourcesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (billItemSourcesRefs) db.billItemSources,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (itemId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.itemId,
                                    referencedTable:
                                        $$ItemPurchaseSourcesTableReferences
                                            ._itemIdTable(db),
                                    referencedColumn:
                                        $$ItemPurchaseSourcesTableReferences
                                            ._itemIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (wholesalerId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.wholesalerId,
                                    referencedTable:
                                        $$ItemPurchaseSourcesTableReferences
                                            ._wholesalerIdTable(db),
                                    referencedColumn:
                                        $$ItemPurchaseSourcesTableReferences
                                            ._wholesalerIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (billItemSourcesRefs)
                        await $_getPrefetchedData<
                          ItemPurchaseSource,
                          $ItemPurchaseSourcesTable,
                          BillItemSource
                        >(
                          currentTable: table,
                          referencedTable: $$ItemPurchaseSourcesTableReferences
                              ._billItemSourcesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ItemPurchaseSourcesTableReferences(
                                db,
                                table,
                                p0,
                              ).billItemSourcesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.purchaseSourceId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ItemPurchaseSourcesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ItemPurchaseSourcesTable,
      ItemPurchaseSource,
      $$ItemPurchaseSourcesTableFilterComposer,
      $$ItemPurchaseSourcesTableOrderingComposer,
      $$ItemPurchaseSourcesTableAnnotationComposer,
      $$ItemPurchaseSourcesTableCreateCompanionBuilder,
      $$ItemPurchaseSourcesTableUpdateCompanionBuilder,
      (ItemPurchaseSource, $$ItemPurchaseSourcesTableReferences),
      ItemPurchaseSource,
      PrefetchHooks Function({
        bool itemId,
        bool wholesalerId,
        bool billItemSourcesRefs,
      })
    >;
typedef $$BillItemSourcesTableCreateCompanionBuilder =
    BillItemSourcesCompanion Function({
      Value<int> id,
      required int billItemId,
      Value<int?> inventoryId,
      Value<int?> purchaseSourceId,
      required double quantityAllocated,
      required double purchasePriceAtTime,
    });
typedef $$BillItemSourcesTableUpdateCompanionBuilder =
    BillItemSourcesCompanion Function({
      Value<int> id,
      Value<int> billItemId,
      Value<int?> inventoryId,
      Value<int?> purchaseSourceId,
      Value<double> quantityAllocated,
      Value<double> purchasePriceAtTime,
    });

final class $$BillItemSourcesTableReferences
    extends
        BaseReferences<_$AppDatabase, $BillItemSourcesTable, BillItemSource> {
  $$BillItemSourcesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $RetailerBillItemsTable _billItemIdTable(_$AppDatabase db) =>
      db.retailerBillItems.createAlias(
        $_aliasNameGenerator(
          db.billItemSources.billItemId,
          db.retailerBillItems.id,
        ),
      );

  $$RetailerBillItemsTableProcessedTableManager get billItemId {
    final $_column = $_itemColumn<int>('bill_item_id')!;

    final manager = $$RetailerBillItemsTableTableManager(
      $_db,
      $_db.retailerBillItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_billItemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $WholesalerInventoryTable _inventoryIdTable(_$AppDatabase db) =>
      db.wholesalerInventory.createAlias(
        $_aliasNameGenerator(
          db.billItemSources.inventoryId,
          db.wholesalerInventory.id,
        ),
      );

  $$WholesalerInventoryTableProcessedTableManager? get inventoryId {
    final $_column = $_itemColumn<int>('inventory_id');
    if ($_column == null) return null;
    final manager = $$WholesalerInventoryTableTableManager(
      $_db,
      $_db.wholesalerInventory,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_inventoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ItemPurchaseSourcesTable _purchaseSourceIdTable(_$AppDatabase db) =>
      db.itemPurchaseSources.createAlias(
        $_aliasNameGenerator(
          db.billItemSources.purchaseSourceId,
          db.itemPurchaseSources.id,
        ),
      );

  $$ItemPurchaseSourcesTableProcessedTableManager? get purchaseSourceId {
    final $_column = $_itemColumn<int>('purchase_source_id');
    if ($_column == null) return null;
    final manager = $$ItemPurchaseSourcesTableTableManager(
      $_db,
      $_db.itemPurchaseSources,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_purchaseSourceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$BillItemSourcesTableFilterComposer
    extends Composer<_$AppDatabase, $BillItemSourcesTable> {
  $$BillItemSourcesTableFilterComposer({
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

  ColumnFilters<double> get quantityAllocated => $composableBuilder(
    column: $table.quantityAllocated,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get purchasePriceAtTime => $composableBuilder(
    column: $table.purchasePriceAtTime,
    builder: (column) => ColumnFilters(column),
  );

  $$RetailerBillItemsTableFilterComposer get billItemId {
    final $$RetailerBillItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.billItemId,
      referencedTable: $db.retailerBillItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RetailerBillItemsTableFilterComposer(
            $db: $db,
            $table: $db.retailerBillItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WholesalerInventoryTableFilterComposer get inventoryId {
    final $$WholesalerInventoryTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.inventoryId,
      referencedTable: $db.wholesalerInventory,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WholesalerInventoryTableFilterComposer(
            $db: $db,
            $table: $db.wholesalerInventory,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ItemPurchaseSourcesTableFilterComposer get purchaseSourceId {
    final $$ItemPurchaseSourcesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.purchaseSourceId,
      referencedTable: $db.itemPurchaseSources,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemPurchaseSourcesTableFilterComposer(
            $db: $db,
            $table: $db.itemPurchaseSources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BillItemSourcesTableOrderingComposer
    extends Composer<_$AppDatabase, $BillItemSourcesTable> {
  $$BillItemSourcesTableOrderingComposer({
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

  ColumnOrderings<double> get quantityAllocated => $composableBuilder(
    column: $table.quantityAllocated,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get purchasePriceAtTime => $composableBuilder(
    column: $table.purchasePriceAtTime,
    builder: (column) => ColumnOrderings(column),
  );

  $$RetailerBillItemsTableOrderingComposer get billItemId {
    final $$RetailerBillItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.billItemId,
      referencedTable: $db.retailerBillItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RetailerBillItemsTableOrderingComposer(
            $db: $db,
            $table: $db.retailerBillItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WholesalerInventoryTableOrderingComposer get inventoryId {
    final $$WholesalerInventoryTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.inventoryId,
          referencedTable: $db.wholesalerInventory,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$WholesalerInventoryTableOrderingComposer(
                $db: $db,
                $table: $db.wholesalerInventory,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$ItemPurchaseSourcesTableOrderingComposer get purchaseSourceId {
    final $$ItemPurchaseSourcesTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.purchaseSourceId,
          referencedTable: $db.itemPurchaseSources,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ItemPurchaseSourcesTableOrderingComposer(
                $db: $db,
                $table: $db.itemPurchaseSources,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$BillItemSourcesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BillItemSourcesTable> {
  $$BillItemSourcesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get quantityAllocated => $composableBuilder(
    column: $table.quantityAllocated,
    builder: (column) => column,
  );

  GeneratedColumn<double> get purchasePriceAtTime => $composableBuilder(
    column: $table.purchasePriceAtTime,
    builder: (column) => column,
  );

  $$RetailerBillItemsTableAnnotationComposer get billItemId {
    final $$RetailerBillItemsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.billItemId,
          referencedTable: $db.retailerBillItems,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$RetailerBillItemsTableAnnotationComposer(
                $db: $db,
                $table: $db.retailerBillItems,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$WholesalerInventoryTableAnnotationComposer get inventoryId {
    final $$WholesalerInventoryTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.inventoryId,
          referencedTable: $db.wholesalerInventory,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$WholesalerInventoryTableAnnotationComposer(
                $db: $db,
                $table: $db.wholesalerInventory,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$ItemPurchaseSourcesTableAnnotationComposer get purchaseSourceId {
    final $$ItemPurchaseSourcesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.purchaseSourceId,
          referencedTable: $db.itemPurchaseSources,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ItemPurchaseSourcesTableAnnotationComposer(
                $db: $db,
                $table: $db.itemPurchaseSources,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$BillItemSourcesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BillItemSourcesTable,
          BillItemSource,
          $$BillItemSourcesTableFilterComposer,
          $$BillItemSourcesTableOrderingComposer,
          $$BillItemSourcesTableAnnotationComposer,
          $$BillItemSourcesTableCreateCompanionBuilder,
          $$BillItemSourcesTableUpdateCompanionBuilder,
          (BillItemSource, $$BillItemSourcesTableReferences),
          BillItemSource,
          PrefetchHooks Function({
            bool billItemId,
            bool inventoryId,
            bool purchaseSourceId,
          })
        > {
  $$BillItemSourcesTableTableManager(
    _$AppDatabase db,
    $BillItemSourcesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BillItemSourcesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BillItemSourcesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BillItemSourcesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> billItemId = const Value.absent(),
                Value<int?> inventoryId = const Value.absent(),
                Value<int?> purchaseSourceId = const Value.absent(),
                Value<double> quantityAllocated = const Value.absent(),
                Value<double> purchasePriceAtTime = const Value.absent(),
              }) => BillItemSourcesCompanion(
                id: id,
                billItemId: billItemId,
                inventoryId: inventoryId,
                purchaseSourceId: purchaseSourceId,
                quantityAllocated: quantityAllocated,
                purchasePriceAtTime: purchasePriceAtTime,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int billItemId,
                Value<int?> inventoryId = const Value.absent(),
                Value<int?> purchaseSourceId = const Value.absent(),
                required double quantityAllocated,
                required double purchasePriceAtTime,
              }) => BillItemSourcesCompanion.insert(
                id: id,
                billItemId: billItemId,
                inventoryId: inventoryId,
                purchaseSourceId: purchaseSourceId,
                quantityAllocated: quantityAllocated,
                purchasePriceAtTime: purchasePriceAtTime,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BillItemSourcesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                billItemId = false,
                inventoryId = false,
                purchaseSourceId = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (billItemId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.billItemId,
                                    referencedTable:
                                        $$BillItemSourcesTableReferences
                                            ._billItemIdTable(db),
                                    referencedColumn:
                                        $$BillItemSourcesTableReferences
                                            ._billItemIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (inventoryId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.inventoryId,
                                    referencedTable:
                                        $$BillItemSourcesTableReferences
                                            ._inventoryIdTable(db),
                                    referencedColumn:
                                        $$BillItemSourcesTableReferences
                                            ._inventoryIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (purchaseSourceId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.purchaseSourceId,
                                    referencedTable:
                                        $$BillItemSourcesTableReferences
                                            ._purchaseSourceIdTable(db),
                                    referencedColumn:
                                        $$BillItemSourcesTableReferences
                                            ._purchaseSourceIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$BillItemSourcesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BillItemSourcesTable,
      BillItemSource,
      $$BillItemSourcesTableFilterComposer,
      $$BillItemSourcesTableOrderingComposer,
      $$BillItemSourcesTableAnnotationComposer,
      $$BillItemSourcesTableCreateCompanionBuilder,
      $$BillItemSourcesTableUpdateCompanionBuilder,
      (BillItemSource, $$BillItemSourcesTableReferences),
      BillItemSource,
      PrefetchHooks Function({
        bool billItemId,
        bool inventoryId,
        bool purchaseSourceId,
      })
    >;
typedef $$LedgersTableCreateCompanionBuilder =
    LedgersCompanion Function({
      Value<int> id,
      required String ledgerType,
      required String partyType,
      required int partyId,
      required double totalAmount,
      Value<double> amountPaid,
      Value<double> remainingAmount,
      Value<double> interest,
      Value<String?> paymentMode,
      Value<bool> isFullyPaid,
      Value<DateTime> date,
      Value<DateTime> createdAt,
    });
typedef $$LedgersTableUpdateCompanionBuilder =
    LedgersCompanion Function({
      Value<int> id,
      Value<String> ledgerType,
      Value<String> partyType,
      Value<int> partyId,
      Value<double> totalAmount,
      Value<double> amountPaid,
      Value<double> remainingAmount,
      Value<double> interest,
      Value<String?> paymentMode,
      Value<bool> isFullyPaid,
      Value<DateTime> date,
      Value<DateTime> createdAt,
    });

final class $$LedgersTableReferences
    extends BaseReferences<_$AppDatabase, $LedgersTable, Ledger> {
  $$LedgersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PaymentsTable, List<Payment>> _paymentsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.payments,
    aliasName: $_aliasNameGenerator(db.ledgers.id, db.payments.ledgerId),
  );

  $$PaymentsTableProcessedTableManager get paymentsRefs {
    final manager = $$PaymentsTableTableManager(
      $_db,
      $_db.payments,
    ).filter((f) => f.ledgerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_paymentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LedgersTableFilterComposer
    extends Composer<_$AppDatabase, $LedgersTable> {
  $$LedgersTableFilterComposer({
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

  ColumnFilters<String> get ledgerType => $composableBuilder(
    column: $table.ledgerType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get partyType => $composableBuilder(
    column: $table.partyType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get partyId => $composableBuilder(
    column: $table.partyId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amountPaid => $composableBuilder(
    column: $table.amountPaid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get remainingAmount => $composableBuilder(
    column: $table.remainingAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get interest => $composableBuilder(
    column: $table.interest,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMode => $composableBuilder(
    column: $table.paymentMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFullyPaid => $composableBuilder(
    column: $table.isFullyPaid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> paymentsRefs(
    Expression<bool> Function($$PaymentsTableFilterComposer f) f,
  ) {
    final $$PaymentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.payments,
      getReferencedColumn: (t) => t.ledgerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableFilterComposer(
            $db: $db,
            $table: $db.payments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LedgersTableOrderingComposer
    extends Composer<_$AppDatabase, $LedgersTable> {
  $$LedgersTableOrderingComposer({
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

  ColumnOrderings<String> get ledgerType => $composableBuilder(
    column: $table.ledgerType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get partyType => $composableBuilder(
    column: $table.partyType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get partyId => $composableBuilder(
    column: $table.partyId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amountPaid => $composableBuilder(
    column: $table.amountPaid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get remainingAmount => $composableBuilder(
    column: $table.remainingAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get interest => $composableBuilder(
    column: $table.interest,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMode => $composableBuilder(
    column: $table.paymentMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFullyPaid => $composableBuilder(
    column: $table.isFullyPaid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LedgersTableAnnotationComposer
    extends Composer<_$AppDatabase, $LedgersTable> {
  $$LedgersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get ledgerType => $composableBuilder(
    column: $table.ledgerType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get partyType =>
      $composableBuilder(column: $table.partyType, builder: (column) => column);

  GeneratedColumn<int> get partyId =>
      $composableBuilder(column: $table.partyId, builder: (column) => column);

  GeneratedColumn<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get amountPaid => $composableBuilder(
    column: $table.amountPaid,
    builder: (column) => column,
  );

  GeneratedColumn<double> get remainingAmount => $composableBuilder(
    column: $table.remainingAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get interest =>
      $composableBuilder(column: $table.interest, builder: (column) => column);

  GeneratedColumn<String> get paymentMode => $composableBuilder(
    column: $table.paymentMode,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isFullyPaid => $composableBuilder(
    column: $table.isFullyPaid,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> paymentsRefs<T extends Object>(
    Expression<T> Function($$PaymentsTableAnnotationComposer a) f,
  ) {
    final $$PaymentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.payments,
      getReferencedColumn: (t) => t.ledgerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableAnnotationComposer(
            $db: $db,
            $table: $db.payments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LedgersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LedgersTable,
          Ledger,
          $$LedgersTableFilterComposer,
          $$LedgersTableOrderingComposer,
          $$LedgersTableAnnotationComposer,
          $$LedgersTableCreateCompanionBuilder,
          $$LedgersTableUpdateCompanionBuilder,
          (Ledger, $$LedgersTableReferences),
          Ledger,
          PrefetchHooks Function({bool paymentsRefs})
        > {
  $$LedgersTableTableManager(_$AppDatabase db, $LedgersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LedgersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LedgersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LedgersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> ledgerType = const Value.absent(),
                Value<String> partyType = const Value.absent(),
                Value<int> partyId = const Value.absent(),
                Value<double> totalAmount = const Value.absent(),
                Value<double> amountPaid = const Value.absent(),
                Value<double> remainingAmount = const Value.absent(),
                Value<double> interest = const Value.absent(),
                Value<String?> paymentMode = const Value.absent(),
                Value<bool> isFullyPaid = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => LedgersCompanion(
                id: id,
                ledgerType: ledgerType,
                partyType: partyType,
                partyId: partyId,
                totalAmount: totalAmount,
                amountPaid: amountPaid,
                remainingAmount: remainingAmount,
                interest: interest,
                paymentMode: paymentMode,
                isFullyPaid: isFullyPaid,
                date: date,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String ledgerType,
                required String partyType,
                required int partyId,
                required double totalAmount,
                Value<double> amountPaid = const Value.absent(),
                Value<double> remainingAmount = const Value.absent(),
                Value<double> interest = const Value.absent(),
                Value<String?> paymentMode = const Value.absent(),
                Value<bool> isFullyPaid = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => LedgersCompanion.insert(
                id: id,
                ledgerType: ledgerType,
                partyType: partyType,
                partyId: partyId,
                totalAmount: totalAmount,
                amountPaid: amountPaid,
                remainingAmount: remainingAmount,
                interest: interest,
                paymentMode: paymentMode,
                isFullyPaid: isFullyPaid,
                date: date,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LedgersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({paymentsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (paymentsRefs) db.payments],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (paymentsRefs)
                    await $_getPrefetchedData<Ledger, $LedgersTable, Payment>(
                      currentTable: table,
                      referencedTable: $$LedgersTableReferences
                          ._paymentsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$LedgersTableReferences(db, table, p0).paymentsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.ledgerId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$LedgersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LedgersTable,
      Ledger,
      $$LedgersTableFilterComposer,
      $$LedgersTableOrderingComposer,
      $$LedgersTableAnnotationComposer,
      $$LedgersTableCreateCompanionBuilder,
      $$LedgersTableUpdateCompanionBuilder,
      (Ledger, $$LedgersTableReferences),
      Ledger,
      PrefetchHooks Function({bool paymentsRefs})
    >;
typedef $$PaymentsTableCreateCompanionBuilder =
    PaymentsCompanion Function({
      Value<int> id,
      required int ledgerId,
      required double amount,
      required String paymentMode,
      Value<DateTime> date,
      Value<String?> note,
      Value<bool> isFullPayment,
    });
typedef $$PaymentsTableUpdateCompanionBuilder =
    PaymentsCompanion Function({
      Value<int> id,
      Value<int> ledgerId,
      Value<double> amount,
      Value<String> paymentMode,
      Value<DateTime> date,
      Value<String?> note,
      Value<bool> isFullPayment,
    });

final class $$PaymentsTableReferences
    extends BaseReferences<_$AppDatabase, $PaymentsTable, Payment> {
  $$PaymentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LedgersTable _ledgerIdTable(_$AppDatabase db) => db.ledgers
      .createAlias($_aliasNameGenerator(db.payments.ledgerId, db.ledgers.id));

  $$LedgersTableProcessedTableManager get ledgerId {
    final $_column = $_itemColumn<int>('ledger_id')!;

    final manager = $$LedgersTableTableManager(
      $_db,
      $_db.ledgers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ledgerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PaymentsTableFilterComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableFilterComposer({
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

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMode => $composableBuilder(
    column: $table.paymentMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFullPayment => $composableBuilder(
    column: $table.isFullPayment,
    builder: (column) => ColumnFilters(column),
  );

  $$LedgersTableFilterComposer get ledgerId {
    final $$LedgersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ledgerId,
      referencedTable: $db.ledgers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LedgersTableFilterComposer(
            $db: $db,
            $table: $db.ledgers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentsTableOrderingComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableOrderingComposer({
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

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMode => $composableBuilder(
    column: $table.paymentMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFullPayment => $composableBuilder(
    column: $table.isFullPayment,
    builder: (column) => ColumnOrderings(column),
  );

  $$LedgersTableOrderingComposer get ledgerId {
    final $$LedgersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ledgerId,
      referencedTable: $db.ledgers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LedgersTableOrderingComposer(
            $db: $db,
            $table: $db.ledgers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get paymentMode => $composableBuilder(
    column: $table.paymentMode,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<bool> get isFullPayment => $composableBuilder(
    column: $table.isFullPayment,
    builder: (column) => column,
  );

  $$LedgersTableAnnotationComposer get ledgerId {
    final $$LedgersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ledgerId,
      referencedTable: $db.ledgers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LedgersTableAnnotationComposer(
            $db: $db,
            $table: $db.ledgers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PaymentsTable,
          Payment,
          $$PaymentsTableFilterComposer,
          $$PaymentsTableOrderingComposer,
          $$PaymentsTableAnnotationComposer,
          $$PaymentsTableCreateCompanionBuilder,
          $$PaymentsTableUpdateCompanionBuilder,
          (Payment, $$PaymentsTableReferences),
          Payment,
          PrefetchHooks Function({bool ledgerId})
        > {
  $$PaymentsTableTableManager(_$AppDatabase db, $PaymentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaymentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaymentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaymentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> ledgerId = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> paymentMode = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<bool> isFullPayment = const Value.absent(),
              }) => PaymentsCompanion(
                id: id,
                ledgerId: ledgerId,
                amount: amount,
                paymentMode: paymentMode,
                date: date,
                note: note,
                isFullPayment: isFullPayment,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int ledgerId,
                required double amount,
                required String paymentMode,
                Value<DateTime> date = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<bool> isFullPayment = const Value.absent(),
              }) => PaymentsCompanion.insert(
                id: id,
                ledgerId: ledgerId,
                amount: amount,
                paymentMode: paymentMode,
                date: date,
                note: note,
                isFullPayment: isFullPayment,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PaymentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({ledgerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (ledgerId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.ledgerId,
                                referencedTable: $$PaymentsTableReferences
                                    ._ledgerIdTable(db),
                                referencedColumn: $$PaymentsTableReferences
                                    ._ledgerIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PaymentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PaymentsTable,
      Payment,
      $$PaymentsTableFilterComposer,
      $$PaymentsTableOrderingComposer,
      $$PaymentsTableAnnotationComposer,
      $$PaymentsTableCreateCompanionBuilder,
      $$PaymentsTableUpdateCompanionBuilder,
      (Payment, $$PaymentsTableReferences),
      Payment,
      PrefetchHooks Function({bool ledgerId})
    >;
typedef $$InventoryTransactionsTableCreateCompanionBuilder =
    InventoryTransactionsCompanion Function({
      Value<int> id,
      required int itemId,
      Value<int?> wholesalerId,
      Value<int?> retailerId,
      required String type,
      required double quantity,
      Value<String?> referenceId,
      Value<DateTime> date,
    });
typedef $$InventoryTransactionsTableUpdateCompanionBuilder =
    InventoryTransactionsCompanion Function({
      Value<int> id,
      Value<int> itemId,
      Value<int?> wholesalerId,
      Value<int?> retailerId,
      Value<String> type,
      Value<double> quantity,
      Value<String?> referenceId,
      Value<DateTime> date,
    });

final class $$InventoryTransactionsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $InventoryTransactionsTable,
          InventoryTransaction
        > {
  $$InventoryTransactionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ItemsTable _itemIdTable(_$AppDatabase db) => db.items.createAlias(
    $_aliasNameGenerator(db.inventoryTransactions.itemId, db.items.id),
  );

  $$ItemsTableProcessedTableManager get itemId {
    final $_column = $_itemColumn<int>('item_id')!;

    final manager = $$ItemsTableTableManager(
      $_db,
      $_db.items,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_itemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $WholesalersTable _wholesalerIdTable(_$AppDatabase db) =>
      db.wholesalers.createAlias(
        $_aliasNameGenerator(
          db.inventoryTransactions.wholesalerId,
          db.wholesalers.id,
        ),
      );

  $$WholesalersTableProcessedTableManager? get wholesalerId {
    final $_column = $_itemColumn<int>('wholesaler_id');
    if ($_column == null) return null;
    final manager = $$WholesalersTableTableManager(
      $_db,
      $_db.wholesalers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_wholesalerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $RetailersTable _retailerIdTable(_$AppDatabase db) =>
      db.retailers.createAlias(
        $_aliasNameGenerator(
          db.inventoryTransactions.retailerId,
          db.retailers.id,
        ),
      );

  $$RetailersTableProcessedTableManager? get retailerId {
    final $_column = $_itemColumn<int>('retailer_id');
    if ($_column == null) return null;
    final manager = $$RetailersTableTableManager(
      $_db,
      $_db.retailers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_retailerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$InventoryTransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $InventoryTransactionsTable> {
  $$InventoryTransactionsTableFilterComposer({
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

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get referenceId => $composableBuilder(
    column: $table.referenceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  $$ItemsTableFilterComposer get itemId {
    final $$ItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableFilterComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WholesalersTableFilterComposer get wholesalerId {
    final $$WholesalersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wholesalerId,
      referencedTable: $db.wholesalers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WholesalersTableFilterComposer(
            $db: $db,
            $table: $db.wholesalers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RetailersTableFilterComposer get retailerId {
    final $$RetailersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.retailerId,
      referencedTable: $db.retailers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RetailersTableFilterComposer(
            $db: $db,
            $table: $db.retailers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InventoryTransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $InventoryTransactionsTable> {
  $$InventoryTransactionsTableOrderingComposer({
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

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get referenceId => $composableBuilder(
    column: $table.referenceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  $$ItemsTableOrderingComposer get itemId {
    final $$ItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableOrderingComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WholesalersTableOrderingComposer get wholesalerId {
    final $$WholesalersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wholesalerId,
      referencedTable: $db.wholesalers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WholesalersTableOrderingComposer(
            $db: $db,
            $table: $db.wholesalers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RetailersTableOrderingComposer get retailerId {
    final $$RetailersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.retailerId,
      referencedTable: $db.retailers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RetailersTableOrderingComposer(
            $db: $db,
            $table: $db.retailers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InventoryTransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InventoryTransactionsTable> {
  $$InventoryTransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<double> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<String> get referenceId => $composableBuilder(
    column: $table.referenceId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  $$ItemsTableAnnotationComposer get itemId {
    final $$ItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WholesalersTableAnnotationComposer get wholesalerId {
    final $$WholesalersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wholesalerId,
      referencedTable: $db.wholesalers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WholesalersTableAnnotationComposer(
            $db: $db,
            $table: $db.wholesalers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RetailersTableAnnotationComposer get retailerId {
    final $$RetailersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.retailerId,
      referencedTable: $db.retailers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RetailersTableAnnotationComposer(
            $db: $db,
            $table: $db.retailers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InventoryTransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InventoryTransactionsTable,
          InventoryTransaction,
          $$InventoryTransactionsTableFilterComposer,
          $$InventoryTransactionsTableOrderingComposer,
          $$InventoryTransactionsTableAnnotationComposer,
          $$InventoryTransactionsTableCreateCompanionBuilder,
          $$InventoryTransactionsTableUpdateCompanionBuilder,
          (InventoryTransaction, $$InventoryTransactionsTableReferences),
          InventoryTransaction,
          PrefetchHooks Function({
            bool itemId,
            bool wholesalerId,
            bool retailerId,
          })
        > {
  $$InventoryTransactionsTableTableManager(
    _$AppDatabase db,
    $InventoryTransactionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InventoryTransactionsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$InventoryTransactionsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$InventoryTransactionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> itemId = const Value.absent(),
                Value<int?> wholesalerId = const Value.absent(),
                Value<int?> retailerId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<double> quantity = const Value.absent(),
                Value<String?> referenceId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
              }) => InventoryTransactionsCompanion(
                id: id,
                itemId: itemId,
                wholesalerId: wholesalerId,
                retailerId: retailerId,
                type: type,
                quantity: quantity,
                referenceId: referenceId,
                date: date,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int itemId,
                Value<int?> wholesalerId = const Value.absent(),
                Value<int?> retailerId = const Value.absent(),
                required String type,
                required double quantity,
                Value<String?> referenceId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
              }) => InventoryTransactionsCompanion.insert(
                id: id,
                itemId: itemId,
                wholesalerId: wholesalerId,
                retailerId: retailerId,
                type: type,
                quantity: quantity,
                referenceId: referenceId,
                date: date,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$InventoryTransactionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({itemId = false, wholesalerId = false, retailerId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (itemId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.itemId,
                                    referencedTable:
                                        $$InventoryTransactionsTableReferences
                                            ._itemIdTable(db),
                                    referencedColumn:
                                        $$InventoryTransactionsTableReferences
                                            ._itemIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (wholesalerId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.wholesalerId,
                                    referencedTable:
                                        $$InventoryTransactionsTableReferences
                                            ._wholesalerIdTable(db),
                                    referencedColumn:
                                        $$InventoryTransactionsTableReferences
                                            ._wholesalerIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (retailerId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.retailerId,
                                    referencedTable:
                                        $$InventoryTransactionsTableReferences
                                            ._retailerIdTable(db),
                                    referencedColumn:
                                        $$InventoryTransactionsTableReferences
                                            ._retailerIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$InventoryTransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InventoryTransactionsTable,
      InventoryTransaction,
      $$InventoryTransactionsTableFilterComposer,
      $$InventoryTransactionsTableOrderingComposer,
      $$InventoryTransactionsTableAnnotationComposer,
      $$InventoryTransactionsTableCreateCompanionBuilder,
      $$InventoryTransactionsTableUpdateCompanionBuilder,
      (InventoryTransaction, $$InventoryTransactionsTableReferences),
      InventoryTransaction,
      PrefetchHooks Function({bool itemId, bool wholesalerId, bool retailerId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ItemsTableTableManager get items =>
      $$ItemsTableTableManager(_db, _db.items);
  $$WholesalersTableTableManager get wholesalers =>
      $$WholesalersTableTableManager(_db, _db.wholesalers);
  $$RetailersTableTableManager get retailers =>
      $$RetailersTableTableManager(_db, _db.retailers);
  $$WholesalerInventoryTableTableManager get wholesalerInventory =>
      $$WholesalerInventoryTableTableManager(_db, _db.wholesalerInventory);
  $$RetailerBillsTableTableManager get retailerBills =>
      $$RetailerBillsTableTableManager(_db, _db.retailerBills);
  $$RetailerBillItemsTableTableManager get retailerBillItems =>
      $$RetailerBillItemsTableTableManager(_db, _db.retailerBillItems);
  $$ItemPurchaseSourcesTableTableManager get itemPurchaseSources =>
      $$ItemPurchaseSourcesTableTableManager(_db, _db.itemPurchaseSources);
  $$BillItemSourcesTableTableManager get billItemSources =>
      $$BillItemSourcesTableTableManager(_db, _db.billItemSources);
  $$LedgersTableTableManager get ledgers =>
      $$LedgersTableTableManager(_db, _db.ledgers);
  $$PaymentsTableTableManager get payments =>
      $$PaymentsTableTableManager(_db, _db.payments);
  $$InventoryTransactionsTableTableManager get inventoryTransactions =>
      $$InventoryTransactionsTableTableManager(_db, _db.inventoryTransactions);
}
