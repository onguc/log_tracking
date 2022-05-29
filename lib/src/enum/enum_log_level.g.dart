// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enum_log_level.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EnumLogLevelAdapter extends TypeAdapter<EnumLogLevel> {
  @override
  final int typeId = 8;

  @override
  EnumLogLevel read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return EnumLogLevel.HIGH;
      case 1:
        return EnumLogLevel.MEDIUM;
      case 2:
        return EnumLogLevel.LOW;
      default:
        return EnumLogLevel.HIGH;
    }
  }

  @override
  void write(BinaryWriter writer, EnumLogLevel obj) {
    switch (obj) {
      case EnumLogLevel.HIGH:
        writer.writeByte(0);
        break;
      case EnumLogLevel.MEDIUM:
        writer.writeByte(1);
        break;
      case EnumLogLevel.LOW:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EnumLogLevelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
