// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drug_reference.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DosageAdapter extends TypeAdapter<Dosage> {
  @override
  final int typeId = 2;

  @override
  Dosage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Dosage(
      min: fields[0] as double,
      max: fields[1] as double,
      unit: fields[2] as String,
      frequency: fields[3] as String,
      route: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Dosage obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.min)
      ..writeByte(1)
      ..write(obj.max)
      ..writeByte(2)
      ..write(obj.unit)
      ..writeByte(3)
      ..write(obj.frequency)
      ..writeByte(4)
      ..write(obj.route);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DosageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DrugReferenceAdapter extends TypeAdapter<DrugReference> {
  @override
  final int typeId = 3;

  @override
  DrugReference read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DrugReference(
      name: fields[0] as String,
      category: fields[1] as String,
      description: fields[2] as String,
      speciesDosages: (fields[3] as Map).cast<String, Dosage>(),
    );
  }

  @override
  void write(BinaryWriter writer, DrugReference obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.speciesDosages);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DrugReferenceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
