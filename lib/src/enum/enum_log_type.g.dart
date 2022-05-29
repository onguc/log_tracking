// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enum_log_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EnumLogTypeAdapter extends TypeAdapter<EnumLogType> {
  @override
  final int typeId = 5;

  @override
  EnumLogType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return EnumLogType.ALL;
      case 1:
        return EnumLogType.TRACE;
      case 2:
        return EnumLogType.DEBUG;
      case 3:
        return EnumLogType.INFO;
      case 4:
        return EnumLogType.WARNING;
      case 5:
        return EnumLogType.ERROR;
      case 6:
        return EnumLogType.SEVERE;
      case 7:
        return EnumLogType.FATAL;
      case 8:
        return EnumLogType.OFF;
      default:
        return EnumLogType.ALL;
    }
  }

  @override
  void write(BinaryWriter writer, EnumLogType obj) {
    switch (obj) {
      case EnumLogType.ALL:
        writer.writeByte(0);
        break;
      case EnumLogType.TRACE:
        writer.writeByte(1);
        break;
      case EnumLogType.DEBUG:
        writer.writeByte(2);
        break;
      case EnumLogType.INFO:
        writer.writeByte(3);
        break;
      case EnumLogType.WARNING:
        writer.writeByte(4);
        break;
      case EnumLogType.ERROR:
        writer.writeByte(5);
        break;
      case EnumLogType.SEVERE:
        writer.writeByte(6);
        break;
      case EnumLogType.FATAL:
        writer.writeByte(7);
        break;
      case EnumLogType.OFF:
        writer.writeByte(8);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EnumLogTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
