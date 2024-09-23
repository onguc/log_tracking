// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_info.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetLogInfoCollection on Isar {
  IsarCollection<LogInfo> get logInfos => this.collection();
}

const LogInfoSchema = CollectionSchema(
  name: r'LogInfo',
  id: 6768978256120956234,
  properties: {
    r'className': PropertySchema(
      id: 0,
      name: r'className',
      type: IsarType.string,
    ),
    r'dateTime': PropertySchema(
      id: 1,
      name: r'dateTime',
      type: IsarType.dateTime,
    ),
    r'errorIndex': PropertySchema(
      id: 2,
      name: r'errorIndex',
      type: IsarType.long,
    ),
    r'errorString': PropertySchema(
      id: 3,
      name: r'errorString',
      type: IsarType.string,
    ),
    r'groupId': PropertySchema(
      id: 4,
      name: r'groupId',
      type: IsarType.long,
    ),
    r'launchIndex': PropertySchema(
      id: 5,
      name: r'launchIndex',
      type: IsarType.long,
    ),
    r'logLevel': PropertySchema(
      id: 6,
      name: r'logLevel',
      type: IsarType.string,
      enumMap: _LogInfologLevelEnumValueMap,
    ),
    r'logType': PropertySchema(
      id: 7,
      name: r'logType',
      type: IsarType.string,
      enumMap: _LogInfologTypeEnumValueMap,
    ),
    r'logTypeGroup': PropertySchema(
      id: 8,
      name: r'logTypeGroup',
      type: IsarType.string,
      enumMap: _LogInfologTypeGroupEnumValueMap,
    ),
    r'methodName': PropertySchema(
      id: 9,
      name: r'methodName',
      type: IsarType.string,
    ),
    r'stacktraceString': PropertySchema(
      id: 10,
      name: r'stacktraceString',
      type: IsarType.string,
    ),
    r'status': PropertySchema(
      id: 11,
      name: r'status',
      type: IsarType.string,
      enumMap: _LogInfostatusEnumValueMap,
    ),
    r'text': PropertySchema(
      id: 12,
      name: r'text',
      type: IsarType.string,
    ),
    r'timeZone': PropertySchema(
      id: 13,
      name: r'timeZone',
      type: IsarType.string,
    ),
    r'version': PropertySchema(
      id: 14,
      name: r'version',
      type: IsarType.string,
    )
  },
  estimateSize: _logInfoEstimateSize,
  serialize: _logInfoSerialize,
  deserialize: _logInfoDeserialize,
  deserializeProp: _logInfoDeserializeProp,
  idName: r'id',
  indexes: {
    r'errorIndex': IndexSchema(
      id: -8231998700777537357,
      name: r'errorIndex',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'errorIndex',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'dateTime': IndexSchema(
      id: -138851979697481250,
      name: r'dateTime',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'dateTime',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'status': IndexSchema(
      id: -107785170620420283,
      name: r'status',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'status',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _logInfoGetId,
  getLinks: _logInfoGetLinks,
  attach: _logInfoAttach,
  version: '3.1.0+1',
);

int _logInfoEstimateSize(
  LogInfo object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.className;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.errorString;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.logLevel;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  {
    final value = object.logType;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  {
    final value = object.logTypeGroup;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  {
    final value = object.methodName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.stacktraceString;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.status;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  {
    final value = object.text;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.timeZone;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.version;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _logInfoSerialize(
  LogInfo object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.className);
  writer.writeDateTime(offsets[1], object.dateTime);
  writer.writeLong(offsets[2], object.errorIndex);
  writer.writeString(offsets[3], object.errorString);
  writer.writeLong(offsets[4], object.groupId);
  writer.writeLong(offsets[5], object.launchIndex);
  writer.writeString(offsets[6], object.logLevel?.name);
  writer.writeString(offsets[7], object.logType?.name);
  writer.writeString(offsets[8], object.logTypeGroup?.name);
  writer.writeString(offsets[9], object.methodName);
  writer.writeString(offsets[10], object.stacktraceString);
  writer.writeString(offsets[11], object.status?.name);
  writer.writeString(offsets[12], object.text);
  writer.writeString(offsets[13], object.timeZone);
  writer.writeString(offsets[14], object.version);
}

LogInfo _logInfoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = LogInfo(
    className: reader.readStringOrNull(offsets[0]),
  );
  object.dateTime = reader.readDateTimeOrNull(offsets[1]);
  object.errorIndex = reader.readLongOrNull(offsets[2]);
  object.errorString = reader.readStringOrNull(offsets[3]);
  object.groupId = reader.readLongOrNull(offsets[4]);
  object.id = id;
  object.launchIndex = reader.readLongOrNull(offsets[5]);
  object.logLevel =
      _LogInfologLevelValueEnumMap[reader.readStringOrNull(offsets[6])];
  object.logType =
      _LogInfologTypeValueEnumMap[reader.readStringOrNull(offsets[7])];
  object.logTypeGroup =
      _LogInfologTypeGroupValueEnumMap[reader.readStringOrNull(offsets[8])];
  object.methodName = reader.readStringOrNull(offsets[9]);
  object.stacktraceString = reader.readStringOrNull(offsets[10]);
  object.status =
      _LogInfostatusValueEnumMap[reader.readStringOrNull(offsets[11])];
  object.text = reader.readStringOrNull(offsets[12]);
  object.timeZone = reader.readStringOrNull(offsets[13]);
  object.version = reader.readStringOrNull(offsets[14]);
  return object;
}

P _logInfoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    case 6:
      return (_LogInfologLevelValueEnumMap[reader.readStringOrNull(offset)])
          as P;
    case 7:
      return (_LogInfologTypeValueEnumMap[reader.readStringOrNull(offset)])
          as P;
    case 8:
      return (_LogInfologTypeGroupValueEnumMap[reader.readStringOrNull(offset)])
          as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (_LogInfostatusValueEnumMap[reader.readStringOrNull(offset)]) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _LogInfologLevelEnumValueMap = {
  r'high': r'high',
  r'medium': r'medium',
  r'low': r'low',
};
const _LogInfologLevelValueEnumMap = {
  r'high': EnumLogLevel.high,
  r'medium': EnumLogLevel.medium,
  r'low': EnumLogLevel.low,
};
const _LogInfologTypeEnumValueMap = {
  r'debug': r'debug',
  r'info': r'info',
  r'warning': r'warning',
  r'error': r'error',
};
const _LogInfologTypeValueEnumMap = {
  r'debug': EnumLogType.debug,
  r'info': EnumLogType.info,
  r'warning': EnumLogType.warning,
  r'error': EnumLogType.error,
};
const _LogInfologTypeGroupEnumValueMap = {
  r'production': r'production',
  r'debug': r'debug',
};
const _LogInfologTypeGroupValueEnumMap = {
  r'production': EnumLogTypeGroup.production,
  r'debug': EnumLogTypeGroup.debug,
};
const _LogInfostatusEnumValueMap = {
  r'unsent': r'unsent',
  r'sent': r'sent',
  r'sending': r'sending',
};
const _LogInfostatusValueEnumMap = {
  r'unsent': EnumStatus.unsent,
  r'sent': EnumStatus.sent,
  r'sending': EnumStatus.sending,
};

Id _logInfoGetId(LogInfo object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _logInfoGetLinks(LogInfo object) {
  return [];
}

void _logInfoAttach(IsarCollection<dynamic> col, Id id, LogInfo object) {
  object.id = id;
}

extension LogInfoQueryWhereSort on QueryBuilder<LogInfo, LogInfo, QWhere> {
  QueryBuilder<LogInfo, LogInfo, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterWhere> anyErrorIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'errorIndex'),
      );
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterWhere> anyDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'dateTime'),
      );
    });
  }
}

extension LogInfoQueryWhere on QueryBuilder<LogInfo, LogInfo, QWhereClause> {
  QueryBuilder<LogInfo, LogInfo, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<LogInfo, LogInfo, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterWhereClause> idBetween(
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

  QueryBuilder<LogInfo, LogInfo, QAfterWhereClause> errorIndexIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'errorIndex',
        value: [null],
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterWhereClause> errorIndexIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'errorIndex',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterWhereClause> errorIndexEqualTo(
      int? errorIndex) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'errorIndex',
        value: [errorIndex],
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterWhereClause> errorIndexNotEqualTo(
      int? errorIndex) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'errorIndex',
              lower: [],
              upper: [errorIndex],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'errorIndex',
              lower: [errorIndex],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'errorIndex',
              lower: [errorIndex],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'errorIndex',
              lower: [],
              upper: [errorIndex],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterWhereClause> errorIndexGreaterThan(
    int? errorIndex, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'errorIndex',
        lower: [errorIndex],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterWhereClause> errorIndexLessThan(
    int? errorIndex, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'errorIndex',
        lower: [],
        upper: [errorIndex],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterWhereClause> errorIndexBetween(
    int? lowerErrorIndex,
    int? upperErrorIndex, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'errorIndex',
        lower: [lowerErrorIndex],
        includeLower: includeLower,
        upper: [upperErrorIndex],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterWhereClause> dateTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'dateTime',
        value: [null],
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterWhereClause> dateTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dateTime',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterWhereClause> dateTimeEqualTo(
      DateTime? dateTime) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'dateTime',
        value: [dateTime],
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterWhereClause> dateTimeNotEqualTo(
      DateTime? dateTime) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dateTime',
              lower: [],
              upper: [dateTime],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dateTime',
              lower: [dateTime],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dateTime',
              lower: [dateTime],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dateTime',
              lower: [],
              upper: [dateTime],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterWhereClause> dateTimeGreaterThan(
    DateTime? dateTime, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dateTime',
        lower: [dateTime],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterWhereClause> dateTimeLessThan(
    DateTime? dateTime, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dateTime',
        lower: [],
        upper: [dateTime],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterWhereClause> dateTimeBetween(
    DateTime? lowerDateTime,
    DateTime? upperDateTime, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dateTime',
        lower: [lowerDateTime],
        includeLower: includeLower,
        upper: [upperDateTime],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterWhereClause> statusIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'status',
        value: [null],
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterWhereClause> statusIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'status',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterWhereClause> statusEqualTo(
      EnumStatus? status) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'status',
        value: [status],
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterWhereClause> statusNotEqualTo(
      EnumStatus? status) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'status',
              lower: [],
              upper: [status],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'status',
              lower: [status],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'status',
              lower: [status],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'status',
              lower: [],
              upper: [status],
              includeUpper: false,
            ));
      }
    });
  }
}

extension LogInfoQueryFilter
    on QueryBuilder<LogInfo, LogInfo, QFilterCondition> {
  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> classNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'className',
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> classNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'className',
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> classNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'className',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> classNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'className',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> classNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'className',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> classNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'className',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> classNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'className',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> classNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'className',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> classNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'className',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> classNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'className',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> classNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'className',
        value: '',
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> classNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'className',
        value: '',
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> dateTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dateTime',
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> dateTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dateTime',
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> dateTimeEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> dateTimeGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> dateTimeLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> dateTimeBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> errorIndexIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'errorIndex',
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> errorIndexIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'errorIndex',
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> errorIndexEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'errorIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> errorIndexGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'errorIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> errorIndexLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'errorIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> errorIndexBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'errorIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> errorStringIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'errorString',
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> errorStringIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'errorString',
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> errorStringEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'errorString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> errorStringGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'errorString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> errorStringLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'errorString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> errorStringBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'errorString',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> errorStringStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'errorString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> errorStringEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'errorString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> errorStringContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'errorString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> errorStringMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'errorString',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> errorStringIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'errorString',
        value: '',
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition>
      errorStringIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'errorString',
        value: '',
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> groupIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'groupId',
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> groupIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'groupId',
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> groupIdEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'groupId',
        value: value,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> groupIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'groupId',
        value: value,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> groupIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'groupId',
        value: value,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> groupIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'groupId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> idGreaterThan(
    Id? value, {
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

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> idLessThan(
    Id? value, {
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

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> idBetween(
    Id? lower,
    Id? upper, {
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

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> launchIndexIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'launchIndex',
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> launchIndexIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'launchIndex',
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> launchIndexEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'launchIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> launchIndexGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'launchIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> launchIndexLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'launchIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> launchIndexBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'launchIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> logLevelIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'logLevel',
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> logLevelIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'logLevel',
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> logLevelEqualTo(
    EnumLogLevel? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'logLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> logLevelGreaterThan(
    EnumLogLevel? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'logLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> logLevelLessThan(
    EnumLogLevel? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'logLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> logLevelBetween(
    EnumLogLevel? lower,
    EnumLogLevel? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'logLevel',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> logLevelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'logLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> logLevelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'logLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> logLevelContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'logLevel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> logLevelMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'logLevel',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> logLevelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'logLevel',
        value: '',
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> logLevelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'logLevel',
        value: '',
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> logTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'logType',
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> logTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'logType',
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> logTypeEqualTo(
    EnumLogType? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'logType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> logTypeGreaterThan(
    EnumLogType? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'logType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> logTypeLessThan(
    EnumLogType? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'logType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> logTypeBetween(
    EnumLogType? lower,
    EnumLogType? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'logType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> logTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'logType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> logTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'logType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> logTypeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'logType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> logTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'logType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> logTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'logType',
        value: '',
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> logTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'logType',
        value: '',
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> logTypeGroupIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'logTypeGroup',
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition>
      logTypeGroupIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'logTypeGroup',
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> logTypeGroupEqualTo(
    EnumLogTypeGroup? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'logTypeGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> logTypeGroupGreaterThan(
    EnumLogTypeGroup? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'logTypeGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> logTypeGroupLessThan(
    EnumLogTypeGroup? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'logTypeGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> logTypeGroupBetween(
    EnumLogTypeGroup? lower,
    EnumLogTypeGroup? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'logTypeGroup',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> logTypeGroupStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'logTypeGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> logTypeGroupEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'logTypeGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> logTypeGroupContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'logTypeGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> logTypeGroupMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'logTypeGroup',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> logTypeGroupIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'logTypeGroup',
        value: '',
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition>
      logTypeGroupIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'logTypeGroup',
        value: '',
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> methodNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'methodName',
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> methodNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'methodName',
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> methodNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'methodName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> methodNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'methodName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> methodNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'methodName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> methodNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'methodName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> methodNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'methodName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> methodNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'methodName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> methodNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'methodName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> methodNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'methodName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> methodNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'methodName',
        value: '',
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> methodNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'methodName',
        value: '',
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition>
      stacktraceStringIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'stacktraceString',
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition>
      stacktraceStringIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'stacktraceString',
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> stacktraceStringEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stacktraceString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition>
      stacktraceStringGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stacktraceString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition>
      stacktraceStringLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stacktraceString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> stacktraceStringBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stacktraceString',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition>
      stacktraceStringStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'stacktraceString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition>
      stacktraceStringEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'stacktraceString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition>
      stacktraceStringContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'stacktraceString',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> stacktraceStringMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'stacktraceString',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition>
      stacktraceStringIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stacktraceString',
        value: '',
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition>
      stacktraceStringIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'stacktraceString',
        value: '',
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> statusIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'status',
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> statusIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'status',
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> statusEqualTo(
    EnumStatus? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> statusGreaterThan(
    EnumStatus? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> statusLessThan(
    EnumStatus? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> statusBetween(
    EnumStatus? lower,
    EnumStatus? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> statusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> statusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> statusContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> statusMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'status',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> textIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'text',
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> textIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'text',
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> textEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> textGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> textLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> textBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'text',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> textStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> textEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> textContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> textMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'text',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> textIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'text',
        value: '',
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> textIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'text',
        value: '',
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> timeZoneIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'timeZone',
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> timeZoneIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'timeZone',
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> timeZoneEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timeZone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> timeZoneGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timeZone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> timeZoneLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timeZone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> timeZoneBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timeZone',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> timeZoneStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'timeZone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> timeZoneEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'timeZone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> timeZoneContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'timeZone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> timeZoneMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'timeZone',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> timeZoneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timeZone',
        value: '',
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> timeZoneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'timeZone',
        value: '',
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> versionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'version',
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> versionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'version',
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> versionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'version',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> versionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'version',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> versionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'version',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> versionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'version',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> versionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'version',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> versionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'version',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> versionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'version',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> versionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'version',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> versionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'version',
        value: '',
      ));
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterFilterCondition> versionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'version',
        value: '',
      ));
    });
  }
}

extension LogInfoQueryObject
    on QueryBuilder<LogInfo, LogInfo, QFilterCondition> {}

extension LogInfoQueryLinks
    on QueryBuilder<LogInfo, LogInfo, QFilterCondition> {}

extension LogInfoQuerySortBy on QueryBuilder<LogInfo, LogInfo, QSortBy> {
  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> sortByClassName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'className', Sort.asc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> sortByClassNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'className', Sort.desc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> sortByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.asc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> sortByDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.desc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> sortByErrorIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'errorIndex', Sort.asc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> sortByErrorIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'errorIndex', Sort.desc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> sortByErrorString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'errorString', Sort.asc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> sortByErrorStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'errorString', Sort.desc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> sortByGroupId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupId', Sort.asc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> sortByGroupIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupId', Sort.desc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> sortByLaunchIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'launchIndex', Sort.asc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> sortByLaunchIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'launchIndex', Sort.desc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> sortByLogLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logLevel', Sort.asc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> sortByLogLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logLevel', Sort.desc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> sortByLogType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logType', Sort.asc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> sortByLogTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logType', Sort.desc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> sortByLogTypeGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logTypeGroup', Sort.asc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> sortByLogTypeGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logTypeGroup', Sort.desc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> sortByMethodName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'methodName', Sort.asc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> sortByMethodNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'methodName', Sort.desc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> sortByStacktraceString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stacktraceString', Sort.asc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> sortByStacktraceStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stacktraceString', Sort.desc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> sortByText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.asc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> sortByTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.desc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> sortByTimeZone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeZone', Sort.asc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> sortByTimeZoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeZone', Sort.desc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> sortByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.asc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> sortByVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.desc);
    });
  }
}

extension LogInfoQuerySortThenBy
    on QueryBuilder<LogInfo, LogInfo, QSortThenBy> {
  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> thenByClassName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'className', Sort.asc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> thenByClassNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'className', Sort.desc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> thenByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.asc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> thenByDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.desc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> thenByErrorIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'errorIndex', Sort.asc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> thenByErrorIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'errorIndex', Sort.desc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> thenByErrorString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'errorString', Sort.asc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> thenByErrorStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'errorString', Sort.desc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> thenByGroupId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupId', Sort.asc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> thenByGroupIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupId', Sort.desc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> thenByLaunchIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'launchIndex', Sort.asc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> thenByLaunchIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'launchIndex', Sort.desc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> thenByLogLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logLevel', Sort.asc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> thenByLogLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logLevel', Sort.desc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> thenByLogType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logType', Sort.asc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> thenByLogTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logType', Sort.desc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> thenByLogTypeGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logTypeGroup', Sort.asc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> thenByLogTypeGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logTypeGroup', Sort.desc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> thenByMethodName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'methodName', Sort.asc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> thenByMethodNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'methodName', Sort.desc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> thenByStacktraceString() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stacktraceString', Sort.asc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> thenByStacktraceStringDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stacktraceString', Sort.desc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> thenByText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.asc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> thenByTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.desc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> thenByTimeZone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeZone', Sort.asc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> thenByTimeZoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeZone', Sort.desc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> thenByVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.asc);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QAfterSortBy> thenByVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'version', Sort.desc);
    });
  }
}

