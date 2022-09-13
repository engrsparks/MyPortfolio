// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SalesModelAdapter extends TypeAdapter<SalesModel> {
  @override
  final int typeId = 3;

  @override
  SalesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SalesModel(
      index: fields[18] as int,
      customerName: fields[19] as String,
      cash: fields[20] as double,
      cheque: fields[21] as double,
      ar: fields[22] as double,
      discount: fields[23] as double,
      gross: fields[24] as double,
      soldProducts: (fields[25] as List).cast<CheckOutModel>(),
      dateTime: fields[26] as DateTime,
      numberOfProducts: fields[27] as int,
      interestCost: fields[28] as double,
      gradient: fields[29] as double,
      isSelected: fields[30] as bool,
      deliveryCharge: fields[31] as double,
      address: fields[255] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SalesModel obj) {
    writer
      ..writeByte(15)
      ..writeByte(18)
      ..write(obj.index)
      ..writeByte(19)
      ..write(obj.customerName)
      ..writeByte(20)
      ..write(obj.cash)
      ..writeByte(21)
      ..write(obj.cheque)
      ..writeByte(22)
      ..write(obj.ar)
      ..writeByte(23)
      ..write(obj.discount)
      ..writeByte(24)
      ..write(obj.gross)
      ..writeByte(25)
      ..write(obj.soldProducts)
      ..writeByte(26)
      ..write(obj.dateTime)
      ..writeByte(27)
      ..write(obj.numberOfProducts)
      ..writeByte(28)
      ..write(obj.interestCost)
      ..writeByte(29)
      ..write(obj.gradient)
      ..writeByte(30)
      ..write(obj.isSelected)
      ..writeByte(31)
      ..write(obj.deliveryCharge)
      ..writeByte(255)
      ..write(obj.address);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SalesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
