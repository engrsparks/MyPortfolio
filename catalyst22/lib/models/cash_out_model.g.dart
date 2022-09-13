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
      dateTime: fields[73] as DateTime,
      cashOut: fields[74] as double,
      cashIn: fields[75] as double,
    );
  }

  @override
  void write(BinaryWriter writer, CashOutModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(73)
      ..write(obj.dateTime)
      ..writeByte(74)
      ..write(obj.cashOut)
      ..writeByte(75)
      ..write(obj.cashIn);
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
