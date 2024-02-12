import 'package:hive_flutter/adapters.dart';

import '../constant/hive_constants.dart';

part 'enum_log_level.g.dart';

/// Created by İrfan Öngüç
/// on 5.05.2022

@HiveType(typeId: HiveConstants.enumLogLevelId)
enum EnumLogLevel {
  @HiveField(0)
  HIGH,
  @HiveField(1)
  MEDIUM,
  @HiveField(2)
  LOW,
}