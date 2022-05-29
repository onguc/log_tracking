import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

import '../constant/hive_constants.dart';
import '../enum/enum_log_level.dart';
import '../enum/enum_log_type.dart';
import '../enum/enum_log_type_group.dart';
import '../utils/date_time_util.dart';
import '../utils/string_util.dart';
import 'base_hive_model.dart';

part 'ngc_log.g.dart';

/// Created by İrfan Öngüç
/// on 15.04.2022

@HiveType(typeId: HiveConstants.ngcLogTypeId)
@JsonSerializable()
class NgcLog extends BaseHiveModel {
  NgcLog({this.className}) {
    var now = DateTime.now();
    dateTime = DateTimeUtil.getDateTimeForLog(now);
    timeZone = now.timeZoneName;
  }

  @HiveField(0)
  String? className;
  @HiveField(1)
  String? methodName;
  @HiveField(2)
  String? text;
  @HiveField(3)
  String? dateTime;
  @HiveField(4)
  String? timeZone;

  // @JSONField(serialize: false, deserialize: false)
  @HiveField(5)
  EnumLogType? logType;
  @HiveField(6)
  String? errorString;
  @HiveField(7)
  String? stacktraceString;
  @HiveField(8)
  String? version;
  @HiveField(9)
  EnumLogLevel? logLevel;
  @HiveField(10)
  EnumLogTypeGroup? logTypeGroup;

  // String? logTypeString;
  dynamic _error;

  // EnumLogType get logType {
  //   if (_logType == null && StringUtil.isNotEmpty(logTypeString)) {
  //     _logType = LogTypeConverter.fromStringToEnum(logTypeString);
  //   }
  //   return _logType!;
  // }
  //
  // set logType(EnumLogType value) {
  //   _logType = value;
  //   logTypeString = value.name;
  // }

  dynamic get error {
    return _error;
  }

  set error(dynamic value) {
    errorString = value?.toString();
    _error = value;
  }

  @override
  String toString() {
    String errorStr = StringUtil.isNotEmpty(errorString) ? "\n-->ERROR-DETAIL: $errorString" : "";
    String stactraceStr = StringUtil.isNotEmpty(stacktraceString) ? "\n-->STACK-TRACE: $stacktraceString" : "";

    return "[${logType?.name}] [$version] [$dateTime][$timeZone]  [$className]  [$methodName]  $text  $errorStr  $stactraceStr";
  }

  String toStringWithColorCode() {
    String errorStr = StringUtil.isNotEmpty(errorString) ? "\n${_getColorRed("-->ERROR-DETAIL")}: $errorString" : "";
    String stactraceStr = StringUtil.isNotEmpty(stacktraceString) ? "\n${_getColorRed("-->STACK-TRACE")}: $stacktraceString" : "";

    return "[${_getColorLogType}]  [${_getColorCyan(dateTime!)}] [$className]  [$methodName]  ${_getColorBlue(text)}  $errorStr  $stactraceStr";
  }

  factory NgcLog.fromJson(Map<String, dynamic> json) => _$NgcLogFromJson(json);

  Map<String, dynamic> toJson() => _$NgcLogToJson(this);

  get _getColorLogType {
    var name = logType!.name;
    switch (logType) {
      case EnumLogType.ERROR:
        return _getColorRed(name);
      case EnumLogType.WARNING:
        return _getColorYellow(name);
      case EnumLogType.INFO:
        return _getColorGreen(name);
      default:
        return name;
    }
  }

  _getColorRed(String text) {
    return "\x1B[38;5;9m" + text + "\x1B[0m";
  }

  _getColorYellow(String text) {
    return "\x1B[38;5;11m" + text + "\x1B[0m";
  }

  _getColorGreen(String text) {
    return "\x1B[38;5;10m" + text + "\x1B[0m";
  }

  _getColorCyan(String text) {
    return "\x1B[38;5;14m" + text + "\x1B[0m";
  }

  _getColorBlue(String? text) {
    if (text == null) return "";
    return "\x1B[38;5;12m" + text + "\x1B[0m";
  }
}
