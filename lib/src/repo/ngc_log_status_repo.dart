import 'package:hive_flutter/hive_flutter.dart';
import '../../log_tracking.dart';
import '../constant/hive_constants.dart';
import '../enum/enum_status.dart';
import '../model/ngc_log_status.dart';
import '../utils/date_time_util.dart';
import 'base_repo.dart';

/// Created by İrfan Öngüç
/// on 23.04.2022

/// Log'ların sunucuya gönderilme durumlarını tutup yönettiğimiz yerdir
/// Sadece bastırıldığında sunucuya gönderilmesi gereken logların gönderilme bilgisi tutulur
/// Info düzeydeki loglar tutulmaz
class NgcLogStatusRepo extends BaseRepo<NgcLogStatus> {
  static String _keyNgcLogStatus = "ngcLogStatus";
  final int keptDays = 7;

  /// belirlenen tarihten önceki logları getirmek için bu keyi kullıyoruz.
  /// örneğin 7 gün önceki logları getireceksek 7 gün önce basılmış olan en son log'un key değeridir.
  String? _filterKey;
  static NgcLogStatusRepo? _instance;

  static initHive() async {
    bool isRegistered = Hive.isAdapterRegistered(HiveConstants.ngcLogStatusTypeId);
    if (!isRegistered) {
      Hive.registerAdapter(EnumStatusAdapter());
      Hive.registerAdapter(NgcLogStatusAdapter());
      await Hive.openBox<NgcLogStatus>(_keyNgcLogStatus, compactionStrategy: ((entries, deletedEntries) {
        /// silinen dosya belirli bir sayıya gelince dosya boyutunu küçültmek için sıkıştırma (birleştirme) işlemi yapar
        return deletedEntries > 1000;
      }));
    }
  }

  static NgcLogStatusRepo get instance {
    if (_instance == null) _instance = NgcLogStatusRepo._();
    return _instance!;
  }

  NgcLogStatusRepo._();

  Iterable<NgcLogStatus> getLogStatusesUnsent() {
    if (box.keys.isEmpty) return Set();
    var iterable = box.values.where((element) => element.enumStatus == EnumStatus.UNSENT);
    return iterable;
  }

  Iterable<NgcLogStatus> getAllLogStatusesFrom7DaysAgo() {
    if (box.keys.isEmpty) return [];
    String? filterKey = getFilterKey();
    bool isntThereLogOlderThan7Days = filterKey == null;
    if (isntThereLogOlderThan7Days) return [];
    var list = box.valuesBetween(startKey: null, endKey: filterKey);
    return list;
  }

  deleteLogStatusesByIndexKey(Set<String> logIndexKeySet) async {
    List<String> logKeyList = _getLogKeyListByIndexKey(logIndexKeySet);
    Iterable<String?> sentListKey = _getSentListKey(logKeyList);
    var future = await deleteAllByKeys(sentListKey);
    _filterKey = null;
    return future;
  }

  String? getFilterKey() {
    if (_filterKey != null) return _filterKey;
    var keys = box.keys;
    int inDays = _getPastDaysByKeyId(keys.first);
    if (inDays < keptDays)
      return null;
    else {
      for (int i = 1; i < keys.length; i++) {
        try {
          int inDays = _getPastDaysByKeyId(keys.elementAt(i));
          if (inDays < keptDays) {
            _filterKey = keys.elementAt(i - 1);
          }
        } catch (e) {
          Log.e(e);
        }
      }
      if (_filterKey == null) _filterKey = keys.last;
    }
    return _filterKey;
  }

  int _getPastDaysByKeyId(String keyId) {
    var keyDate = _getDateFromKey(keyId);
    DateTime previousDate = DateTimeUtil.parseDateTime(keyDate);
    Duration duration = DateTime.now().difference(previousDate);
    return duration.inDays;
  }

  String _getDateFromKey(key) => key.split('_')[1];

  @override
  String get keyTableName => _keyNgcLogStatus;

  Iterable<String?> _getSentListKey(List<String> logKeyList) {
    Iterable<NgcLogStatus?> sentList = logKeyList.map((e) => getByKeyId(e)).where((element) => element?.enumStatus == EnumStatus.SENT);
    Iterable<String?> sentListKey = sentList.map((e) => e?.keyId);
    return sentListKey;
  }

  List<String> _getLogKeyListByIndexKey(Set<String> logIndexKeySet) {
    List<String> logKeyList = [];
    logIndexKeySet.forEach((indexKey) {
      var logListByIndexKey = box.keys.map((e) => e.toString()).where((element) => element.toString().startsWith(indexKey));
      logKeyList.addAll(logListByIndexKey);
    });
    return logKeyList;
  }
}
