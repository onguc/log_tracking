// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_info.dart';

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
