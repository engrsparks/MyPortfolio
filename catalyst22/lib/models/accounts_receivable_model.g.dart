// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounts_receivable_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountsReceivableModelAdapter
    extends TypeAdapter<AccountsReceivableModel> {
  @override
  final int typeId = 5;

  @override
  AccountsReceivableModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AccountsReceivableModel(
      customerName: fields[48] as String,
      cash: fields[49] as double,
      cheque: fields[50] as double,
      ar: fields[51] as double,
      dateTime: fields[52] as DateTime,
      invoiceNumber: fields[47] as int,
      interestCost: fields[53] as double,
      gradient: fields[54] as double,
      numberOfBags: fields[55] as int,
      address: fields[56] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AccountsReceivableModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(47)
      ..write(obj.invoiceNumber)
      ..writeByte(48)
      ..write(obj.customerName)
      ..writeByte(49)
      ..write(obj.cash)
      ..writeByte(50)
      ..write(obj.cheque)
      ..writeByte(51)
      ..write(obj.ar)
      ..writeByte(52)
      ..write(obj.dateTime)
      ..writeByte(53)
      ..write(obj.interestCost)
      ..writeByte(54)
      ..write(obj.gradient)
      ..writeByte(55)
      ..write(obj.numberOfBags)
      ..writeByte(56)
      ..write(obj.address);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountsReceivableModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
