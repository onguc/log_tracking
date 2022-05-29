import 'package:hive_flutter/hive_flutter.dart';
import 'package:log_tracking/src/enum/enum_device_type.dart';

import '../../log_tracking.dart';
import '../constant/hive_constants.dart';
import '../enum/enum_log_level.dart';
import '../enum/enum_log_type.dart';
import '../enum/enum_log_type_group.dart';
import '../enum/enum_status.dart';
import '../model/ngc_log.dart';
import 'base_lazy_repo.dart';
import 'index_repo.dart';
import 'ngc_log_status_repo.dart';

/// Created by İrfan Öngüç
/// on 15.04.2022

/// Asıl logların kaydedilip yönetildiği erdir
class NgcLogRepo extends BaseLazyRepo<NgcLog> {
  static String _keyNgcLog = "ngcLogger";

  static NgcLogRepo? _instance;

  static NgcLogRepo get instance {
    if (_instance == null) _instance = NgcLogRepo._();
    return _instance!;
  }

  NgcLogRepo._();

  static initHive() async {
    bool isRegistered = Hive.isAdapterRegistered(HiveConstants.ngcLogTypeId);
    if (!isRegistered) {
      Hive.registerAdapter(NgcLogAdapter());
      Hive.registerAdapter(EnumLogTypeAdapter());
      Hive.registerAdapter(EnumLogLevelAdapter());
      Hive.registerAdapter(EnumLogTypeGroupAdapter());
      // Hive.registerAdapter(EnumDeviceTypeAdapter());
      await Hive.openLazyBox<NgcLog>(_keyNgcLog, compactionStrategy: ((entries, deletedEntries) {
        /// silinen dosya belirli bir sayıya gelince dosya boyutunu küçültmek için sıkıştırma (birleştirme) işlemi yapar
        return deletedEntries > 5000;
      }));
      int x = 0;
    }
  }

  @override
  String get keyTableName => _keyNgcLog;

  @override
  Future<void> save(NgcLog t) {
    t.keyId = "${IndexRepo.instance.indexKey}_${t.dateTime}_${t.logType!.name}";
    return super.save(t);
  }

  Future<List<NgcLog>> getNotSendedList() {
    return Future.value([]);
  }

  Future<List<NgcLog>> getLogsByIndexKeySet(Set<String> unsentLogKeySet) async {
    List<NgcLog> logs = [];
    for (String keyIndex in unsentLogKeySet) {
      Iterable keys = lazyBox.keys.where((element) => element.toString().startsWith(keyIndex));
      var list = await getLogs(keys);
      logs.addAll(list);
    }
    return logs;
  }

  Future<List<NgcLog>> getLastLogsByErrorLogKeyId(String keyId) async {
    var keyIndex = _getIndexKey(keyId);
    var keys = lazyBox.keys.where((element) => element.toString().startsWith(keyIndex));
    return getLogs(keys);
  }

  Future<List<NgcLog>> getLogs(Iterable keys) async {
    List<NgcLog> logs = [];
    for (String key in keys) {
      NgcLog? ngcLog = await getByKeyId(key);
      if (ngcLog != null) {
        logs.add(ngcLog);
      }
    }
    return logs;
  }

  static bool _isEnteredInDeleteMethode = false;

  Future<void> deleteLogsFrom7DaysAgo() async {
    if (!_isEnteredInDeleteMethode) {
      var statusRepo = NgcLogStatusRepo.instance;
      try {
        _isEnteredInDeleteMethode = true;
        var list = statusRepo.getAllLogStatusesFrom7DaysAgo();
        if (list.isNotEmpty) {
          Set<String> sentLogsIndexKeySet = list.where((element) => element.enumStatus == EnumStatus.SENT).map((e) => _getIndexKey(e.keyId!)).toSet();
          if (sentLogsIndexKeySet.isNotEmpty) {
            await _deleteNgcLogsByIndexKey(sentLogsIndexKeySet, statusRepo.getFilterKey()!);
            await statusRepo.deleteLogStatusesByIndexKey(sentLogsIndexKeySet);
          }
        }
      } on Exception catch (e) {
        _isEnteredInDeleteMethode = false;
        Log.e(e);
      }
    }
  }

  String _getIndexKey(String keyId) => keyId.split("_")[0];

  Future<void> _deleteNgcLogsByIndexKey(Set<String> logIndexKeySet, String filterKey) {
    List<String> logKeyList = [];
    logIndexKeySet.forEach((indexKey) {
      var logKeyListByIndex = lazyBox.keys.map((e) => e.toString()).where((element) => element.toString().startsWith(indexKey));
      logKeyListByIndex = logKeyListByIndex.where((element) => _isBoforeFilterKey(element, filterKey));
      logKeyList.addAll(logKeyListByIndex);
    });
    return deleteAllByKeys(logKeyList);
  }

  bool _isBoforeFilterKey(String element, String filterKey) => element.compareTo(filterKey) == -1 || element.compareTo(filterKey) == 0;

}
