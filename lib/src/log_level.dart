/// Created by İrfan Öngüç
/// on 14 October 2020

enum EnumLogType { ALL, TRACE, DEBUG, INFO, WARNING, ERROR, SEVERE, FATAL, OFF }

class LogTypeConverter {
  /// Converts `LogLevel` to String
  static String fromEnumToString(EnumLogType type) {
    if (type == null) return "";
    return type.toString().split('.')[1];
  }

  /// String to `LogLevel`
  static EnumLogType fromStringToEnum(String type) {
    return EnumLogType.values.firstWhere((e) => e.toString() == type);
  }
}
