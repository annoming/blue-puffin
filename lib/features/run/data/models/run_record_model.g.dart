// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'run_record_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRunRecordModelCollection on Isar {
  IsarCollection<RunRecordModel> get runRecordModels => this.collection();
}

const RunRecordModelSchema = CollectionSchema(
  name: r'RunRecordModel',
  id: 8744659682935536206,
  properties: {
    r'avgHeartRate': PropertySchema(
      id: 0,
      name: r'avgHeartRate',
      type: IsarType.long,
    ),
    r'calories': PropertySchema(
      id: 1,
      name: r'calories',
      type: IsarType.long,
    ),
    r'createdAt': PropertySchema(
      id: 2,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'distanceKm': PropertySchema(
      id: 3,
      name: r'distanceKm',
      type: IsarType.double,
    ),
    r'distanceMeters': PropertySchema(
      id: 4,
      name: r'distanceMeters',
      type: IsarType.double,
    ),
    r'durationSeconds': PropertySchema(
      id: 5,
      name: r'durationSeconds',
      type: IsarType.long,
    ),
    r'externalId': PropertySchema(
      id: 6,
      name: r'externalId',
      type: IsarType.string,
    ),
    r'formattedDuration': PropertySchema(
      id: 7,
      name: r'formattedDuration',
      type: IsarType.string,
    ),
    r'formattedPace': PropertySchema(
      id: 8,
      name: r'formattedPace',
      type: IsarType.string,
    ),
    r'isFromCoros': PropertySchema(
      id: 9,
      name: r'isFromCoros',
      type: IsarType.bool,
    ),
    r'paceSecondsPerKm': PropertySchema(
      id: 10,
      name: r'paceSecondsPerKm',
      type: IsarType.double,
    ),
    r'source': PropertySchema(
      id: 11,
      name: r'source',
      type: IsarType.string,
    ),
    r'sportType': PropertySchema(
      id: 12,
      name: r'sportType',
      type: IsarType.long,
    ),
    r'startTime': PropertySchema(
      id: 13,
      name: r'startTime',
      type: IsarType.dateTime,
    ),
    r'syncedAt': PropertySchema(
      id: 14,
      name: r'syncedAt',
      type: IsarType.dateTime,
    ),
    r'title': PropertySchema(
      id: 15,
      name: r'title',
      type: IsarType.string,
    )
  },
  estimateSize: _runRecordModelEstimateSize,
  serialize: _runRecordModelSerialize,
  deserialize: _runRecordModelDeserialize,
  deserializeProp: _runRecordModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'source_externalId': IndexSchema(
      id: 7290424687692283137,
      name: r'source_externalId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'source',
          type: IndexType.hash,
          caseSensitive: true,
        ),
        IndexPropertySchema(
          name: r'externalId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _runRecordModelGetId,
  getLinks: _runRecordModelGetLinks,
  attach: _runRecordModelAttach,
  version: '3.1.0+1',
);

int _runRecordModelEstimateSize(
  RunRecordModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.externalId.length * 3;
  bytesCount += 3 + object.formattedDuration.length * 3;
  {
    final value = object.formattedPace;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.source.length * 3;
  {
    final value = object.title;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _runRecordModelSerialize(
  RunRecordModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.avgHeartRate);
  writer.writeLong(offsets[1], object.calories);
  writer.writeDateTime(offsets[2], object.createdAt);
  writer.writeDouble(offsets[3], object.distanceKm);
  writer.writeDouble(offsets[4], object.distanceMeters);
  writer.writeLong(offsets[5], object.durationSeconds);
  writer.writeString(offsets[6], object.externalId);
  writer.writeString(offsets[7], object.formattedDuration);
  writer.writeString(offsets[8], object.formattedPace);
  writer.writeBool(offsets[9], object.isFromCoros);
  writer.writeDouble(offsets[10], object.paceSecondsPerKm);
  writer.writeString(offsets[11], object.source);
  writer.writeLong(offsets[12], object.sportType);
  writer.writeDateTime(offsets[13], object.startTime);
  writer.writeDateTime(offsets[14], object.syncedAt);
  writer.writeString(offsets[15], object.title);
}

RunRecordModel _runRecordModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RunRecordModel();
  object.avgHeartRate = reader.readLongOrNull(offsets[0]);
  object.calories = reader.readLongOrNull(offsets[1]);
  object.createdAt = reader.readDateTime(offsets[2]);
  object.distanceMeters = reader.readDouble(offsets[4]);
  object.durationSeconds = reader.readLong(offsets[5]);
  object.externalId = reader.readString(offsets[6]);
  object.id = id;
  object.source = reader.readString(offsets[11]);
  object.sportType = reader.readLongOrNull(offsets[12]);
  object.startTime = reader.readDateTime(offsets[13]);
  object.syncedAt = reader.readDateTime(offsets[14]);
  object.title = reader.readStringOrNull(offsets[15]);
  return object;
}

P _runRecordModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    case 4:
      return (reader.readDouble(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readBool(offset)) as P;
    case 10:
      return (reader.readDoubleOrNull(offset)) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readLongOrNull(offset)) as P;
    case 13:
      return (reader.readDateTime(offset)) as P;
    case 14:
      return (reader.readDateTime(offset)) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _runRecordModelGetId(RunRecordModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _runRecordModelGetLinks(RunRecordModel object) {
  return [];
}

void _runRecordModelAttach(
    IsarCollection<dynamic> col, Id id, RunRecordModel object) {
  object.id = id;
}

extension RunRecordModelByIndex on IsarCollection<RunRecordModel> {
  Future<RunRecordModel?> getBySourceExternalId(
      String source, String externalId) {
    return getByIndex(r'source_externalId', [source, externalId]);
  }

  RunRecordModel? getBySourceExternalIdSync(String source, String externalId) {
    return getByIndexSync(r'source_externalId', [source, externalId]);
  }

  Future<bool> deleteBySourceExternalId(String source, String externalId) {
    return deleteByIndex(r'source_externalId', [source, externalId]);
  }

  bool deleteBySourceExternalIdSync(String source, String externalId) {
    return deleteByIndexSync(r'source_externalId', [source, externalId]);
  }

  Future<List<RunRecordModel?>> getAllBySourceExternalId(
      List<String> sourceValues, List<String> externalIdValues) {
    final len = sourceValues.length;
    assert(externalIdValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([sourceValues[i], externalIdValues[i]]);
    }

    return getAllByIndex(r'source_externalId', values);
  }

  List<RunRecordModel?> getAllBySourceExternalIdSync(
      List<String> sourceValues, List<String> externalIdValues) {
    final len = sourceValues.length;
    assert(externalIdValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([sourceValues[i], externalIdValues[i]]);
    }

    return getAllByIndexSync(r'source_externalId', values);
  }

  Future<int> deleteAllBySourceExternalId(
      List<String> sourceValues, List<String> externalIdValues) {
    final len = sourceValues.length;
    assert(externalIdValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([sourceValues[i], externalIdValues[i]]);
    }

    return deleteAllByIndex(r'source_externalId', values);
  }

  int deleteAllBySourceExternalIdSync(
      List<String> sourceValues, List<String> externalIdValues) {
    final len = sourceValues.length;
    assert(externalIdValues.length == len,
        'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([sourceValues[i], externalIdValues[i]]);
    }

    return deleteAllByIndexSync(r'source_externalId', values);
  }

  Future<Id> putBySourceExternalId(RunRecordModel object) {
    return putByIndex(r'source_externalId', object);
  }

  Id putBySourceExternalIdSync(RunRecordModel object, {bool saveLinks = true}) {
    return putByIndexSync(r'source_externalId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllBySourceExternalId(List<RunRecordModel> objects) {
    return putAllByIndex(r'source_externalId', objects);
  }

  List<Id> putAllBySourceExternalIdSync(List<RunRecordModel> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'source_externalId', objects,
        saveLinks: saveLinks);
  }
}

extension RunRecordModelQueryWhereSort
    on QueryBuilder<RunRecordModel, RunRecordModel, QWhere> {
  QueryBuilder<RunRecordModel, RunRecordModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension RunRecordModelQueryWhere
    on QueryBuilder<RunRecordModel, RunRecordModel, QWhereClause> {
  QueryBuilder<RunRecordModel, RunRecordModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterWhereClause> idBetween(
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

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterWhereClause>
      sourceEqualToAnyExternalId(String source) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'source_externalId',
        value: [source],
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterWhereClause>
      sourceNotEqualToAnyExternalId(String source) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'source_externalId',
              lower: [],
              upper: [source],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'source_externalId',
              lower: [source],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'source_externalId',
              lower: [source],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'source_externalId',
              lower: [],
              upper: [source],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterWhereClause>
      sourceExternalIdEqualTo(String source, String externalId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'source_externalId',
        value: [source, externalId],
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterWhereClause>
      sourceEqualToExternalIdNotEqualTo(String source, String externalId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'source_externalId',
              lower: [source],
              upper: [source, externalId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'source_externalId',
              lower: [source, externalId],
              includeLower: false,
              upper: [source],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'source_externalId',
              lower: [source, externalId],
              includeLower: false,
              upper: [source],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'source_externalId',
              lower: [source],
              upper: [source, externalId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension RunRecordModelQueryFilter
    on QueryBuilder<RunRecordModel, RunRecordModel, QFilterCondition> {
  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      avgHeartRateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'avgHeartRate',
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      avgHeartRateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'avgHeartRate',
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      avgHeartRateEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avgHeartRate',
        value: value,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      avgHeartRateGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'avgHeartRate',
        value: value,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      avgHeartRateLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'avgHeartRate',
        value: value,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      avgHeartRateBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'avgHeartRate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      caloriesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'calories',
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      caloriesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'calories',
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      caloriesEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'calories',
        value: value,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      caloriesGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'calories',
        value: value,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      caloriesLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'calories',
        value: value,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      caloriesBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'calories',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
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

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
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

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
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

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      distanceKmEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'distanceKm',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      distanceKmGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'distanceKm',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      distanceKmLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'distanceKm',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      distanceKmBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'distanceKm',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      distanceMetersEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'distanceMeters',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      distanceMetersGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'distanceMeters',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      distanceMetersLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'distanceMeters',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      distanceMetersBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'distanceMeters',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      durationSecondsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'durationSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      durationSecondsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'durationSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      durationSecondsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'durationSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      durationSecondsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'durationSeconds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      externalIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'externalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      externalIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'externalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      externalIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'externalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      externalIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'externalId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      externalIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'externalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      externalIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'externalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      externalIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'externalId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      externalIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'externalId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      externalIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'externalId',
        value: '',
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      externalIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'externalId',
        value: '',
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      formattedDurationEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'formattedDuration',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      formattedDurationGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'formattedDuration',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      formattedDurationLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'formattedDuration',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      formattedDurationBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'formattedDuration',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      formattedDurationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'formattedDuration',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      formattedDurationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'formattedDuration',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      formattedDurationContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'formattedDuration',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      formattedDurationMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'formattedDuration',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      formattedDurationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'formattedDuration',
        value: '',
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      formattedDurationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'formattedDuration',
        value: '',
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      formattedPaceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'formattedPace',
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      formattedPaceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'formattedPace',
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      formattedPaceEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'formattedPace',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      formattedPaceGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'formattedPace',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      formattedPaceLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'formattedPace',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      formattedPaceBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'formattedPace',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      formattedPaceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'formattedPace',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      formattedPaceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'formattedPace',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      formattedPaceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'formattedPace',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      formattedPaceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'formattedPace',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      formattedPaceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'formattedPace',
        value: '',
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      formattedPaceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'formattedPace',
        value: '',
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      isFromCorosEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isFromCoros',
        value: value,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      paceSecondsPerKmIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'paceSecondsPerKm',
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      paceSecondsPerKmIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'paceSecondsPerKm',
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      paceSecondsPerKmEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'paceSecondsPerKm',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      paceSecondsPerKmGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'paceSecondsPerKm',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      paceSecondsPerKmLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'paceSecondsPerKm',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      paceSecondsPerKmBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'paceSecondsPerKm',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      sourceEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      sourceGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      sourceLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      sourceBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'source',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      sourceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      sourceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      sourceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'source',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      sourceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'source',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      sourceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'source',
        value: '',
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      sourceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'source',
        value: '',
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      sportTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sportType',
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      sportTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sportType',
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      sportTypeEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sportType',
        value: value,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      sportTypeGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sportType',
        value: value,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      sportTypeLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sportType',
        value: value,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      sportTypeBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sportType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      startTimeEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startTime',
        value: value,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      startTimeGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'startTime',
        value: value,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      startTimeLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'startTime',
        value: value,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      startTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'startTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      syncedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'syncedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      syncedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'syncedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      syncedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'syncedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      syncedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'syncedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      titleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'title',
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      titleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'title',
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      titleEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      titleGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      titleLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      titleBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      titleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      titleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }
}

extension RunRecordModelQueryObject
    on QueryBuilder<RunRecordModel, RunRecordModel, QFilterCondition> {}

extension RunRecordModelQueryLinks
    on QueryBuilder<RunRecordModel, RunRecordModel, QFilterCondition> {}

extension RunRecordModelQuerySortBy
    on QueryBuilder<RunRecordModel, RunRecordModel, QSortBy> {
  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy>
      sortByAvgHeartRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avgHeartRate', Sort.asc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy>
      sortByAvgHeartRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avgHeartRate', Sort.desc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy> sortByCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calories', Sort.asc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy>
      sortByCaloriesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calories', Sort.desc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy>
      sortByDistanceKm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceKm', Sort.asc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy>
      sortByDistanceKmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceKm', Sort.desc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy>
      sortByDistanceMeters() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceMeters', Sort.asc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy>
      sortByDistanceMetersDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceMeters', Sort.desc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy>
      sortByDurationSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationSeconds', Sort.asc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy>
      sortByDurationSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationSeconds', Sort.desc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy>
      sortByExternalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'externalId', Sort.asc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy>
      sortByExternalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'externalId', Sort.desc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy>
      sortByFormattedDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'formattedDuration', Sort.asc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy>
      sortByFormattedDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'formattedDuration', Sort.desc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy>
      sortByFormattedPace() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'formattedPace', Sort.asc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy>
      sortByFormattedPaceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'formattedPace', Sort.desc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy>
      sortByIsFromCoros() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFromCoros', Sort.asc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy>
      sortByIsFromCorosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFromCoros', Sort.desc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy>
      sortByPaceSecondsPerKm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paceSecondsPerKm', Sort.asc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy>
      sortByPaceSecondsPerKmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paceSecondsPerKm', Sort.desc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy> sortBySource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.asc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy>
      sortBySourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.desc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy> sortBySportType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sportType', Sort.asc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy>
      sortBySportTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sportType', Sort.desc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy> sortByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.asc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy>
      sortByStartTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.desc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy> sortBySyncedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncedAt', Sort.asc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy>
      sortBySyncedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncedAt', Sort.desc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension RunRecordModelQuerySortThenBy
    on QueryBuilder<RunRecordModel, RunRecordModel, QSortThenBy> {
  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy>
      thenByAvgHeartRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avgHeartRate', Sort.asc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy>
      thenByAvgHeartRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avgHeartRate', Sort.desc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy> thenByCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calories', Sort.asc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy>
      thenByCaloriesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calories', Sort.desc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy>
      thenByDistanceKm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceKm', Sort.asc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy>
      thenByDistanceKmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceKm', Sort.desc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy>
      thenByDistanceMeters() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceMeters', Sort.asc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy>
      thenByDistanceMetersDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distanceMeters', Sort.desc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy>
      thenByDurationSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationSeconds', Sort.asc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy>
      thenByDurationSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationSeconds', Sort.desc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy>
      thenByExternalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'externalId', Sort.asc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy>
      thenByExternalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'externalId', Sort.desc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy>
      thenByFormattedDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'formattedDuration', Sort.asc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy>
      thenByFormattedDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'formattedDuration', Sort.desc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy>
      thenByFormattedPace() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'formattedPace', Sort.asc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy>
      thenByFormattedPaceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'formattedPace', Sort.desc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy>
      thenByIsFromCoros() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFromCoros', Sort.asc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy>
      thenByIsFromCorosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFromCoros', Sort.desc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy>
      thenByPaceSecondsPerKm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paceSecondsPerKm', Sort.asc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy>
      thenByPaceSecondsPerKmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paceSecondsPerKm', Sort.desc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy> thenBySource() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.asc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy>
      thenBySourceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'source', Sort.desc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy> thenBySportType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sportType', Sort.asc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy>
      thenBySportTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sportType', Sort.desc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy> thenByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.asc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy>
      thenByStartTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.desc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy> thenBySyncedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncedAt', Sort.asc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy>
      thenBySyncedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncedAt', Sort.desc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension RunRecordModelQueryWhereDistinct
    on QueryBuilder<RunRecordModel, RunRecordModel, QDistinct> {
  QueryBuilder<RunRecordModel, RunRecordModel, QDistinct>
      distinctByAvgHeartRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'avgHeartRate');
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QDistinct> distinctByCalories() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'calories');
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QDistinct>
      distinctByDistanceKm() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'distanceKm');
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QDistinct>
      distinctByDistanceMeters() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'distanceMeters');
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QDistinct>
      distinctByDurationSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'durationSeconds');
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QDistinct> distinctByExternalId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'externalId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QDistinct>
      distinctByFormattedDuration({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'formattedDuration',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QDistinct>
      distinctByFormattedPace({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'formattedPace',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QDistinct>
      distinctByIsFromCoros() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isFromCoros');
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QDistinct>
      distinctByPaceSecondsPerKm() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'paceSecondsPerKm');
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QDistinct> distinctBySource(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'source', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QDistinct>
      distinctBySportType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sportType');
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QDistinct>
      distinctByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startTime');
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QDistinct> distinctBySyncedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'syncedAt');
    });
  }

  QueryBuilder<RunRecordModel, RunRecordModel, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }
}

extension RunRecordModelQueryProperty
    on QueryBuilder<RunRecordModel, RunRecordModel, QQueryProperty> {
  QueryBuilder<RunRecordModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RunRecordModel, int?, QQueryOperations> avgHeartRateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'avgHeartRate');
    });
  }

  QueryBuilder<RunRecordModel, int?, QQueryOperations> caloriesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'calories');
    });
  }

  QueryBuilder<RunRecordModel, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<RunRecordModel, double, QQueryOperations> distanceKmProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'distanceKm');
    });
  }

  QueryBuilder<RunRecordModel, double, QQueryOperations>
      distanceMetersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'distanceMeters');
    });
  }

  QueryBuilder<RunRecordModel, int, QQueryOperations>
      durationSecondsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'durationSeconds');
    });
  }

  QueryBuilder<RunRecordModel, String, QQueryOperations> externalIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'externalId');
    });
  }

  QueryBuilder<RunRecordModel, String, QQueryOperations>
      formattedDurationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'formattedDuration');
    });
  }

  QueryBuilder<RunRecordModel, String?, QQueryOperations>
      formattedPaceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'formattedPace');
    });
  }

  QueryBuilder<RunRecordModel, bool, QQueryOperations> isFromCorosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isFromCoros');
    });
  }

  QueryBuilder<RunRecordModel, double?, QQueryOperations>
      paceSecondsPerKmProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'paceSecondsPerKm');
    });
  }

  QueryBuilder<RunRecordModel, String, QQueryOperations> sourceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'source');
    });
  }

  QueryBuilder<RunRecordModel, int?, QQueryOperations> sportTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sportType');
    });
  }

  QueryBuilder<RunRecordModel, DateTime, QQueryOperations> startTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startTime');
    });
  }

  QueryBuilder<RunRecordModel, DateTime, QQueryOperations> syncedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'syncedAt');
    });
  }

  QueryBuilder<RunRecordModel, String?, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }
}
