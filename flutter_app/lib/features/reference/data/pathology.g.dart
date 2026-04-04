// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pathology.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PathologyAdapter extends TypeAdapter<Pathology> {
  @override
  final int typeId = 10;

  @override
  Pathology read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Pathology(
      name: fields[0] as String,
      category: fields[1] as String,
      description: fields[2] as String,
      clinicalSigns: (fields[3] as List).cast<String>(),
      diagnosticSteps: (fields[4] as List).cast<String>(),
      managementSummary: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Pathology obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.clinicalSigns)
      ..writeByte(4)
      ..write(obj.diagnosticSteps)
      ..writeByte(5)
      ..write(obj.managementSummary);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PathologyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
