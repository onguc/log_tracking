// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enum_status.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EnumStatusAdapter extends TypeAdapter<EnumStatus> {
  @override
  final int typeId = 6;

  @override
  EnumStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return EnumStatus.UNSENT;
      case 1:
        return EnumStatus.SENT;
      case 2:
        return EnumStatus.SENDING;
      default:
        return EnumStatus.UNSENT;
    }
  }

  @override
  void write(BinaryWriter writer, EnumStatus obj) {
    switch (obj) {
      case EnumStatus.UNSENT:
        writer.writeByte(0);
        break;
      case EnumStatus.SENT:
        writer.writeByte(1);
        break;
      case EnumStatus.SENDING:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EnumStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
