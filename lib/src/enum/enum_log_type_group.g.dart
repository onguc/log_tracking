// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enum_log_type_group.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EnumLogTypeGroupAdapter extends TypeAdapter<EnumLogTypeGroup> {
  @override
  final int typeId = 9;

  @override
  EnumLogTypeGroup read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return EnumLogTypeGroup.PRODUCTION;
      case 1:
        return EnumLogTypeGroup.DEBUG;
      default:
        return EnumLogTypeGroup.PRODUCTION;
    }
  }

  @override
  void write(BinaryWriter writer, EnumLogTypeGroup obj) {
    switch (obj) {
      case EnumLogTypeGroup.PRODUCTION:
        writer.writeByte(0);
        break;
      case EnumLogTypeGroup.DEBUG:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EnumLogTypeGroupAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
