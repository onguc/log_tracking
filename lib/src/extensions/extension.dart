import 'package:log_tracking/src/enum/enum_log_type.dart';

/// Colored versions of the log type name
extension ColorExtension on EnumLogType {
  /// Name in red
  String get red => name.toUpperCase().red;

  /// Name in yellow
  String get yellow => name.toUpperCase().yellow;

  /// Name in green
  String get green => name.toUpperCase().green;

  /// Name in blue
  String get blue => name.toUpperCase().blue;
}

/// ANSI color escape codes for console output
extension ColorExtensionString on String {
  /// This string in red
  String get red => "\x1B[38;5;9m$this\x1B[0m";

  /// This string in yellow
  String get yellow => "\x1B[38;5;11m$this\x1B[0m";

  /// This string in green
  String get green => "\x1B[38;5;10m$this\x1B[0m";

  /// This string in cyan
  String get cyan => "\x1B[38;5;14m$this\x1B[0m";

  /// This string in blue
  String get blue => "\x1B[38;5;12m$this\x1B[0m";

  /// This string in white
  String get white => "\x1B[38;5;15m$this\x1B[0m";
}
