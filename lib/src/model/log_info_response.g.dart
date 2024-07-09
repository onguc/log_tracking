// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogInfoResponse _$LogInfoResponseFromJson(Map<String, dynamic> json) =>
    LogInfoResponse()
      ..result = json['result'] as bool?
      ..resultCode = (json['resultCode'] as num?)?.toInt()
      ..resultMessage = json['resultMessage'] as String?;

Map<String, dynamic> _$LogInfoResponseToJson(LogInfoResponse instance) =>
    <String, dynamic>{
      'result': instance.result,
      'resultCode': instance.resultCode,
      'resultMessage': instance.resultMessage,
    };