extension LogInfoQueryWhereDistinct
    on QueryBuilder<LogInfo, LogInfo, QDistinct> {
  QueryBuilder<LogInfo, LogInfo, QDistinct> distinctByClassName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'className', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QDistinct> distinctByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateTime');
    });
  }

  QueryBuilder<LogInfo, LogInfo, QDistinct> distinctByErrorIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'errorIndex');
    });
  }

  QueryBuilder<LogInfo, LogInfo, QDistinct> distinctByErrorString(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'errorString', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QDistinct> distinctByGroupId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'groupId');
    });
  }

  QueryBuilder<LogInfo, LogInfo, QDistinct> distinctByLaunchIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'launchIndex');
    });
  }

  QueryBuilder<LogInfo, LogInfo, QDistinct> distinctByLogLevel(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'logLevel', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QDistinct> distinctByLogType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'logType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QDistinct> distinctByLogTypeGroup(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'logTypeGroup', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QDistinct> distinctByMethodName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'methodName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QDistinct> distinctByStacktraceString(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'stacktraceString',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QDistinct> distinctByStatus(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QDistinct> distinctByText(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'text', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QDistinct> distinctByTimeZone(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timeZone', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LogInfo, LogInfo, QDistinct> distinctByVersion(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'version', caseSensitive: caseSensitive);
    });
  }
}

extension LogInfoQueryProperty
    on QueryBuilder<LogInfo, LogInfo, QQueryProperty> {
  QueryBuilder<LogInfo, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<LogInfo, String?, QQueryOperations> classNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'className');
    });
  }

  QueryBuilder<LogInfo, DateTime?, QQueryOperations> dateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateTime');
    });
  }

  QueryBuilder<LogInfo, int?, QQueryOperations> errorIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'errorIndex');
    });
  }

  QueryBuilder<LogInfo, String?, QQueryOperations> errorStringProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'errorString');
    });
  }

  QueryBuilder<LogInfo, int?, QQueryOperations> groupIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'groupId');
    });
  }

  QueryBuilder<LogInfo, int?, QQueryOperations> launchIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'launchIndex');
    });
  }

  QueryBuilder<LogInfo, EnumLogLevel?, QQueryOperations> logLevelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'logLevel');
    });
  }

  QueryBuilder<LogInfo, EnumLogType?, QQueryOperations> logTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'logType');
    });
  }

  QueryBuilder<LogInfo, EnumLogTypeGroup?, QQueryOperations>
      logTypeGroupProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'logTypeGroup');
    });
  }

  QueryBuilder<LogInfo, String?, QQueryOperations> methodNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'methodName');
    });
  }

  QueryBuilder<LogInfo, String?, QQueryOperations> stacktraceStringProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stacktraceString');
    });
  }

  QueryBuilder<LogInfo, EnumStatus?, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<LogInfo, String?, QQueryOperations> textProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'text');
    });
  }

  QueryBuilder<LogInfo, String?, QQueryOperations> timeZoneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timeZone');
    });
  }

  QueryBuilder<LogInfo, String?, QQueryOperations> versionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'version');
    });
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogInfo _$LogInfoFromJson(Map<String, dynamic> json) => LogInfo(
      className: json['className'] as String?,
    )
      ..id = (json['localeId'] as num?)?.toInt()
      ..launchIndex = (json['launchIndex'] as num?)?.toInt()
      ..errorIndex = (json['errorIndex'] as num?)?.toInt()
      ..methodName = json['methodName'] as String?
      ..text = json['text'] as String?
      ..dateTime = json['dateTime'] == null
          ? null
          : DateTime.parse(json['dateTime'] as String)
      ..timeZone = json['timeZone'] as String?
      ..logType = $enumDecodeNullable(_$EnumLogTypeEnumMap, json['logType'])
      ..errorString = json['errorString'] as String?
      ..stacktraceString = json['stacktraceString'] as String?
      ..version = json['version'] as String?
      ..logLevel = $enumDecodeNullable(_$EnumLogLevelEnumMap, json['logLevel'])
      ..logTypeGroup =
          $enumDecodeNullable(_$EnumLogTypeGroupEnumMap, json['logTypeGroup'])
      ..status = $enumDecodeNullable(_$EnumStatusEnumMap, json['status'])
      ..groupId = (json['groupId'] as num?)?.toInt();

