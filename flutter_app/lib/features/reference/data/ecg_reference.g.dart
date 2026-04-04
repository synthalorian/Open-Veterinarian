// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ecg_reference.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EcgPatternAdapter extends TypeAdapter<EcgPattern> {
  @override
  final int typeId = 13;

  @override
  EcgPattern read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EcgPattern(
      rhythmName: fields[0] as String,
      description: fields[1] as String,
      characteristics: (fields[2] as List).cast<String>(),
      treatment: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, EcgPattern obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.rhythmName)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.characteristics)
      ..writeByte(3)
      ..write(obj.treatment);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EcgPatternAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
