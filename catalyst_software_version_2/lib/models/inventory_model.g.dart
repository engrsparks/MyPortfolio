// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InventoryModelAdapter extends TypeAdapter<InventoryModel> {
  @override
  final int typeId = 1;

  @override
  InventoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InventoryModel(
      name: fields[8] as String,
      cost: fields[9] as double,
      price: fields[10] as double,
      quantity: fields[11] as int,
      index: fields[100] as int,
    );
  }

  @override
  void write(BinaryWriter writer, InventoryModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(8)
      ..write(obj.name)
      ..writeByte(9)
      ..write(obj.cost)
      ..writeByte(10)
      ..write(obj.price)
      ..writeByte(11)
      ..write(obj.quantity)
      ..writeByte(100)
      ..write(obj.index);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InventoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
