// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lab_reference.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LabRangeAdapter extends TypeAdapter<LabRange> {
  @override
  final int typeId = 4;

  @override
  LabRange read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LabRange(
      min: fields[0] as double,
      max: fields[1] as double,
      unit: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LabRange obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.min)
      ..writeByte(1)
      ..write(obj.max)
      ..writeByte(2)
      ..write(obj.unit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LabRangeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LabTestAdapter extends TypeAdapter<LabTest> {
  @override
  final int typeId = 5;

  @override
  LabTest read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LabTest(
      name: fields[0] as String,
      abbreviation: fields[1] as String,
      category: fields[2] as String,
      speciesRanges: (fields[3] as Map).cast<String, LabRange>(),
    );
  }

  @override
  void write(BinaryWriter writer, LabTest obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.abbreviation)
      ..writeByte(2)
      ..write(obj.category)
      ..writeByte(3)
      ..write(obj.speciesRanges);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LabTestAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
