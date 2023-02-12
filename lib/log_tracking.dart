library log_tracking;
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:log_tracking/src/log_service.dart';
import 'package:log_tracking/src/model/device_info.dart';
import 'package:log_tracking/src/repo/index_repo.dart';
import 'package:log_tracking/src/repo/ngc_log_repo.dart';
import 'package:log_tracking/src/repo/ngc_log_status_repo.dart';
import 'package:log_tracking/src/utils/connectivity.dart';
import 'package:log_tracking/src/utils/util.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'src/enum/enum_log_level.dart';
import 'src/enum/enum_log_type.dart';
import 'src/enum/enum_log_type_group.dart';
import 'src/enum/enum_status.dart';
import 'src/model/ngc_log.dart';
import 'src/model/ngc_log_status.dart';

part 'src/logger.dart';
