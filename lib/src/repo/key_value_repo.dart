import 'package:log_tracking/src/model/key_value_entity.dart';
import 'package:log_tracking/src/repo/base_repo.dart';

/// tek değerli verileri db'de tutmak istediğimizde kullanacağımız repo'dur.
/// Int, String vs. String olarak kaydedilir
class KeyValueRepo extends BaseRepo<KeyValueEntity> {
  static KeyValueRepo? _instance;

  static KeyValueRepo get instance {
    _instance ??= KeyValueRepo._();
    return _instance!;
  }

  KeyValueRepo._();

  /// Uygulama her başlatıldığında bu değer bir arttırılır
  final String _keyAppLaunchIndex = "app_launch_index";

  /// error gelene kadar basılmış olan loglar (en son error logu dahil) aynı errorIndex'e sahiptir
  final String _keyErrorIndex = "error_index";

  int get appLaunchIndex {
    String idString = _get(_keyAppLaunchIndex, defaultValue: 1)!;
    return int.parse(idString);
  }

  increaseAppLaunchIndex() async {
    await _put(_keyAppLaunchIndex, appLaunchIndex + 1);
  }

  int get errorIndex {
    String idString = _get(_keyErrorIndex, defaultValue: 1)!;
    return int.parse(idString);
  }

  increaseErrorIndex() async {
    await _put(_keyErrorIndex, errorIndex + 1);
  }

  Future<void> _put(String key, dynamic value) {
    KeyValueEntity entity = KeyValueEntity(
      id: stringToIntFNV(key),
      value: value?.toString(),
    );
    return save(entity);
  }

  String? _get(String key, {dynamic defaultValue}) {
    return "1";
    // int id = _fastHash(key);
    // var entity = baseCollection.getSync(id);
    // var val = entity?.value;
    // return val ?? defaultValue?.toString();
  }

  static int stringToIntFNV(String key) {
    const int fnvPrime = 16777619;
    const int fnvOffsetBasis = 2166136261;

    int hash = fnvOffsetBasis;
    for (int i = 0; i < key.length; i++) {
      hash ^= key.codeUnitAt(i);
      hash *= fnvPrime;
      hash = hash & 0xFFFFFFFF; // 32-bit sınırı
    }

    return hash.abs();
  }
}
