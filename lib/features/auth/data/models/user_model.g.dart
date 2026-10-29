// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUserModelCollection on Isar {
  IsarCollection<UserModel> get userModels => this.collection();
}

const UserModelSchema = CollectionSchema(
  name: r'UserModel',
  id: 7195426469378571114,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'email': PropertySchema(
      id: 1,
      name: r'email',
      type: IsarType.string,
    ),
    r'isProfileCompleted': PropertySchema(
      id: 2,
      name: r'isProfileCompleted',
      type: IsarType.bool,
    ),
    r'passwordHash': PropertySchema(
      id: 3,
      name: r'passwordHash',
      type: IsarType.string,
    ),
    r'phone': PropertySchema(
      id: 4,
      name: r'phone',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 5,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _userModelEstimateSize,
  serialize: _userModelSerialize,
  deserialize: _userModelDeserialize,
  deserializeProp: _userModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'email': IndexSchema(
      id: -26095440403582047,
      name: r'email',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'email',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'phone': IndexSchema(
      id: -6308098324157559207,
      name: r'phone',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'phone',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _userModelGetId,
  getLinks: _userModelGetLinks,
  attach: _userModelAttach,
  version: '3.1.0+1',
);

int _userModelEstimateSize(
  UserModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.email;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.passwordHash;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.phone;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _userModelSerialize(
  UserModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeString(offsets[1], object.email);
  writer.writeBool(offsets[2], object.isProfileCompleted);
  writer.writeString(offsets[3], object.passwordHash);
  writer.writeString(offsets[4], object.phone);
  writer.writeDateTime(offsets[5], object.updatedAt);
}

UserModel _userModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserModel();
  object.createdAt = reader.readDateTime(offsets[0]);
  object.email = reader.readStringOrNull(offsets[1]);
  object.id = id;
  object.isProfileCompleted = reader.readBool(offsets[2]);
  object.passwordHash = reader.readStringOrNull(offsets[3]);
  object.phone = reader.readStringOrNull(offsets[4]);
  object.updatedAt = reader.readDateTime(offsets[5]);
  return object;
}

P _userModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _userModelGetId(UserModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _userModelGetLinks(UserModel object) {
  return [];
}

void _userModelAttach(IsarCollection<dynamic> col, Id id, UserModel object) {
  object.id = id;
}

extension UserModelByIndex on IsarCollection<UserModel> {
  Future<UserModel?> getByEmail(String? email) {
    return getByIndex(r'email', [email]);
  }

  UserModel? getByEmailSync(String? email) {
    return getByIndexSync(r'email', [email]);
  }

  Future<bool> deleteByEmail(String? email) {
    return deleteByIndex(r'email', [email]);
  }

  bool deleteByEmailSync(String? email) {
    return deleteByIndexSync(r'email', [email]);
  }

  Future<List<UserModel?>> getAllByEmail(List<String?> emailValues) {
    final values = emailValues.map((e) => [e]).toList();
    return getAllByIndex(r'email', values);
  }

  List<UserModel?> getAllByEmailSync(List<String?> emailValues) {
    final values = emailValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'email', values);
  }

  Future<int> deleteAllByEmail(List<String?> emailValues) {
    final values = emailValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'email', values);
  }

  int deleteAllByEmailSync(List<String?> emailValues) {
    final values = emailValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'email', values);
  }

  Future<Id> putByEmail(UserModel object) {
    return putByIndex(r'email', object);
  }

  Id putByEmailSync(UserModel object, {bool saveLinks = true}) {
    return putByIndexSync(r'email', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByEmail(List<UserModel> objects) {
    return putAllByIndex(r'email', objects);
  }

  List<Id> putAllByEmailSync(List<UserModel> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'email', objects, saveLinks: saveLinks);
  }

  Future<UserModel?> getByPhone(String? phone) {
    return getByIndex(r'phone', [phone]);
  }

  UserModel? getByPhoneSync(String? phone) {
    return getByIndexSync(r'phone', [phone]);
  }

  Future<bool> deleteByPhone(String? phone) {
    return deleteByIndex(r'phone', [phone]);
  }

  bool deleteByPhoneSync(String? phone) {
    return deleteByIndexSync(r'phone', [phone]);
  }

  Future<List<UserModel?>> getAllByPhone(List<String?> phoneValues) {
    final values = phoneValues.map((e) => [e]).toList();
    return getAllByIndex(r'phone', values);
  }

  List<UserModel?> getAllByPhoneSync(List<String?> phoneValues) {
    final values = phoneValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'phone', values);
  }

  Future<int> deleteAllByPhone(List<String?> phoneValues) {
    final values = phoneValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'phone', values);
  }

  int deleteAllByPhoneSync(List<String?> phoneValues) {
    final values = phoneValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'phone', values);
  }

  Future<Id> putByPhone(UserModel object) {
    return putByIndex(r'phone', object);
  }

  Id putByPhoneSync(UserModel object, {bool saveLinks = true}) {
    return putByIndexSync(r'phone', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByPhone(List<UserModel> objects) {
    return putAllByIndex(r'phone', objects);
  }

  List<Id> putAllByPhoneSync(List<UserModel> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'phone', objects, saveLinks: saveLinks);
  }
}

