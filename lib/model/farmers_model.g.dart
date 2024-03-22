// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'farmers_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FarmerAdapter extends TypeAdapter<Farmer> {
  @override
  final int typeId = 1;

  @override
  Farmer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Farmer(
      name: fields[0] as String,
      uid: fields[2] as String,
      phone: fields[3] as String?,
      transaction: (fields[4] as List?)
          ?.map((dynamic e) => (e as Map).cast<dynamic, dynamic>())
          ?.toList(),
      paidAmount: fields[5] as double?,
      creditAmount: fields[6] as double?,
      totalAmount: fields[7] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, Farmer obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.uid)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.transaction)
      ..writeByte(5)
      ..write(obj.paidAmount)
      ..writeByte(6)
      ..write(obj.creditAmount)
      ..writeByte(7)
      ..write(obj.totalAmount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FarmerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
