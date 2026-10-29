// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetProfileModelCollection on Isar {
  IsarCollection<ProfileModel> get profileModels => this.collection();
}

const ProfileModelSchema = CollectionSchema(
  name: r'ProfileModel',
  id: 7663001939508120177,
  properties: {
    r'allergies': PropertySchema(
      id: 0,
      name: r'allergies',
      type: IsarType.string,
    ),
    r'availableTrainingDays': PropertySchema(
      id: 1,
      name: r'availableTrainingDays',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 2,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'currentWeeklyMileage': PropertySchema(
      id: 3,
      name: r'currentWeeklyMileage',
      type: IsarType.double,
    ),
    r'dietaryPreferences': PropertySchema(
      id: 4,
      name: r'dietaryPreferences',
      type: IsarType.string,
    ),
    r'injuryHistory': PropertySchema(
      id: 5,
      name: r'injuryHistory',
      type: IsarType.string,
    ),
    r'targetRaceTime': PropertySchema(
      id: 6,
      name: r'targetRaceTime',
      type: IsarType.string,
    ),
    r'targetRaceType': PropertySchema(
      id: 7,
      name: r'targetRaceType',
      type: IsarType.string,
    ),
    r'trainingGoal': PropertySchema(
      id: 8,
      name: r'trainingGoal',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 9,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'userId': PropertySchema(
      id: 10,
      name: r'userId',
      type: IsarType.long,
    )
  },
  estimateSize: _profileModelEstimateSize,
  serialize: _profileModelSerialize,
  deserialize: _profileModelDeserialize,
  deserializeProp: _profileModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'userId': IndexSchema(
      id: -2005826577402374815,
      name: r'userId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'userId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _profileModelGetId,
  getLinks: _profileModelGetLinks,
  attach: _profileModelAttach,
  version: '3.1.0+1',
);

int _profileModelEstimateSize(
  ProfileModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.allergies;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.availableTrainingDays;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.dietaryPreferences;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.injuryHistory;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.targetRaceTime;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.targetRaceType;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.trainingGoal;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _profileModelSerialize(
  ProfileModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.allergies);
  writer.writeString(offsets[1], object.availableTrainingDays);
  writer.writeDateTime(offsets[2], object.createdAt);
  writer.writeDouble(offsets[3], object.currentWeeklyMileage);
  writer.writeString(offsets[4], object.dietaryPreferences);
  writer.writeString(offsets[5], object.injuryHistory);
  writer.writeString(offsets[6], object.targetRaceTime);
  writer.writeString(offsets[7], object.targetRaceType);
  writer.writeString(offsets[8], object.trainingGoal);
  writer.writeDateTime(offsets[9], object.updatedAt);
  writer.writeLong(offsets[10], object.userId);
}

ProfileModel _profileModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ProfileModel();
  object.allergies = reader.readStringOrNull(offsets[0]);
  object.availableTrainingDays = reader.readStringOrNull(offsets[1]);
  object.createdAt = reader.readDateTime(offsets[2]);
  object.currentWeeklyMileage = reader.readDoubleOrNull(offsets[3]);
  object.dietaryPreferences = reader.readStringOrNull(offsets[4]);
  object.id = id;
  object.injuryHistory = reader.readStringOrNull(offsets[5]);
  object.targetRaceTime = reader.readStringOrNull(offsets[6]);
  object.targetRaceType = reader.readStringOrNull(offsets[7]);
  object.trainingGoal = reader.readStringOrNull(offsets[8]);
  object.updatedAt = reader.readDateTime(offsets[9]);
  object.userId = reader.readLong(offsets[10]);
  return object;
}

P _profileModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readDoubleOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readDateTime(offset)) as P;
    case 10:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _profileModelGetId(ProfileModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _profileModelGetLinks(ProfileModel object) {
  return [];
}

void _profileModelAttach(
    IsarCollection<dynamic> col, Id id, ProfileModel object) {
  object.id = id;
}

extension ProfileModelByIndex on IsarCollection<ProfileModel> {
  Future<ProfileModel?> getByUserId(int userId) {
    return getByIndex(r'userId', [userId]);
  }

  ProfileModel? getByUserIdSync(int userId) {
    return getByIndexSync(r'userId', [userId]);
  }

  Future<bool> deleteByUserId(int userId) {
    return deleteByIndex(r'userId', [userId]);
  }

  bool deleteByUserIdSync(int userId) {
    return deleteByIndexSync(r'userId', [userId]);
  }

  Future<List<ProfileModel?>> getAllByUserId(List<int> userIdValues) {
    final values = userIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'userId', values);
  }

  List<ProfileModel?> getAllByUserIdSync(List<int> userIdValues) {
    final values = userIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'userId', values);
  }

  Future<int> deleteAllByUserId(List<int> userIdValues) {
    final values = userIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'userId', values);
  }

  int deleteAllByUserIdSync(List<int> userIdValues) {
    final values = userIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'userId', values);
  }

  Future<Id> putByUserId(ProfileModel object) {
    return putByIndex(r'userId', object);
  }

  Id putByUserIdSync(ProfileModel object, {bool saveLinks = true}) {
    return putByIndexSync(r'userId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUserId(List<ProfileModel> objects) {
    return putAllByIndex(r'userId', objects);
  }

  List<Id> putAllByUserIdSync(List<ProfileModel> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'userId', objects, saveLinks: saveLinks);
  }
}

