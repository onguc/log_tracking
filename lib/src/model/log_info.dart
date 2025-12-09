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

    const int boxWidth = 120;
    
    // Header setup
    var headerStart = "┌─ [$typeName] $time | $cls | $mth ";
    var headerLineLength = boxWidth - headerStart.length - 1; // -1 for corner
    var headerLine = "";
    if (headerLineLength > 0) {
      headerLine = "".padRight(headerLineLength, "─");
    }
    var header = "$headerStart$headerLine┐";

    var footerLineLength = boxWidth - 2; // -2 for corners
    var footer = "└${"".padRight(footerLineLength, "─")}┘";
    
    var separatorLineLength = boxWidth - 2; // -2 for corners
    var separator = "├${"".padRight(separatorLineLength, "─")}┤";

    StringBuffer buffer = StringBuffer();
    buffer.writeln(color(header));
    
    // Content formatter
    String formatLine(String text) {
      // Basic wrapping could be added here, but for now we truncate or pad
      // To strictly close the box, we must ensure length is exactly boxWidth
      // | text (pad) |
      
      var contentWidth = boxWidth - 4; // "| " + " |"
      if (text.length > contentWidth) {
         // simple truncate for now or let it overflow?
         // user asked for a box, overflow breaks the box.
         // Let's split if too long?
         // For simplicity and speed in this iteration, let's just print multiple lines if long
      }
      
      // We will handle multi-line text by splitting first
      return "│ $text".padRight(boxWidth - 1) + "│";
    }

    // Message
    var msgLines = msg.split('\n');
    for(var line in msgLines) {
       // Handle very long lines by splitting them
       var contentWidth = boxWidth - 4;
       if (line.length > contentWidth) {
         int start = 0;
         while (start < line.length) {
            int end = start + contentWidth;
            if (end > line.length) end = line.length;
            buffer.writeln(color(formatLine(line.substring(start, end))));
            start += contentWidth;
         }
       } else {
         buffer.writeln(color(formatLine(line)));
       }
    }

    if (errorString != null && errorString!.isNotEmpty) {
      buffer.writeln(color(separator));
      buffer.writeln(color(formatLine("ERROR: $errorString")));
    }

    if (stacktraceString != null && stacktraceString!.isNotEmpty) {
      buffer.writeln(color(separator));
      var lines = stacktraceString!.split('\n');
      for (var line in lines) {
        if (line.trim().isNotEmpty) {
           var cleanLine = line.trim();
           var contentWidth = boxWidth - 4;
           if (cleanLine.length > contentWidth) {
             int start = 0;
             while (start < cleanLine.length) {
                int end = start + contentWidth;
                if (end > cleanLine.length) end = cleanLine.length;
                buffer.writeln(color(formatLine(cleanLine.substring(start, end))));
                start += contentWidth;
             }
           } else {
             buffer.writeln(color(formatLine(cleanLine)));
           }
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

  final _coloredLogTypes = {
    EnumLogType.error: EnumLogType.error.red,
    EnumLogType.warning: EnumLogType.warning.yellow,
    EnumLogType.info: EnumLogType.info.blue,
    EnumLogType.debug: EnumLogType.debug.green
  };
}
