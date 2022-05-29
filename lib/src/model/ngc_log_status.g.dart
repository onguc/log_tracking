// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ngc_log_status.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NgcLogStatusAdapter extends TypeAdapter<NgcLogStatus> {
  @override
  final int typeId = 7;

  @override
  NgcLogStatus read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NgcLogStatus()..enumStatus = fields[0] as EnumStatus?;
  }

  @override
  void write(BinaryWriter writer, NgcLogStatus obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.enumStatus);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NgcLogStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
