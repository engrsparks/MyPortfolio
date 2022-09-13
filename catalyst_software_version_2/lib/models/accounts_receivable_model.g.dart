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
      customerName: fields[43] as String,
      cash: fields[44] as double,
      cheque: fields[45] as double,
      ar: fields[46] as double,
      dateTime: fields[47] as DateTime,
      invoiceNumber: fields[42] as int,
      interestCost: fields[48] as double,
      gradient: fields[49] as double,
      numberOfBags: fields[50] as int,
      address: fields[254] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AccountsReceivableModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(42)
      ..write(obj.invoiceNumber)
      ..writeByte(43)
      ..write(obj.customerName)
      ..writeByte(44)
      ..write(obj.cash)
      ..writeByte(45)
      ..write(obj.cheque)
      ..writeByte(46)
      ..write(obj.ar)
      ..writeByte(47)
      ..write(obj.dateTime)
      ..writeByte(48)
      ..write(obj.interestCost)
      ..writeByte(49)
      ..write(obj.gradient)
      ..writeByte(50)
      ..write(obj.numberOfBags)
      ..writeByte(254)
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
