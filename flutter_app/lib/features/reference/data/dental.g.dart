// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dental.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DentalPathologyAdapter extends TypeAdapter<DentalPathology> {
  @override
  final int typeId = 18;

  @override
  DentalPathology read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DentalPathology(
      name: fields[0] as String,
      description: fields[1] as String,
      classification: fields[2] as String,
      treatment: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DentalPathology obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.classification)
      ..writeByte(3)
      ..write(obj.treatment);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DentalPathologyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
