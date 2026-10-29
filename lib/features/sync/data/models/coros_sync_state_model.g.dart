// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coros_sync_state_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCorosSyncStateModelCollection on Isar {
  IsarCollection<CorosSyncStateModel> get corosSyncStateModels =>
      this.collection();
}

const CorosSyncStateModelSchema = CollectionSchema(
  name: r'CorosSyncStateModel',
  id: -2093680583642078707,
  properties: {
    r'lastAttemptAt': PropertySchema(
      id: 0,
      name: r'lastAttemptAt',
      type: IsarType.dateTime,
    ),
    r'lastError': PropertySchema(
      id: 1,
      name: r'lastError',
      type: IsarType.string,
    ),
    r'lastImportedCount': PropertySchema(
      id: 2,
      name: r'lastImportedCount',
      type: IsarType.long,
    ),
    r'lastSkippedCount': PropertySchema(
      id: 3,
      name: r'lastSkippedCount',
      type: IsarType.long,
    ),
    r'lastStatus': PropertySchema(
      id: 4,
      name: r'lastStatus',
      type: IsarType.string,
    ),
    r'lastSyncAt': PropertySchema(
      id: 5,
      name: r'lastSyncAt',
      type: IsarType.dateTime,
    ),
    r'lastUpdatedCount': PropertySchema(
      id: 6,
      name: r'lastUpdatedCount',
      type: IsarType.long,
    )
  },
  estimateSize: _corosSyncStateModelEstimateSize,
  serialize: _corosSyncStateModelSerialize,
  deserialize: _corosSyncStateModelDeserialize,
  deserializeProp: _corosSyncStateModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _corosSyncStateModelGetId,
  getLinks: _corosSyncStateModelGetLinks,
  attach: _corosSyncStateModelAttach,
  version: '3.1.0+1',
);

int _corosSyncStateModelEstimateSize(
  CorosSyncStateModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.lastError;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.lastStatus.length * 3;
  return bytesCount;
}

void _corosSyncStateModelSerialize(
  CorosSyncStateModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.lastAttemptAt);
  writer.writeString(offsets[1], object.lastError);
  writer.writeLong(offsets[2], object.lastImportedCount);
  writer.writeLong(offsets[3], object.lastSkippedCount);
  writer.writeString(offsets[4], object.lastStatus);
  writer.writeDateTime(offsets[5], object.lastSyncAt);
  writer.writeLong(offsets[6], object.lastUpdatedCount);
}

CorosSyncStateModel _corosSyncStateModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CorosSyncStateModel();
  object.id = id;
  object.lastAttemptAt = reader.readDateTimeOrNull(offsets[0]);
  object.lastError = reader.readStringOrNull(offsets[1]);
  object.lastImportedCount = reader.readLong(offsets[2]);
  object.lastSkippedCount = reader.readLong(offsets[3]);
  object.lastStatus = reader.readString(offsets[4]);
  object.lastSyncAt = reader.readDateTimeOrNull(offsets[5]);
  object.lastUpdatedCount = reader.readLong(offsets[6]);
  return object;
}

P _corosSyncStateModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _corosSyncStateModelGetId(CorosSyncStateModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _corosSyncStateModelGetLinks(
    CorosSyncStateModel object) {
  return [];
}

void _corosSyncStateModelAttach(
    IsarCollection<dynamic> col, Id id, CorosSyncStateModel object) {
  object.id = id;
}

extension CorosSyncStateModelQueryWhereSort
    on QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QWhere> {
  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CorosSyncStateModelQueryWhere
    on QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QWhereClause> {
  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterWhereClause>
      idBetween(
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
}

extension CorosSyncStateModelQueryFilter on QueryBuilder<CorosSyncStateModel,
    CorosSyncStateModel, QFilterCondition> {
  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterFilterCondition>
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

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterFilterCondition>
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

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterFilterCondition>
      lastAttemptAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastAttemptAt',
      ));
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterFilterCondition>
      lastAttemptAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastAttemptAt',
      ));
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterFilterCondition>
      lastAttemptAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastAttemptAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterFilterCondition>
      lastAttemptAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastAttemptAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterFilterCondition>
      lastAttemptAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastAttemptAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterFilterCondition>
      lastAttemptAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastAttemptAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterFilterCondition>
      lastErrorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastError',
      ));
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterFilterCondition>
      lastErrorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastError',
      ));
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterFilterCondition>
      lastErrorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastError',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterFilterCondition>
      lastErrorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastError',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterFilterCondition>
      lastErrorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastError',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterFilterCondition>
      lastErrorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastError',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterFilterCondition>
      lastErrorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lastError',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterFilterCondition>
      lastErrorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lastError',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterFilterCondition>
      lastErrorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lastError',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterFilterCondition>
      lastErrorMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lastError',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterFilterCondition>
      lastErrorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastError',
        value: '',
      ));
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterFilterCondition>
      lastErrorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lastError',
        value: '',
      ));
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterFilterCondition>
      lastImportedCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastImportedCount',
        value: value,
      ));
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterFilterCondition>
      lastImportedCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastImportedCount',
        value: value,
      ));
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterFilterCondition>
      lastImportedCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastImportedCount',
        value: value,
      ));
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterFilterCondition>
      lastImportedCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastImportedCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterFilterCondition>
      lastSkippedCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastSkippedCount',
        value: value,
      ));
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterFilterCondition>
      lastSkippedCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastSkippedCount',
        value: value,
      ));
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterFilterCondition>
      lastSkippedCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastSkippedCount',
        value: value,
      ));
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterFilterCondition>
      lastSkippedCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastSkippedCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterFilterCondition>
      lastStatusEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterFilterCondition>
      lastStatusGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterFilterCondition>
      lastStatusLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterFilterCondition>
      lastStatusBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastStatus',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterFilterCondition>
      lastStatusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lastStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterFilterCondition>
      lastStatusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lastStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterFilterCondition>
      lastStatusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lastStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterFilterCondition>
      lastStatusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lastStatus',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterFilterCondition>
      lastStatusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastStatus',
        value: '',
      ));
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterFilterCondition>
      lastStatusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lastStatus',
        value: '',
      ));
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterFilterCondition>
      lastSyncAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastSyncAt',
      ));
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterFilterCondition>
      lastSyncAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastSyncAt',
      ));
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterFilterCondition>
      lastSyncAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastSyncAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterFilterCondition>
      lastSyncAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastSyncAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterFilterCondition>
      lastSyncAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastSyncAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterFilterCondition>
      lastSyncAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastSyncAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterFilterCondition>
      lastUpdatedCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastUpdatedCount',
        value: value,
      ));
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterFilterCondition>
      lastUpdatedCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastUpdatedCount',
        value: value,
      ));
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterFilterCondition>
      lastUpdatedCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastUpdatedCount',
        value: value,
      ));
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterFilterCondition>
      lastUpdatedCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastUpdatedCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CorosSyncStateModelQueryObject on QueryBuilder<CorosSyncStateModel,
    CorosSyncStateModel, QFilterCondition> {}

