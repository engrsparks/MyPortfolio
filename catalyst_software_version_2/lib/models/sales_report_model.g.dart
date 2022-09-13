// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_report_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SalesReportModelAdapter extends TypeAdapter<SalesReportModel> {
  @override
  final int typeId = 4;

  @override
  SalesReportModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SalesReportModel(
      index: fields[32] as int,
      customerName: fields[33] as String,
      cash: fields[34] as double,
      cheque: fields[35] as double,
      ar: fields[36] as double,
      discount: fields[37] as double,
      gross: fields[38] as double,
      soldProducts: (fields[39] as List).cast<CheckOutModel>(),
      dateTime: fields[40] as DateTime,
      numberOfProducts: fields[41] as int,
      cashOut: fields[250] as double,
      cashIn: fields[251] as double,
    );
  }

  @override
  void write(BinaryWriter writer, SalesReportModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(32)
      ..write(obj.index)
      ..writeByte(33)
      ..write(obj.customerName)
      ..writeByte(34)
      ..write(obj.cash)
      ..writeByte(35)
      ..write(obj.cheque)
      ..writeByte(36)
      ..write(obj.ar)
      ..writeByte(37)
      ..write(obj.discount)
      ..writeByte(38)
      ..write(obj.gross)
      ..writeByte(39)
      ..write(obj.soldProducts)
      ..writeByte(40)
      ..write(obj.dateTime)
      ..writeByte(41)
      ..write(obj.numberOfProducts)
      ..writeByte(250)
      ..write(obj.cashOut)
      ..writeByte(251)
      ..write(obj.cashIn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SalesReportModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
