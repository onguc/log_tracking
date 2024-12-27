// import 'package:json_annotation/json_annotation.dart';
// import 'package:log_tracking/src/enum/enum_log_level.dart';
// import 'package:log_tracking/src/enum/enum_log_type.dart';
// import 'package:log_tracking/src/enum/enum_log_type_group.dart';
// import 'package:log_tracking/src/enum/enum_status.dart';
// import 'package:log_tracking/src/extensions/extension.dart';
// import 'package:realm/realm.dart';
//
// part 'log_info_2.g.dart';
// part 'app.realm.dart';
// @RealmModel()
// @JsonSerializable()
// class _LogInfo {
//   @PrimaryKey()
//   @JsonKey(includeFromJson: false, includeToJson: false)
//   late ObjectId id;
//
//   late int? launchIndex;
//
//   @Indexed()
//   late int? errorIndex;
//
//   late String? className;
//   late String? methodName;
//   late String? text;
//
//   @Indexed()
//   late DateTime dateTime;
//
//   late String? timeZone;
//   late String? logType; // EnumLogType string olarak tutulacak
//   late String? errorString;
//   late String? stacktraceString;
//   late String? version;
//   late String? logLevel; // EnumLogLevel string olarak tutulacak
//   late String? logTypeGroup; // EnumLogTypeGroup string olarak tutulacak
//
//   @Indexed()
//   late String status = 'unsent'; // EnumStatus string olarak tutulacak
//
//   late int? groupId;
//
//   // Realm'de ignore edilecek alanlar
//   @Ignored()
//   StackTrace? stackTrace;
//
//   @Ignored()
//   dynamic _error;
// }
//
// // Extension metotları için yardımcı sınıf
// class LogInfo extends _LogInfo with RealmObject {
//   LogInfo({String? className}) {
//     this.className = className;
//     dateTime = DateTime.now();
//     timeZone = dateTime.timeZoneName;
//     id = ObjectId();
//   }
//
//   // Enum dönüşümleri için getter ve setterlar
//   EnumLogType? get logTypeEnum =>
//       logType != null ? EnumLogType.values.byName(logType!) : null;
//
//   set logTypeEnum(EnumLogType? value) {
//     logType = value?.name;
//   }
//
//   EnumLogLevel? get logLevelEnum =>
//       logLevel != null ? EnumLogLevel.values.byName(logLevel!) : null;
//
//   set logLevelEnum(EnumLogLevel? value) {
//     logLevel = value?.name;
//   }
//
//   EnumLogTypeGroup? get logTypeGroupEnum =>
//       logTypeGroup != null ? EnumLogTypeGroup.values.byName(logTypeGroup!) : null;
//
//   set logTypeGroupEnum(EnumLogTypeGroup? value) {
//     logTypeGroup = value?.name;
//   }
//
//   EnumStatus get statusEnum =>
//       EnumStatus.values.byName(status);
//
//   set statusEnum(EnumStatus value) {
//     status = value.name;
//   }
//
//   dynamic get error => _error;
//
//   set error(dynamic value) {
//     errorString = value?.toString();
//     _error = value;
//   }
//
//   // JSON dönüşümleri
//   factory LogInfo.fromJson(Map<String, dynamic> json) => _$LogInfoFromJson(json);
//   Map<String, dynamic> toJson() => _$LogInfoToJson(this);
//
//   // ToString metodları
//   final _spaces = {
//     'info': "   ",
//     'warning': "",
//     'error': "  ",
//     'debug': "  ",
//   };
//
//   final _coloredLogTypes = {
//     'error': 'ERROR'.red,
//     'warning': 'WARNING'.yellow,
//     'info': 'INFO'.blue,
//     'debug': 'DEBUG'.green
//   };
//
//   @override
//   String toString() {
//     String errorStr = errorString?.isNotEmpty == true
//         ? "\n-->ERROR-DETAIL: $errorString"
//         : "";
//     String stacktraceStr = stacktraceString?.isNotEmpty == true
//         ? "\n-->STACK-TRACE: $stacktraceString"
//         : "";
//     var timeString = dateTime.toIso8601String();
//     var space = _spaces[logType?.toLowerCase()] ?? "";
//     return "[${logType?.toUpperCase()}]$space [$version] [$timeString][$timeZone] [$className] [$methodName] $text $errorStr $stacktraceStr";
//   }
//
//   String toStringForIos() {
//     String errorStr = errorString?.isNotEmpty == true
//         ? "\n-->ERROR-DETAIL: $_error"
//         : "";
//     String stactraceStr = stacktraceString?.isNotEmpty == true
//         ? "\n-->STACK-TRACE: $stacktraceString"
//         : "";
//     var timeString = dateTime.toIso8601String();
//     var space = _spaces[logType?.toLowerCase()] ?? "";
//     return "[${logType?.toUpperCase()}]$space [$version] [$timeString][$timeZone] [$className] [$methodName] $text $errorStr $stactraceStr";
//   }
//
//   String toStringWithColorCode() {
//     String errorStr = errorString?.isNotEmpty == true
//         ? "\n${"-->ERROR-DETAIL".red}: $errorString"
//         : "";
//     String stactraceStr = stacktraceString?.isNotEmpty == true
//         ? "\n${"-->STACK-TRACE".red}: $stacktraceString"
//         : "";
//     var timeString = dateTime.toIso8601String();
//     var space = _spaces[logType?.toLowerCase()] ?? "";
//     var coloredLogType = _coloredLogTypes[logType?.toLowerCase()] ?? logType?.toUpperCase();
//     var coloredText = logType?.toLowerCase() == 'warning' ? text?.yellow : text?.blue;
//     return "[$coloredLogType]$space [${timeString.cyan}] [$className] [$methodName] $coloredText $errorStr $stactraceStr";
//   }
// }