Map<String, dynamic> _$LogInfoToJson(LogInfo instance) => <String, dynamic>{
      'localeId': instance.id,
      'launchIndex': instance.launchIndex,
      'errorIndex': instance.errorIndex,
      'className': instance.className,
      'methodName': instance.methodName,
      'text': instance.text,
      'dateTime': instance.dateTime?.toIso8601String(),
      'timeZone': instance.timeZone,
      'logType': _$EnumLogTypeEnumMap[instance.logType],
      'errorString': instance.errorString,
      'stacktraceString': instance.stacktraceString,
      'version': instance.version,
      'logLevel': _$EnumLogLevelEnumMap[instance.logLevel],
      'logTypeGroup': _$EnumLogTypeGroupEnumMap[instance.logTypeGroup],
      'status': _$EnumStatusEnumMap[instance.status],
      'groupId': instance.groupId,
    };

const _$EnumLogTypeEnumMap = {
  EnumLogType.debug: 'DEBUG',
  EnumLogType.info: 'INFO',
  EnumLogType.warning: 'WARNING',
  EnumLogType.error: 'ERROR',
};

const _$EnumLogLevelEnumMap = {
  EnumLogLevel.high: 'HIGH',
  EnumLogLevel.medium: 'MEDIUM',
  EnumLogLevel.low: 'LOW',
};

const _$EnumLogTypeGroupEnumMap = {
  EnumLogTypeGroup.production: 'PRODUCTION',
  EnumLogTypeGroup.debug: 'DEBUG',
};

const _$EnumStatusEnumMap = {
  EnumStatus.unsent: 'UNSENT',
  EnumStatus.sent: 'SENT',
  EnumStatus.sending: 'SENDING',
};
