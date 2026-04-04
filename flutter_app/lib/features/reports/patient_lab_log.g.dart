// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_lab_log.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PatientLabLogAdapter extends TypeAdapter<PatientLabLog> {
  @override
  final int typeId = 16;

  @override
  PatientLabLog read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PatientLabLog(
      patientName: fields[0] as String,
      date: fields[1] as DateTime,
      results: (fields[2] as Map).cast<String, double>(),
      notes: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PatientLabLog obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.patientName)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.results)
      ..writeByte(3)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PatientLabLogAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
