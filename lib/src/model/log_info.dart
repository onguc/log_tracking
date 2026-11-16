import 'package:json_annotation/json_annotation.dart';
import 'package:log_tracking/src/enum/enum_status.dart';
import 'package:log_tracking/src/extensions/extension.dart';
import 'package:log_tracking/src/model/base_entity.dart';

import '../enum/enum_log_level.dart';
import '../enum/enum_log_type.dart';
import '../enum/enum_log_type_group.dart';
import '../utils/string_util.dart';

part 'log_info.g.dart';

/// A single log entry with device, location and error details.
@JsonSerializable()
class LogInfo extends BaseEntity {
  /// Creates the current time's log entry
  LogInfo({this.className}) {
    dateTime = DateTime.now();
    timeZone = dateTime!.timeZoneName;
  }

  // @Index()
  /// Index of the app launch that produced this log
  int? launchIndex;

  /// Index of the error group this log belongs to
  int? errorIndex;

  /// Name of the class that produced this log
  String? className;

  /// Name of the method that produced this log
  String? methodName;

  /// Log message
  String? text;
  // @Index()
  /// Time the log was created
  DateTime? dateTime;

  /// Time zone of [dateTime]
  String? timeZone;

  // @Enumerated(EnumType.name)
  /// Kind of this log
  EnumLogType? logType;

  /// String form of the logged error, if any
  String? errorString;

  /// String form of the stack trace, if any
  String? stacktraceString;

  /// Version of the app that produced this log
  String? version;
  // @Enumerated(EnumType.name)
  /// Severity of the logged error
  EnumLogLevel? logLevel;
  // @Enumerated(EnumType.name)
  /// Whether this log is kept in release builds
  EnumLogTypeGroup? logTypeGroup;

  // @Index()
  // @Enumerated(EnumType.name)
  /// logun sunucuya gönderilme durumunu gösterir
  EnumStatus? status = EnumStatus.unsent;

  /// bir hata çıkana kadar olan logların grup id'si en son çıkan hataya kadar aynıdır. Hatadan sonraki logların groupId'si bir arttırılır
  int? groupId;

  // @ignore
  /// Original stack trace object; not stored in JSON
  @JsonKey(includeFromJson: false, includeToJson: false)
  StackTrace? stackTrace;

  // String? logTypeString;
  dynamic _error;

  // @ignore
  /// The original error object; not stored in JSON
  @JsonKey(includeFromJson: false, includeToJson: false)
  dynamic get error {
    return _error;
  }

  /// Sets the error object and keeps its string form in [errorString]
  set error(dynamic value) {
    errorString = value?.toString();
    _error = value;
  }

  /// Creates a log entry from JSON
  factory LogInfo.fromJson(Map<String, dynamic> json) =>
      _$LogInfoFromJson(json);

  /// Converts this log entry to JSON
  Map<String, dynamic> toJson() => _$LogInfoToJson(this);

  @override
  String toString() {
    String errorStr =
        errorString.isNotEmpty ? "\n-->ERROR-DETAIL: $errorString" : "";
    String stacktraceStr = stacktraceString.isNotEmpty
        ? "\n-->STACK-TRACE: $stacktraceString"
        : "";
    var timeString = dateTime!.toIso8601String();
    var space = _spaces[logType] ?? "";

    return "[${logType?.name.toUpperCase()}]$space [$version] [$timeString][$timeZone]  [$className]  [$methodName]  $text  $errorStr  $stacktraceStr";
  }

  /// Plain text box representation used on iOS and macOS consoles
  String toStringForIos() {
    return _toStringWithBox(useColors: false);
  }

  /// Box representation with ANSI colors for desktop consoles
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

    // Header Construction
    var headerStart = "$tlChar$hChar [$typeName] $time | $cls | $mth ";

    // Calculate content width
    var lines = msg.split('\n');
    var maxContentLen = 0;

    // Helper to calculate max length
    void updateMaxLen(String s) {
      if (s.length > maxContentLen) maxContentLen = s.length;
    }

    for (var line in lines) {
      updateMaxLen(line);
    }

    if (errorString != null) {
      updateMaxLen("ERROR: $errorString");
    }

    if (stacktraceString != null) {
      var stLines = stacktraceString!.split('\n');
      for (var line in stLines) {
        updateMaxLen(line.trim());
      }
    }

    // Determine target width
    var minHeaderWidth = headerStart.length + 1;
    var minContentWidth = maxContentLen + 4; // +4 for "| " and " |"

    var targetWidth =
        minHeaderWidth > minContentWidth ? minHeaderWidth : minContentWidth;
    if (targetWidth < 50) targetWidth = 50;

    // Cap target width to avoid console truncation
    const int maxWidth = 120;
    if (targetWidth > maxWidth) targetWidth = maxWidth;

    // Header
    var headerTotalPadding = targetWidth - headerStart.length - 1;
    if (headerTotalPadding < 0) {
      headerTotalPadding = 0; // Should not happen if maxWidth > headerStart
    }

    // If header is too long for maxWidth, we might need to truncate it too, but let's assume header fits generally or just cut it.
    // Ideally we won't truncate header start, but the padding logic above handles it safely (0 padding).

    var header = "$headerStart${"".padRight(headerTotalPadding, hChar)}$trChar";
    // Check if header is actually wider than targetWidth (if headerStart itself was > maxWidth)
    if (header.length > targetWidth) {
      // This implies maxWidth is too small for header. Let's allow header to dictate min width if it exceeds maxWidth?
      // Or just truncate header? Better to let it be slightly wider or truncate.
      // For safety, let's keep targetWidth at least as big as headerStart + 2
      if (targetWidth < headerStart.length + 1) {
        targetWidth = headerStart.length + 1;
        // Recalculate header with 0 padding
        header = "$headerStart$trChar";
      }
    }

    var footerPadding = targetWidth - 2;
    // ensure non-negative
    if (footerPadding < 0) footerPadding = 0;

    var footer = "$blChar${"".padRight(footerPadding, hChar)}$brChar";
    var separator = "$mStartChar${"".padRight(footerPadding, hChar)}$mEndChar";

    StringBuffer buffer = StringBuffer();
    buffer.writeln(color(header));

    // Helper to wrap and format lines
    void writeWrapped(String text) {
      // Available content width
      // "| " + content + " |"
      // content width = targetWidth - 4
      var contentWidth = targetWidth - 4;
      if (contentWidth < 1) contentWidth = 1;

      var currentText = text;

      while (currentText.length > contentWidth) {
        var chunk = currentText.substring(0, contentWidth);
        currentText = currentText.substring(contentWidth);
        buffer.writeln(color("$vChar ${chunk.padRight(contentWidth)} $vChar"));
      }
      if (currentText.isNotEmpty) {
        buffer.writeln(
            color("$vChar ${currentText.padRight(contentWidth)} $vChar"));
      }
    }

    for (var line in lines) {
      writeWrapped(line);
    }

    if (errorString != null && errorString!.isNotEmpty) {
      buffer.writeln(color(separator));
      writeWrapped("ERROR: $errorString");
    }

    if (stacktraceString != null && stacktraceString!.isNotEmpty) {
      buffer.writeln(color(separator));
      var stLines = stacktraceString!.split('\n');
      for (var line in stLines) {
        if (line.trim().isNotEmpty) {
          writeWrapped(line.trim());
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
