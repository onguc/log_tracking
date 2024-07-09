import 'package:isar/isar.dart';
import 'package:log_tracking/src/model/base_entity.dart';

part 'singular_entity.g.dart';

/// tek değeri olan verilerin ISAR'a kaydedilmesi için yazılmıştır. (Strin, int, bool vs.)
@collection
class SingularEntity extends BaseEntity {
  String? value;

  SingularEntity({this.value, super.id});
}
