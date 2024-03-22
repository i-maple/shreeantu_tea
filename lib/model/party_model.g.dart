// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'party_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PartyAdapter extends TypeAdapter<Party> {
  @override
  final int typeId = 4;

  @override
  Party read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Party(
      id: fields[0] as String,
      name: fields[1] as String,
      phone: fields[2] as String?,
      country: fields[3] as String?,
      transactions: (fields[4] as List?)
          ?.map((dynamic e) => (e as Map).cast<dynamic, dynamic>())
          ?.toList(),
      creditAmount: fields[5] as double?,
      advanceAmount: fields[6] as double?,
      paidAmount: fields[7] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, Party obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.phone)
      ..writeByte(3)
      ..write(obj.country)
      ..writeByte(4)
      ..write(obj.transactions)
      ..writeByte(5)
      ..write(obj.creditAmount)
      ..writeByte(6)
      ..write(obj.advanceAmount)
      ..writeByte(7)
      ..write(obj.paidAmount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PartyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
