// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionEntryAdapter extends TypeAdapter<TransactionEntry> {
  @override
  final int typeId = 2;

  @override
  TransactionEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransactionEntry(
      id: fields[0] as String,
      description: fields[1] as String,
      amount: fields[2] as double,
      debitAccountId: fields[3] as String,
      creditAccountId: fields[4] as String,
      date: fields[5] as DateTime,
      fiscalYear: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TransactionEntry obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.debitAccountId)
      ..writeByte(4)
      ..write(obj.creditAccountId)
      ..writeByte(5)
      ..write(obj.date)
      ..writeByte(6)
      ..write(obj.fiscalYear);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
