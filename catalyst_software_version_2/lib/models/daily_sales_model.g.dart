// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_sales_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DailySalesModelAdapter extends TypeAdapter<DailySalesModel> {
  @override
  final int typeId = 6;

  @override
  DailySalesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DailySalesModel(
      cash: fields[51] as double,
      ar: fields[52] as double,
      cheque: fields[53] as double,
      gross: fields[54] as double,
      soldProducts: (fields[55] as List).cast<SalesReportModel>(),
      dateTime: fields[56] as DateTime,
      numberOfProducts: fields[57] as int,
    );
  }

  @override
  void write(BinaryWriter writer, DailySalesModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(51)
      ..write(obj.cash)
      ..writeByte(52)
      ..write(obj.ar)
      ..writeByte(53)
      ..write(obj.cheque)
      ..writeByte(54)
      ..write(obj.gross)
      ..writeByte(55)
      ..write(obj.soldProducts)
      ..writeByte(56)
      ..write(obj.dateTime)
      ..writeByte(57)
      ..write(obj.numberOfProducts);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailySalesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
