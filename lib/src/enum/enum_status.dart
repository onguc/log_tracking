import 'package:hive_flutter/hive_flutter.dart';

import '../constant/hive_constants.dart';

part 'enum_status.g.dart';

/// Created by İrfan Öngüç
/// on 23.04.2022

@HiveType(typeId: HiveConstants.enumStatusTypeId)
enum EnumStatus {
  @HiveField(0)
  UNSENT,
  @HiveField(1)
  SENT,
  @HiveField(2)
  SENDING
}
