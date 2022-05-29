// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ngc_log.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NgcLogAdapter extends TypeAdapter<NgcLog> {
  @override
  final int typeId = 4;

  @override
  NgcLog read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NgcLog(
      className: fields[0] as String?,
    )
      ..methodName = fields[1] as String?
      ..text = fields[2] as String?
      ..dateTime = fields[3] as String?
      ..timeZone = fields[4] as String?
      ..logType = fields[5] as EnumLogType?
      ..errorString = fields[6] as String?
      ..stacktraceString = fields[7] as String?
      ..version = fields[8] as String?
      ..logLevel = fields[9] as EnumLogLevel?
      ..logTypeGroup = fields[10] as EnumLogTypeGroup?;
  }

  @override
  void write(BinaryWriter writer, NgcLog obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.className)
      ..writeByte(1)
      ..write(obj.methodName)
      ..writeByte(2)
      ..write(obj.text)
      ..writeByte(3)
      ..write(obj.dateTime)
      ..writeByte(4)
      ..write(obj.timeZone)
      ..writeByte(5)
      ..write(obj.logType)
      ..writeByte(6)
      ..write(obj.errorString)
      ..writeByte(7)
      ..write(obj.stacktraceString)
      ..writeByte(8)
      ..write(obj.version)
      ..writeByte(9)
      ..write(obj.logLevel)
      ..writeByte(10)
      ..write(obj.logTypeGroup);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NgcLogAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NgcLog _$NgcLogFromJson(Map<String, dynamic> json) => NgcLog(
      className: json['className'] as String?,
    )
      ..keyId = json['keyId'] as String?
      ..methodName = json['methodName'] as String?
      ..text = json['text'] as String?
      ..dateTime = json['dateTime'] as String?
      ..timeZone = json['timeZone'] as String?
      ..logType = $enumDecodeNullable(_$EnumLogTypeEnumMap, json['logType'])
      ..errorString = json['errorString'] as String?
      ..stacktraceString = json['stacktraceString'] as String?
      ..version = json['version'] as String?
      ..logLevel = $enumDecodeNullable(_$EnumLogLevelEnumMap, json['logLevel'])
      ..logTypeGroup =
          $enumDecodeNullable(_$EnumLogTypeGroupEnumMap, json['logTypeGroup'])
      ..error = json['error'];

Map<String, dynamic> _$NgcLogToJson(NgcLog instance) => <String, dynamic>{
      'keyId': instance.keyId,
      'className': instance.className,
      'methodName': instance.methodName,
      'text': instance.text,
      'dateTime': instance.dateTime,
      'timeZone': instance.timeZone,
      'logType': _$EnumLogTypeEnumMap[instance.logType],
      'errorString': instance.errorString,
      'stacktraceString': instance.stacktraceString,
      'version': instance.version,
      'logLevel': _$EnumLogLevelEnumMap[instance.logLevel],
      'logTypeGroup': _$EnumLogTypeGroupEnumMap[instance.logTypeGroup],
      'error': instance.error,
    };

const _$EnumLogTypeEnumMap = {
  EnumLogType.ALL: 'ALL',
  EnumLogType.TRACE: 'TRACE',
  EnumLogType.DEBUG: 'DEBUG',
  EnumLogType.INFO: 'INFO',
  EnumLogType.WARNING: 'WARNING',
  EnumLogType.ERROR: 'ERROR',
  EnumLogType.SEVERE: 'SEVERE',
  EnumLogType.FATAL: 'FATAL',
  EnumLogType.OFF: 'OFF',
};

const _$EnumLogLevelEnumMap = {
  EnumLogLevel.HIGH: 'HIGH',
  EnumLogLevel.MEDIUM: 'MEDIUM',
  EnumLogLevel.LOW: 'LOW',
};

const _$EnumLogTypeGroupEnumMap = {
  EnumLogTypeGroup.PRODUCTION: 'PRODUCTION',
  EnumLogTypeGroup.DEBUG: 'DEBUG',
};
