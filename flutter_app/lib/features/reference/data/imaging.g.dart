// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'imaging.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ImagingReferenceAdapter extends TypeAdapter<ImagingReference> {
  @override
  final int typeId = 11;

  @override
  ImagingReference read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ImagingReference(
      title: fields[0] as String,
      category: fields[1] as String,
      positioning: fields[2] as String,
      checklist: (fields[3] as List).cast<String>(),
      clinicalNotes: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ImagingReference obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.positioning)
      ..writeByte(3)
      ..write(obj.checklist)
      ..writeByte(4)
      ..write(obj.clinicalNotes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImagingReferenceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
