import 'package:hive_flutter/adapters.dart';

import '../constant/hive_constants.dart';
import '../enum/enum_status.dart';
import 'base_hive_model.dart';

part 'ngc_log_status.g.dart';

/// Created by İrfan Öngüç
/// on 23.04.2022

@HiveType(typeId: HiveConstants.ngcLogStatusTypeId)
class NgcLogStatus extends BaseHiveModel {
  @HiveField(0)
  EnumStatus? enumStatus;
}
