import 'package:hive_flutter/adapters.dart';

import '../constant/hive_constants.dart';

part 'enum_log_type_group.g.dart';

/// Created by İrfan Öngüç
/// on 5.05.2022

@HiveType(typeId: HiveConstants.enumLogTypeGroupId)
enum EnumLogTypeGroup {
  @HiveField(0)
  PRODUCTION,
  @HiveField(1)
  DEBUG
}
