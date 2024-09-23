import 'package:log_tracking/src/enum/enum_log_type.dart';

extension ColorExtension on EnumLogType {
  String get red => this.name.toUpperCase().red;

  String get yellow => this.name.toUpperCase().yellow;

  String get green => this.name.toUpperCase().green;

  String get blue => this.name.toUpperCase().blue;

}

extension ColorExtensionString on String {
  String get red => "\x1B[38;5;9m$this\x1B[0m";

  String get yellow => "\x1B[38;5;11m$this\x1B[0m";

  String get green => "\x1B[38;5;10m$this\x1B[0m";

  String get cyan => "\x1B[38;5;14m$this\x1B[0m";

  String get blue => "\x1B[38;5;12m$this\x1B[0m";
}