extension UserModelQueryWhereSort
    on QueryBuilder<UserModel, UserModel, QWhere> {
  QueryBuilder<UserModel, UserModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension UserModelQueryWhere
    on QueryBuilder<UserModel, UserModel, QWhereClause> {
  QueryBuilder<UserModel, UserModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterWhereClause> emailIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'email',
        value: [null],
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterWhereClause> emailIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'email',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterWhereClause> emailEqualTo(
      String? email) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'email',
        value: [email],
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterWhereClause> emailNotEqualTo(
      String? email) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'email',
              lower: [],
              upper: [email],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'email',
              lower: [email],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'email',
              lower: [email],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'email',
              lower: [],
              upper: [email],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterWhereClause> phoneIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'phone',
        value: [null],
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterWhereClause> phoneIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'phone',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterWhereClause> phoneEqualTo(
      String? phone) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'phone',
        value: [phone],
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterWhereClause> phoneNotEqualTo(
      String? phone) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'phone',
              lower: [],
              upper: [phone],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'phone',
              lower: [phone],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'phone',
              lower: [phone],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'phone',
              lower: [],
              upper: [phone],
              includeUpper: false,
            ));
      }
    });
  }
}

extension UserModelQueryFilter
    on QueryBuilder<UserModel, UserModel, QFilterCondition> {
  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> createdAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> emailIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'email',
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> emailIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'email',
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> emailEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> emailGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> emailLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> emailBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'email',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> emailStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> emailEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> emailContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> emailMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'email',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> emailIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'email',
        value: '',
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> emailIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'email',
        value: '',
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      isProfileCompletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isProfileCompleted',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      passwordHashIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'passwordHash',
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      passwordHashIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'passwordHash',
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> passwordHashEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'passwordHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      passwordHashGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'passwordHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      passwordHashLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'passwordHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> passwordHashBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'passwordHash',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      passwordHashStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'passwordHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      passwordHashEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'passwordHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      passwordHashContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'passwordHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> passwordHashMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'passwordHash',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      passwordHashIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'passwordHash',
        value: '',
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      passwordHashIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'passwordHash',
        value: '',
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> phoneIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'phone',
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> phoneIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'phone',
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> phoneEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'phone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> phoneGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'phone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> phoneLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'phone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> phoneBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'phone',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> phoneStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'phone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> phoneEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'phone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> phoneContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'phone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> phoneMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'phone',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> phoneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'phone',
        value: '',
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> phoneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'phone',
        value: '',
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> updatedAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      updatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension UserModelQueryObject
    on QueryBuilder<UserModel, UserModel, QFilterCondition> {}

extension UserModelQueryLinks
    on QueryBuilder<UserModel, UserModel, QFilterCondition> {}

extension UserModelQuerySortBy on QueryBuilder<UserModel, UserModel, QSortBy> {
  QueryBuilder<UserModel, UserModel, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> sortByEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> sortByEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> sortByIsProfileCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isProfileCompleted', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy>
      sortByIsProfileCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isProfileCompleted', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> sortByPasswordHash() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'passwordHash', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> sortByPasswordHashDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'passwordHash', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> sortByPhone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phone', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> sortByPhoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phone', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension UserModelQuerySortThenBy
    on QueryBuilder<UserModel, UserModel, QSortThenBy> {
  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByIsProfileCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isProfileCompleted', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy>
      thenByIsProfileCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isProfileCompleted', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByPasswordHash() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'passwordHash', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByPasswordHashDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'passwordHash', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByPhone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phone', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByPhoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phone', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension UserModelQueryWhereDistinct
    on QueryBuilder<UserModel, UserModel, QDistinct> {
  QueryBuilder<UserModel, UserModel, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<UserModel, UserModel, QDistinct> distinctByEmail(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'email', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserModel, UserModel, QDistinct> distinctByIsProfileCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isProfileCompleted');
    });
  }

  QueryBuilder<UserModel, UserModel, QDistinct> distinctByPasswordHash(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'passwordHash', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserModel, UserModel, QDistinct> distinctByPhone(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'phone', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserModel, UserModel, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension UserModelQueryProperty
    on QueryBuilder<UserModel, UserModel, QQueryProperty> {
  QueryBuilder<UserModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<UserModel, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<UserModel, String?, QQueryOperations> emailProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'email');
    });
  }

  QueryBuilder<UserModel, bool, QQueryOperations> isProfileCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isProfileCompleted');
    });
  }

  QueryBuilder<UserModel, String?, QQueryOperations> passwordHashProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'passwordHash');
    });
  }

  QueryBuilder<UserModel, String?, QQueryOperations> phoneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'phone');
    });
  }

  QueryBuilder<UserModel, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
