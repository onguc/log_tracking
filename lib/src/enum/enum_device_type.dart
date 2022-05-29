import 'package:hive_flutter/adapters.dart';
import '../constant/hive_constants.dart';

// part 'enum_device_type.g.dart';

/// Created by İrfan Öngüç
/// on 5.05.2022

// @HiveType(typeId: HiveConstants.enumDeviceTypeTypeId)
enum EnumDeviceType {
  // @HiveField(0)
  ANDROID,
  // @HiveField(1)
  IOS,
  // @HiveField(2)
  MACOS,
  // @HiveField(3)
  LINUX,
  // @HiveField(4)
  WINDOWS,
  // @HiveField(5)
  WEB,
  // @HiveField(6)
  UNKNOWN
}
