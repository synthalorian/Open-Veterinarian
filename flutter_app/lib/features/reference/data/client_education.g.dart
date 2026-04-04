// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_education.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnatomyDiagramAdapter extends TypeAdapter<AnatomyDiagram> {
  @override
  final int typeId = 17;

  @override
  AnatomyDiagram read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AnatomyDiagram(
      title: fields[0] as String,
      svgPath: fields[1] as String,
      explanation: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AnatomyDiagram obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.svgPath)
      ..writeByte(2)
      ..write(obj.explanation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnatomyDiagramAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
