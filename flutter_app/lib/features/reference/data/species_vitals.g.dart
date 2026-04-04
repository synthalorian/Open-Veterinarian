// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'species_vitals.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VitalRangeAdapter extends TypeAdapter<VitalRange> {
  @override
  final int typeId = 0;

  @override
  VitalRange read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VitalRange(
      min: fields[0] as double,
      max: fields[1] as double,
      unit: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, VitalRange obj) {
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
      other is VitalRangeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SpeciesVitalsAdapter extends TypeAdapter<SpeciesVitals> {
  @override
  final int typeId = 1;

  @override
  SpeciesVitals read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SpeciesVitals(
      name: fields[0] as String,
      scientificName: fields[1] as String,
      temperature: fields[2] as VitalRange,
      heartRate: fields[3] as VitalRange,
      respiratoryRate: fields[4] as VitalRange,
    );
  }

  @override
  void write(BinaryWriter writer, SpeciesVitals obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.scientificName)
      ..writeByte(2)
      ..write(obj.temperature)
      ..writeByte(3)
      ..write(obj.heartRate)
      ..writeByte(4)
      ..write(obj.respiratoryRate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpeciesVitalsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
