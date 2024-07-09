import 'package:log_tracking/src/model/singular_entity.dart';
import 'package:log_tracking/src/repo/base_repo.dart';

/// tek değerli verileri db'de tutmak istediğimizde kullanacağımız repo'dur.
/// Int, String vs. String olarak kaydedilir
class SingularRepo extends BaseRepo<SingularEntity> {
  static SingularRepo? _instance;

  static SingularRepo get instance {
    if (_instance == null) _instance = SingularRepo._();
    return _instance!;
  }

  SingularRepo._();

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
    SingularEntity entity = SingularEntity(
      id: _fastHash(key),
      value: value?.toString(),
    );
    return save(entity);
  }

  String? _get(String key, {dynamic defaultValue}) {
    int id = _fastHash(key);
    var entity = baseCollection.getSync(id);
    var val = entity?.value;
    return val ?? defaultValue?.toString();
  }

  /// isar key value şeklinde kabul etmediği için key int'a çeviriyoruz
  int _fastHash(String string) {
    var hash = 0xcbf29ce484222325;

    var i = 0;
    while (i < string.length) {
      final codeUnit = string.codeUnitAt(i++);
      hash ^= codeUnit >> 8;
      hash *= 0x100000001b3;
      hash ^= codeUnit & 0xFF;
      hash *= 0x100000001b3;
    }
    return hash;
  }
}
