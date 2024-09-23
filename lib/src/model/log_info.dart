import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:log_tracking/src/enum/enum_status.dart';
import 'package:log_tracking/src/extensions/extension.dart';
import 'package:log_tracking/src/model/base_entity.dart';

import '../enum/enum_log_level.dart';
import '../enum/enum_log_type.dart';
import '../enum/enum_log_type_group.dart';
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
  EnumStatus? status = EnumStatus.unsent;

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
    var timeString = dateTime!.toIso8601String();
    var space = _spaces[logType] ?? "";

    return "[${logType?.name.toUpperCase()}]$space [$version] [$timeString][$timeZone]  [$className]  [$methodName]  $text  $errorStr  $stacktraceStr";
  }

  String toStringForIos() {
    String errorStr = errorString.isNotEmpty ? "\n-->ERROR-DETAIL: $_error" : "";
    String stactraceStr = stacktraceString.isNotEmpty ? "\n-->STACK-TRACE: $stacktraceString" : "";
    var timeString = dateTime!.toIso8601String();
    var space = _spaces[logType] ?? "";

    return "[${logType?.name.toUpperCase()}]$space [$version] [$timeString][$timeZone]  [$className]  [$methodName]  $text  $errorStr  $stactraceStr";
  }

  String toStringWithColorCode() {
    String errorStr = errorString.isNotEmpty ? "\n${"-->ERROR-DETAIL".red}: $errorString" : "";
    String stactraceStr = stacktraceString.isNotEmpty ? "\n${"-->STACK-TRACE".red}: $stacktraceString" : "";
    var timeString = dateTime!.toIso8601String();
    var space = _spaces[logType] ?? "";
    var coloredLogType = _coloredLogTypes[logType] ?? logType!.name.toUpperCase();
    var coloredText = logType == EnumLogType.warning ? text?.yellow : text?.blue;
    return "[$coloredLogType]$space [${timeString.cyan}] [$className]  [$methodName]  $coloredText  $errorStr  $stactraceStr";
  }

  final _spaces = {
    EnumLogType.info: "   ",
    EnumLogType.warning: "",
    EnumLogType.error: "  ",
    EnumLogType.debug: "  ",
  };

  final _coloredLogTypes = {
    EnumLogType.error: EnumLogType.error.red,
    EnumLogType.warning: EnumLogType.warning.yellow,
    EnumLogType.info: EnumLogType.info.blue,
    EnumLogType.debug: EnumLogType.debug.green
  };
}
