// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'triage.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TriageCriteriaAdapter extends TypeAdapter<TriageCriteria> {
  @override
  final int typeId = 20;

  @override
  TriageCriteria read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TriageCriteria(
      category: fields[0] as String,
      description: fields[1] as String,
      indicators: (fields[2] as List).cast<String>(),
      urgency: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TriageCriteria obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.category)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.indicators)
      ..writeByte(3)
      ..write(obj.urgency);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TriageCriteriaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
