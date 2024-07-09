import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:log_tracking/src/enum/enum_status.dart';
import 'package:log_tracking/src/model/base_entity.dart';

import '../enum/enum_log_level.dart';
import '../enum/enum_log_type.dart';
import '../enum/enum_log_type_group.dart';
import '../utils/date_time_util.dart';
import '../utils/string_util.dart';

part 'log_info.g.dart';

@JsonSerializable()
@collection
class LogInfo extends BaseEntity {
  LogInfo({this.className}) {
    dateTime = DateTime.now();
    timeZone = dateTime!.timeZoneName;
  }

  int? launchIndex;
  @Index()
  int? errorIndex;
  String? className;
  String? methodName;
  String? text;
  @Index()
  DateTime? dateTime;
  String? timeZone;

  @Enumerated(EnumType.name)
  EnumLogType? logType;
  String? errorString;
  String? stacktraceString;
  String? version;
  @Enumerated(EnumType.name)
  EnumLogLevel? logLevel;
  @Enumerated(EnumType.name)
  EnumLogTypeGroup? logTypeGroup;

  /// logun sunucuya gönderilme durumunu gösterir
  @Index()
  @Enumerated(EnumType.name)
  EnumStatus? status;

  /// bir hata çıkana kadar olan logların grup id'si en son çıkan hataya kadar aynıdır. Hatadan sonraki logların groupId'si bir arttırılır
  int? groupId;

  @ignore
  @JsonKey(includeFromJson: false, includeToJson: false)
  StackTrace? stackTrace;

  // String? logTypeString;
  dynamic _error;

  @ignore
  @JsonKey(includeFromJson: false, includeToJson: false)
  dynamic get error {
    return _error;
  }

  set error(dynamic value) {
    errorString = value?.toString();
    _error = value;
  }

  factory LogInfo.fromJson(Map<String, dynamic> json) => _$LogInfoFromJson(json);

  Map<String, dynamic> toJson() => _$LogInfoToJson(this);

  @override
  String toString() {
    String errorStr = errorString.isNotEmpty ? "\n-->ERROR-DETAIL: $errorString" : "";
    String stacktraceStr = stacktraceString.isNotEmpty ? "\n-->STACK-TRACE: $stacktraceString" : "";
    var timeString = DateTimeUtil.getDateTimeForLog(dateTime!);

    return "[${logType?.name}] [$version] [$timeString][$timeZone]  [$className]  [$methodName]  $text  $errorStr  $stacktraceStr";
  }

  String toStringForIos() {
    String errorStr = errorString.isNotEmpty ? "\n-->ERROR-DETAIL: $_error" : "";
    String stactraceStr = stacktraceString.isNotEmpty ? "\n-->STACK-TRACE: $stacktraceString" : "";
    var timeString = DateTimeUtil.getDateTimeForLog(dateTime!);

    return "[${logType?.name}] [$version] [$timeString][$timeZone]  [$className]  [$methodName]  $text  $errorStr  $stactraceStr";
  }

  String toStringWithColorCode() {
    String errorStr = errorString.isNotEmpty ? "\n${_getColorRed("-->ERROR-DETAIL")}: $errorString" : "";
    String stactraceStr = stacktraceString.isNotEmpty ? "\n${_getColorRed("-->STACK-TRACE")}: $stacktraceString" : "";
    var timeString = DateTimeUtil.getDateTimeForLog(dateTime!);

    return "[${_getColorLogType}]  [${_getColorCyan(timeString)}] [$className]  [$methodName]  ${_getColorBlue(text)}  $errorStr  $stactraceStr";
  }

  get _getColorLogType {
    var name = logType!.name;
    switch (logType) {
      case EnumLogType.error:
        return _getColorRed(name);
      case EnumLogType.warning:
        return _getColorYellow(name);
      case EnumLogType.info:
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
