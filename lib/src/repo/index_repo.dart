import 'package:hive_flutter/hive_flutter.dart';

/// Created by İrfan Öngüç
/// on 23.04.2022

///Bir uygulama açıkken bastırılan logları ayrı olarak sunucuya
///gönderebilmek için index değeri her açılışta bir arttırılmalıdır
class IndexRepo {
  static String _keyLogIndex = "keyLogIndex";
  final String keyAppStartupIndex = "app_startup_index";
  final String keyAppErrorLogIndex = "app_error_index";
  late Box<int> box;


  static IndexRepo? _instance;

  static IndexRepo get instance {
    if (_instance == null) _instance = IndexRepo._();
    return _instance!;
  }

  IndexRepo._(){
    box = Hive.box<int>(_keyLogIndex);
  }

  static initHive() async {
    bool isOpenBox = Hive.isBoxOpen(_keyLogIndex);
    if (!isOpenBox) await Hive.openBox<int>(_keyLogIndex);
  }

  int get appStartupIndexValue {
    return box.get(keyAppStartupIndex, defaultValue: 0)!;
  }

  int get errorLogIndexValue {
    return box.get(keyAppErrorLogIndex, defaultValue: 0)!;
  }

  String get indexKey {
    return "INDEX$appStartupIndexValue-$errorLogIndexValue";
  }

  /// uygulalma her açıldığında bu değer bir artar. Loglar kaydedilirken key değerine eklenir
  int increaseAppStartupIndex() {
    int val = appStartupIndexValue;
    box.put(keyAppStartupIndex, ++val);
    return val;
  }

  int increaseAppErrorLogIndex() {
    int val = errorLogIndexValue;
    box.put(keyAppErrorLogIndex, ++val);
    return val;
  }
}
