// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ophthalmology.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OphthalmicReferenceAdapter extends TypeAdapter<OphthalmicReference> {
  @override
  final int typeId = 15;

  @override
  OphthalmicReference read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OphthalmicReference(
      condition: fields[0] as String,
      description: fields[1] as String,
      tonometerRange: fields[2] as String,
      commonTreatments: (fields[3] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, OphthalmicReference obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.condition)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.tonometerRange)
      ..writeByte(3)
      ..write(obj.commonTreatments);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OphthalmicReferenceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
