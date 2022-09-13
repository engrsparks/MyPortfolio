// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_reports_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SystemReportsModelAdapter extends TypeAdapter<SystemReportsModel> {
  @override
  final int typeId = 7;

  @override
  SystemReportsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SystemReportsModel(
      description: fields[58] as String,
      dateTime: fields[59] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, SystemReportsModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(58)
      ..write(obj.description)
      ..writeByte(59)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SystemReportsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
