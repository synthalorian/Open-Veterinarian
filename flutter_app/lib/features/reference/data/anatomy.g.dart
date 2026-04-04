// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anatomy.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnatomyReferenceAdapter extends TypeAdapter<AnatomyReference> {
  @override
  final int typeId = 12;

  @override
  AnatomyReference read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AnatomyReference(
      partName: fields[0] as String,
      system: fields[1] as String,
      description: fields[2] as String,
      clinicalSignificance: (fields[3] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, AnatomyReference obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.partName)
      ..writeByte(1)
      ..write(obj.system)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.clinicalSignificance);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnatomyReferenceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
