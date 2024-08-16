import 'package:isar/isar.dart';
import 'package:log_tracking/src/model/base_entity.dart';

part 'key_value_entity.g.dart';

/// tek değeri olan verilerin ISAR'a kaydedilmesi için yazılmıştır. (Strin, int, bool vs.)
@collection
class KeyValueEntity extends BaseEntity {
  String? value;

  KeyValueEntity({this.value, super.id});
}
