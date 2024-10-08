import 'package:isar/isar.dart';
import 'package:log_tracking/src/repo/base_repo.dart';
import 'package:log_tracking/src/repo/key_value_repo.dart';

import '../../log_tracking.dart';
import '../enum/enum_status.dart';
import '../model/log_info.dart';

/// Asıl logların kaydedilip yönetildiği yerdir
class LogInfoRepo extends BaseRepo<LogInfo> {
  static LogInfoRepo? _instance;

  static LogInfoRepo get instance {
    _instance ??= LogInfoRepo._();
    return _instance!;
  }

  LogInfoRepo._();

  @override
  Future<int> save(LogInfo t) {
    if (t.id == null) {
      var repo = KeyValueRepo.instance;
      t.launchIndex = repo.appLaunchIndex;
      t.errorIndex = repo.errorIndex;
    }
    return super.save(t);
  }

  Future<List<LogInfo?>> getLogs(List<int> ids) {
    return getAllByIds(ids);
  }

  bool _isEnteredInDeleteMethode = false;

  /// 7 gün önceki logları siler.
  Future<int?> deleteLogsFrom7DaysAgo() async {
    if (!_isEnteredInDeleteMethode) {
      try {
        _isEnteredInDeleteMethode = true;
        DateTime date7DaysAgo = DateTime.now().subtract(const Duration(days: 7));
        List<LogInfo> logs7DaysAgo = await baseCollection.filter().dateTimeLessThan(date7DaysAgo).statusEqualTo(EnumStatus.sent).findAll();
        if (logs7DaysAgo.isNotEmpty) {
          var idList = logs7DaysAgo.map((e) => e.id!).toList();
          int count = await deleteAllByIds(idList);
          return count;
        }
        return 0;
      } on Exception catch (e) {
        _isEnteredInDeleteMethode = false;
        Log.e(e);
      }
    }
    return null;
  }

  Future<List<LogInfo>> getUnsentLogs() async {
    var list = await baseCollection.filter().statusEqualTo(EnumStatus.unsent).findAll();
    return list;
  }

  Future<List<LogInfo>> getUnsentLogByErrorIndex(int errorIndex) async {
    var list = await baseCollection.filter().errorIndexEqualTo(errorIndex).statusEqualTo(EnumStatus.unsent).findAll();
    return list;
  }
}
