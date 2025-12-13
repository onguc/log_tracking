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
class LogInfo extends BaseEntity {
  LogInfo({this.className}) {
    dateTime = DateTime.now();
    timeZone = dateTime!.timeZoneName;
  }

  int? launchIndex;
  // @Index()
  int? errorIndex;
  String? className;
  String? methodName;
  String? text;
  // @Index()
  DateTime? dateTime;
  String? timeZone;

  // @Enumerated(EnumType.name)
  EnumLogType? logType;
  String? errorString;
  String? stacktraceString;
  String? version;
  // @Enumerated(EnumType.name)
  EnumLogLevel? logLevel;
  // @Enumerated(EnumType.name)
  EnumLogTypeGroup? logTypeGroup;

  /// logun sunucuya gönderilme durumunu gösterir
  // @Index()
  // @Enumerated(EnumType.name)
  EnumStatus? status = EnumStatus.unsent;

  /// bir hata çıkana kadar olan logların grup id'si en son çıkan hataya kadar aynıdır. Hatadan sonraki logların groupId'si bir arttırılır
  int? groupId;

  // @ignore
  @JsonKey(includeFromJson: false, includeToJson: false)
  StackTrace? stackTrace;

  // String? logTypeString;
  dynamic _error;

  // @ignore
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
    return _toStringWithBox(useColors: false);
  }

  String toStringWithColorCode() {
    return _toStringWithBox(useColors: true);
  }

  String _toStringWithBox({required bool useColors}) {
    var color = useColors ? _logColor(logType) : (String s) => s;
    var typeName = logType?.name.toUpperCase() ?? "LOG";
    var time = dateTime?.toIso8601String() ?? "";
    var cls = className ?? "";
    var mth = methodName ?? "";
    var msg = text ?? "";

    // Charset selection
    var hChar = useColors ? "─" : "-";
    var vChar = useColors ? "│" : "|";
    var tlChar = useColors ? "┌" : "+";
    var trChar = useColors ? "┐" : "+";
    var blChar = useColors ? "└" : "+";
    var brChar = useColors ? "┘" : "+";
    var mStartChar = useColors ? "├" : "+";
    var mEndChar = useColors ? "┤" : "+";

    // Header Construction (calculate first to get exact length)
    var headerStart = "$tlChar$hChar [$typeName] $time | $cls | $mth ";
    
    var lines = msg.split('\n');
    var maxContentLen = 0;
    for (var line in lines) {
      if (line.length > maxContentLen) maxContentLen = line.length;
    }
    
    if (errorString != null) {
      var errLen = "ERROR: $errorString".length;
      if (errLen > maxContentLen) maxContentLen = errLen;
    }
    
    if (stacktraceString != null) {
      var stLines = stacktraceString!.split('\n');
      for (var line in stLines) {
        if (line.trim().length > maxContentLen) maxContentLen = line.trim().length;
      }
    }

    // Determine target width
    // Needs to accommodate header (+1 for closing char)
    // Needs to accommodate content (+4 for borders and padding)
    var minHeaderWidth = headerStart.length + 1;
    var minContentWidth = maxContentLen + 4;
    
    var targetWidth = minHeaderWidth > minContentWidth ? minHeaderWidth : minContentWidth;
    if (targetWidth < 50) targetWidth = 50;

    // Header
    var headerTotalPadding = targetWidth - headerStart.length - 1;
    if (headerTotalPadding < 0) headerTotalPadding = 0;
    var header = "$headerStart${"".padRight(headerTotalPadding, hChar)}$trChar";

    var footerPadding = targetWidth - 2;
    var footer = "$blChar${"".padRight(footerPadding, hChar)}$brChar";
    var separator = "$mStartChar${"".padRight(footerPadding, hChar)}$mEndChar";

    StringBuffer buffer = StringBuffer();
    buffer.writeln(color(header));

    String formatLine(String text) {
      var padding = targetWidth - text.length - 3; 
      if (padding < 0) padding = 0;
      return "$vChar $text".padRight(targetWidth - 1) + vChar;
    }

    for (var line in lines) {
       buffer.writeln(color(formatLine(line)));
    }

    if (errorString != null && errorString!.isNotEmpty) {
      buffer.writeln(color(separator));
      buffer.writeln(color(formatLine("ERROR: $errorString")));
    }

    if (stacktraceString != null && stacktraceString!.isNotEmpty) {
      buffer.writeln(color(separator));
      var stLines = stacktraceString!.split('\n');
      for (var line in stLines) {
        if (line.trim().isNotEmpty) {
           buffer.writeln(color(formatLine(line.trim())));
        }
      }
    }

    buffer.write(color(footer));
    return buffer.toString();
  }

  String Function(String) _logColor(EnumLogType? type) {
    switch (type) {
      case EnumLogType.error:
        return (s) => s.red;
      case EnumLogType.warning:
        return (s) => s.yellow;
      case EnumLogType.info:
        return (s) => s.blue;
      case EnumLogType.debug:
        return (s) => s.green;
      default:
        return (s) => s.white;
    }
  }

  final _spaces = {
    EnumLogType.info: "   ",
    EnumLogType.warning: "",
    EnumLogType.error: "  ",
    EnumLogType.debug: "  ",
  };


}
