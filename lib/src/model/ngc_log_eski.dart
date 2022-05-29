// import 'package:tikutu_app/log/src/utils/string_util.dart';
//
// import '../enum/enum_log_type.dart';
//
// /// Created by İrfan Öngüç
// /// on 14 October 2020
//
// class NgcLog {
//   NgcLog({this.className});
//
//   int? id;
//   String? className;
//   String? methodName;
//   String? text;
//   String? dateTime;
//
//   // @JSONField(serialize: false, deserialize: false)
//   dynamic _error;
//   String? errorString;
//   String? logTypeString;
//
//   // @JSONField(serialize: false, deserialize: false)
//   EnumLogType? _logType;
//   String? stacktraceString;
//
//   String? version;
//   String? createDate;
//
//   EnumLogType get logType {
//     if (_logType == null && StringUtil.isNotEmpty(logTypeString)) {
//       _logType = LogTypeConverter.fromStringToEnum(logTypeString);
//     }
//     return _logType!;
//   }
//
//   set logType(EnumLogType value) {
//     _logType = value;
//     logTypeString = LogTypeConverter.fromEnumToString(value);
//   }
//
//   dynamic get error {
//     return _error;
//   }
//
//   set error(dynamic value) {
//     errorString = value?.toString();
//     _error = value;
//   }
//
//   @override
//   int? getId() {
//     return id;
//   }
//
//   @override
//   int getAwsId() {
//     throw UnimplementedError();
//   }
//
//   @override
//   String toString() {
//     String errorStr =
//         StringUtil.isNotEmpty(errorString) ? "\n[$errorString]" : "";
//     String stactraceStr = StringUtil.isNotEmpty(stacktraceString)
//         ? "\n[$stacktraceString]"
//         : "";
//
//     return "[$logTypeString] [$version] [$dateTime]  [$className]  [$methodName]  $text  $errorStr  $stactraceStr";
//     // return "[${_getColorLogType(logTypeString)}]  [${_getColorCyan(dateTime)}]  [$className]  [$methodName]  [${_getColorBlue(text)}]  [$errorString]  [$stacktraceString]";
//   }
//
//   _getColorLogType(String text) {
//     switch (logType) {
//       case EnumLogType.ERROR:
//         return _getColorRed(text);
//       case EnumLogType.WARNING:
//         return _getColorYellow(text);
//       case EnumLogType.INFO:
//         return _getColorGreen(text);
//       default:
//         return text;
//     }
//     return "[38;5;9m" + text + "[0m";
//   }
//
//   _getColorRed(String text) {
//     return "[38;5;9m" + text + "[0m";
//   }
//
//   _getColorYellow(String text) {
//     return "[38;5;11m" + text + "[0m";
//   }
//
//   _getColorGreen(String text) {
//     return "[38;5;10m" + text + "[0m";
//   }
//
//   _getColorCyan(String text) {
//     return "[38;5;14m" + text + "[0m";
//   }
//
//   _getColorBlue(String text) {
//     return "[38;5;12m" + text + "[0m";
//   }
// }