extension CorosSyncStateModelQueryLinks on QueryBuilder<CorosSyncStateModel,
    CorosSyncStateModel, QFilterCondition> {}

extension CorosSyncStateModelQuerySortBy
    on QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QSortBy> {
  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterSortBy>
      sortByLastAttemptAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastAttemptAt', Sort.asc);
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterSortBy>
      sortByLastAttemptAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastAttemptAt', Sort.desc);
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterSortBy>
      sortByLastError() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastError', Sort.asc);
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterSortBy>
      sortByLastErrorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastError', Sort.desc);
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterSortBy>
      sortByLastImportedCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastImportedCount', Sort.asc);
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterSortBy>
      sortByLastImportedCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastImportedCount', Sort.desc);
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterSortBy>
      sortByLastSkippedCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSkippedCount', Sort.asc);
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterSortBy>
      sortByLastSkippedCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSkippedCount', Sort.desc);
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterSortBy>
      sortByLastStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastStatus', Sort.asc);
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterSortBy>
      sortByLastStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastStatus', Sort.desc);
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterSortBy>
      sortByLastSyncAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSyncAt', Sort.asc);
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterSortBy>
      sortByLastSyncAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSyncAt', Sort.desc);
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterSortBy>
      sortByLastUpdatedCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdatedCount', Sort.asc);
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterSortBy>
      sortByLastUpdatedCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdatedCount', Sort.desc);
    });
  }
}

extension CorosSyncStateModelQuerySortThenBy
    on QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QSortThenBy> {
  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterSortBy>
      thenByLastAttemptAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastAttemptAt', Sort.asc);
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterSortBy>
      thenByLastAttemptAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastAttemptAt', Sort.desc);
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterSortBy>
      thenByLastError() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastError', Sort.asc);
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterSortBy>
      thenByLastErrorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastError', Sort.desc);
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterSortBy>
      thenByLastImportedCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastImportedCount', Sort.asc);
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterSortBy>
      thenByLastImportedCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastImportedCount', Sort.desc);
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterSortBy>
      thenByLastSkippedCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSkippedCount', Sort.asc);
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterSortBy>
      thenByLastSkippedCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSkippedCount', Sort.desc);
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterSortBy>
      thenByLastStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastStatus', Sort.asc);
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterSortBy>
      thenByLastStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastStatus', Sort.desc);
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterSortBy>
      thenByLastSyncAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSyncAt', Sort.asc);
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterSortBy>
      thenByLastSyncAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastSyncAt', Sort.desc);
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterSortBy>
      thenByLastUpdatedCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdatedCount', Sort.asc);
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QAfterSortBy>
      thenByLastUpdatedCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdatedCount', Sort.desc);
    });
  }
}

extension CorosSyncStateModelQueryWhereDistinct
    on QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QDistinct> {
  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QDistinct>
      distinctByLastAttemptAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastAttemptAt');
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QDistinct>
      distinctByLastError({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastError', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QDistinct>
      distinctByLastImportedCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastImportedCount');
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QDistinct>
      distinctByLastSkippedCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastSkippedCount');
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QDistinct>
      distinctByLastStatus({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastStatus', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QDistinct>
      distinctByLastSyncAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastSyncAt');
    });
  }

  QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QDistinct>
      distinctByLastUpdatedCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastUpdatedCount');
    });
  }
}

extension CorosSyncStateModelQueryProperty
    on QueryBuilder<CorosSyncStateModel, CorosSyncStateModel, QQueryProperty> {
  QueryBuilder<CorosSyncStateModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CorosSyncStateModel, DateTime?, QQueryOperations>
      lastAttemptAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastAttemptAt');
    });
  }

  QueryBuilder<CorosSyncStateModel, String?, QQueryOperations>
      lastErrorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastError');
    });
  }

  QueryBuilder<CorosSyncStateModel, int, QQueryOperations>
      lastImportedCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastImportedCount');
    });
  }

  QueryBuilder<CorosSyncStateModel, int, QQueryOperations>
      lastSkippedCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastSkippedCount');
    });
  }

  QueryBuilder<CorosSyncStateModel, String, QQueryOperations>
      lastStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastStatus');
    });
  }

  QueryBuilder<CorosSyncStateModel, DateTime?, QQueryOperations>
      lastSyncAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastSyncAt');
    });
  }

  QueryBuilder<CorosSyncStateModel, int, QQueryOperations>
      lastUpdatedCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastUpdatedCount');
    });
  }
}
