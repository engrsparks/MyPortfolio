// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CheckOutModelAdapter extends TypeAdapter<CheckOutModel> {
  @override
  final int typeId = 2;

  @override
  CheckOutModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CheckOutModel(
      name: fields[12] as String,
      cost: fields[13] as double,
      price: fields[14] as double,
      quantity: fields[15] as int,
      discount: fields[16] as double,
      initialQuantity: fields[17] as int,
      index: fields[101] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CheckOutModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(12)
      ..write(obj.name)
      ..writeByte(13)
      ..write(obj.cost)
      ..writeByte(14)
      ..write(obj.price)
      ..writeByte(15)
      ..write(obj.quantity)
      ..writeByte(16)
      ..write(obj.discount)
      ..writeByte(17)
      ..write(obj.initialQuantity)
      ..writeByte(101)
      ..write(obj.index);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CheckOutModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