extension ProfileModelQueryWhereSort
    on QueryBuilder<ProfileModel, ProfileModel, QWhere> {
  QueryBuilder<ProfileModel, ProfileModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterWhere> anyUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'userId'),
      );
    });
  }
}

extension ProfileModelQueryWhere
    on QueryBuilder<ProfileModel, ProfileModel, QWhereClause> {
  QueryBuilder<ProfileModel, ProfileModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<ProfileModel, ProfileModel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterWhereClause> idBetween(
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

  QueryBuilder<ProfileModel, ProfileModel, QAfterWhereClause> userIdEqualTo(
      int userId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'userId',
        value: [userId],
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterWhereClause> userIdNotEqualTo(
      int userId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [],
              upper: [userId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [userId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [userId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [],
              upper: [userId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterWhereClause> userIdGreaterThan(
    int userId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'userId',
        lower: [userId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterWhereClause> userIdLessThan(
    int userId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'userId',
        lower: [],
        upper: [userId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterWhereClause> userIdBetween(
    int lowerUserId,
    int upperUserId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'userId',
        lower: [lowerUserId],
        includeLower: includeLower,
        upper: [upperUserId],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ProfileModelQueryFilter
    on QueryBuilder<ProfileModel, ProfileModel, QFilterCondition> {
  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      allergiesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'allergies',
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      allergiesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'allergies',
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      allergiesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'allergies',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      allergiesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'allergies',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      allergiesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'allergies',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      allergiesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'allergies',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      allergiesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'allergies',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      allergiesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'allergies',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      allergiesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'allergies',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      allergiesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'allergies',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      allergiesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'allergies',
        value: '',
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      allergiesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'allergies',
        value: '',
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      availableTrainingDaysIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'availableTrainingDays',
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      availableTrainingDaysIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'availableTrainingDays',
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      availableTrainingDaysEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'availableTrainingDays',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      availableTrainingDaysGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'availableTrainingDays',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      availableTrainingDaysLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'availableTrainingDays',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      availableTrainingDaysBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'availableTrainingDays',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      availableTrainingDaysStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'availableTrainingDays',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      availableTrainingDaysEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'availableTrainingDays',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      availableTrainingDaysContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'availableTrainingDays',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      availableTrainingDaysMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'availableTrainingDays',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      availableTrainingDaysIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'availableTrainingDays',
        value: '',
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      availableTrainingDaysIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'availableTrainingDays',
        value: '',
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
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

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      createdAtLessThan(
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

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      createdAtBetween(
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

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      currentWeeklyMileageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'currentWeeklyMileage',
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      currentWeeklyMileageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'currentWeeklyMileage',
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      currentWeeklyMileageEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentWeeklyMileage',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      currentWeeklyMileageGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currentWeeklyMileage',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      currentWeeklyMileageLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currentWeeklyMileage',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      currentWeeklyMileageBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currentWeeklyMileage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      dietaryPreferencesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dietaryPreferences',
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      dietaryPreferencesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dietaryPreferences',
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      dietaryPreferencesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dietaryPreferences',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      dietaryPreferencesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dietaryPreferences',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      dietaryPreferencesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dietaryPreferences',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      dietaryPreferencesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dietaryPreferences',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      dietaryPreferencesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dietaryPreferences',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      dietaryPreferencesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dietaryPreferences',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      dietaryPreferencesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dietaryPreferences',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      dietaryPreferencesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dietaryPreferences',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      dietaryPreferencesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dietaryPreferences',
        value: '',
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      dietaryPreferencesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dietaryPreferences',
        value: '',
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      injuryHistoryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'injuryHistory',
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      injuryHistoryIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'injuryHistory',
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      injuryHistoryEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'injuryHistory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      injuryHistoryGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'injuryHistory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      injuryHistoryLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'injuryHistory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      injuryHistoryBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'injuryHistory',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      injuryHistoryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'injuryHistory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      injuryHistoryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'injuryHistory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      injuryHistoryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'injuryHistory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      injuryHistoryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'injuryHistory',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      injuryHistoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'injuryHistory',
        value: '',
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      injuryHistoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'injuryHistory',
        value: '',
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      targetRaceTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'targetRaceTime',
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      targetRaceTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'targetRaceTime',
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      targetRaceTimeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'targetRaceTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      targetRaceTimeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'targetRaceTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      targetRaceTimeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'targetRaceTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      targetRaceTimeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'targetRaceTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      targetRaceTimeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'targetRaceTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      targetRaceTimeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'targetRaceTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      targetRaceTimeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'targetRaceTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      targetRaceTimeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'targetRaceTime',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      targetRaceTimeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'targetRaceTime',
        value: '',
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      targetRaceTimeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'targetRaceTime',
        value: '',
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      targetRaceTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'targetRaceType',
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      targetRaceTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'targetRaceType',
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      targetRaceTypeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'targetRaceType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      targetRaceTypeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'targetRaceType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      targetRaceTypeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'targetRaceType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      targetRaceTypeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'targetRaceType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      targetRaceTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'targetRaceType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      targetRaceTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'targetRaceType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      targetRaceTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'targetRaceType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      targetRaceTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'targetRaceType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      targetRaceTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'targetRaceType',
        value: '',
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      targetRaceTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'targetRaceType',
        value: '',
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      trainingGoalIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'trainingGoal',
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      trainingGoalIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'trainingGoal',
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      trainingGoalEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trainingGoal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      trainingGoalGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'trainingGoal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      trainingGoalLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'trainingGoal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      trainingGoalBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'trainingGoal',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      trainingGoalStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'trainingGoal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      trainingGoalEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'trainingGoal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      trainingGoalContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'trainingGoal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      trainingGoalMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'trainingGoal',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      trainingGoalIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trainingGoal',
        value: '',
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      trainingGoalIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'trainingGoal',
        value: '',
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
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

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      updatedAtLessThan(
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

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      updatedAtBetween(
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

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition> userIdEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: value,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      userIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userId',
        value: value,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition>
      userIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userId',
        value: value,
      ));
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterFilterCondition> userIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ProfileModelQueryObject
    on QueryBuilder<ProfileModel, ProfileModel, QFilterCondition> {}

extension ProfileModelQueryLinks
    on QueryBuilder<ProfileModel, ProfileModel, QFilterCondition> {}

extension ProfileModelQuerySortBy
    on QueryBuilder<ProfileModel, ProfileModel, QSortBy> {
  QueryBuilder<ProfileModel, ProfileModel, QAfterSortBy> sortByAllergies() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'allergies', Sort.asc);
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterSortBy> sortByAllergiesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'allergies', Sort.desc);
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterSortBy>
      sortByAvailableTrainingDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'availableTrainingDays', Sort.asc);
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterSortBy>
      sortByAvailableTrainingDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'availableTrainingDays', Sort.desc);
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterSortBy>
      sortByCurrentWeeklyMileage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentWeeklyMileage', Sort.asc);
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterSortBy>
      sortByCurrentWeeklyMileageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentWeeklyMileage', Sort.desc);
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterSortBy>
      sortByDietaryPreferences() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dietaryPreferences', Sort.asc);
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterSortBy>
      sortByDietaryPreferencesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dietaryPreferences', Sort.desc);
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterSortBy> sortByInjuryHistory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'injuryHistory', Sort.asc);
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterSortBy>
      sortByInjuryHistoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'injuryHistory', Sort.desc);
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterSortBy>
      sortByTargetRaceTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetRaceTime', Sort.asc);
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterSortBy>
      sortByTargetRaceTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetRaceTime', Sort.desc);
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterSortBy>
      sortByTargetRaceType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetRaceType', Sort.asc);
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterSortBy>
      sortByTargetRaceTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetRaceType', Sort.desc);
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterSortBy> sortByTrainingGoal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trainingGoal', Sort.asc);
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterSortBy>
      sortByTrainingGoalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trainingGoal', Sort.desc);
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterSortBy> sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterSortBy> sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension ProfileModelQuerySortThenBy
    on QueryBuilder<ProfileModel, ProfileModel, QSortThenBy> {
  QueryBuilder<ProfileModel, ProfileModel, QAfterSortBy> thenByAllergies() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'allergies', Sort.asc);
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterSortBy> thenByAllergiesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'allergies', Sort.desc);
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterSortBy>
      thenByAvailableTrainingDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'availableTrainingDays', Sort.asc);
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterSortBy>
      thenByAvailableTrainingDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'availableTrainingDays', Sort.desc);
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterSortBy>
      thenByCurrentWeeklyMileage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentWeeklyMileage', Sort.asc);
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterSortBy>
      thenByCurrentWeeklyMileageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentWeeklyMileage', Sort.desc);
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterSortBy>
      thenByDietaryPreferences() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dietaryPreferences', Sort.asc);
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterSortBy>
      thenByDietaryPreferencesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dietaryPreferences', Sort.desc);
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterSortBy> thenByInjuryHistory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'injuryHistory', Sort.asc);
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterSortBy>
      thenByInjuryHistoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'injuryHistory', Sort.desc);
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterSortBy>
      thenByTargetRaceTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetRaceTime', Sort.asc);
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterSortBy>
      thenByTargetRaceTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetRaceTime', Sort.desc);
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterSortBy>
      thenByTargetRaceType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetRaceType', Sort.asc);
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterSortBy>
      thenByTargetRaceTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetRaceType', Sort.desc);
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterSortBy> thenByTrainingGoal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trainingGoal', Sort.asc);
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterSortBy>
      thenByTrainingGoalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trainingGoal', Sort.desc);
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterSortBy> thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QAfterSortBy> thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension ProfileModelQueryWhereDistinct
    on QueryBuilder<ProfileModel, ProfileModel, QDistinct> {
  QueryBuilder<ProfileModel, ProfileModel, QDistinct> distinctByAllergies(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'allergies', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QDistinct>
      distinctByAvailableTrainingDays({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'availableTrainingDays',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QDistinct>
      distinctByCurrentWeeklyMileage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentWeeklyMileage');
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QDistinct>
      distinctByDietaryPreferences({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dietaryPreferences',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QDistinct> distinctByInjuryHistory(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'injuryHistory',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QDistinct> distinctByTargetRaceTime(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'targetRaceTime',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QDistinct> distinctByTargetRaceType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'targetRaceType',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QDistinct> distinctByTrainingGoal(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'trainingGoal', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<ProfileModel, ProfileModel, QDistinct> distinctByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId');
    });
  }
}

extension ProfileModelQueryProperty
    on QueryBuilder<ProfileModel, ProfileModel, QQueryProperty> {
  QueryBuilder<ProfileModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ProfileModel, String?, QQueryOperations> allergiesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'allergies');
    });
  }

  QueryBuilder<ProfileModel, String?, QQueryOperations>
      availableTrainingDaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'availableTrainingDays');
    });
  }

  QueryBuilder<ProfileModel, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<ProfileModel, double?, QQueryOperations>
      currentWeeklyMileageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentWeeklyMileage');
    });
  }

  QueryBuilder<ProfileModel, String?, QQueryOperations>
      dietaryPreferencesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dietaryPreferences');
    });
  }

  QueryBuilder<ProfileModel, String?, QQueryOperations>
      injuryHistoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'injuryHistory');
    });
  }

  QueryBuilder<ProfileModel, String?, QQueryOperations>
      targetRaceTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'targetRaceTime');
    });
  }

  QueryBuilder<ProfileModel, String?, QQueryOperations>
      targetRaceTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'targetRaceType');
    });
  }

  QueryBuilder<ProfileModel, String?, QQueryOperations> trainingGoalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'trainingGoal');
    });
  }

  QueryBuilder<ProfileModel, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<ProfileModel, int, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }
}
