import 'package:hive_flutter/hive_flutter.dart';
import '../constant/hive_constants.dart';

part 'enum_log_type.g.dart';

/// Created by İrfan Öngüç
/// on 14 October 2020

@HiveType(typeId: HiveConstants.enumLogTypeId)
enum EnumLogType {
  @HiveField(0)
  ALL,
  @HiveField(1)
  TRACE,
  @HiveField(2)
  DEBUG,
  @HiveField(3)
  INFO,
  @HiveField(4)
  WARNING,
  @HiveField(5)
  ERROR,
  @HiveField(6)
  SEVERE,
  @HiveField(7)
  FATAL,
  @HiveField(8)
  OFF
}

class LogTypeConverter {
  /// Converts `LogLevel` to String
  static String fromEnumToString(EnumLogType type) {
    if (type == null) return "";
    return type.toString().split('.')[1];
  }

  /// String to `LogLevel`
  static EnumLogType fromStringToEnum(String? type) {
    return EnumLogType.values.firstWhere((e) => e.toString() == type);
  }
}
