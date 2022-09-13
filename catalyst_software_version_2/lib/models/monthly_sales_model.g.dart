// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monthly_sales_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MonthlySalesModelAdapter extends TypeAdapter<MonthlySalesModel> {
  @override
  final int typeId = 8;

  @override
  MonthlySalesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MonthlySalesModel(
      cash: fields[60] as double,
      cheque: fields[61] as double,
      ar: fields[62] as double,
      netSales: fields[63] as double,
      grossProfit: fields[64] as double,
      dateTime: fields[65] as DateTime,
      numberOfProductsSold: fields[66] as int,
    );
  }

  @override
  void write(BinaryWriter writer, MonthlySalesModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(60)
      ..write(obj.cash)
      ..writeByte(61)
      ..write(obj.cheque)
      ..writeByte(62)
      ..write(obj.ar)
      ..writeByte(63)
      ..write(obj.netSales)
      ..writeByte(64)
      ..write(obj.grossProfit)
      ..writeByte(65)
      ..write(obj.dateTime)
      ..writeByte(66)
      ..write(obj.numberOfProductsSold);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MonthlySalesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
