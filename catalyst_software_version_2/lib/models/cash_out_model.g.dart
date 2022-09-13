// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_out_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CashOutModelAdapter extends TypeAdapter<CashOutModel> {
  @override
  final int typeId = 9;

  @override
  CashOutModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CashOutModel(
      dateTime: fields[67] as DateTime,
      cashOut: fields[68] as double,
    );
  }

  @override
  void write(BinaryWriter writer, CashOutModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(67)
      ..write(obj.dateTime)
      ..writeByte(68)
      ..write(obj.cashOut);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CashOutModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
