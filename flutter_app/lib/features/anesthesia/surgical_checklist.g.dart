// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surgical_checklist.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChecklistItemAdapter extends TypeAdapter<ChecklistItem> {
  @override
  final int typeId = 6;

  @override
  ChecklistItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChecklistItem(
      task: fields[0] as String,
      isCompleted: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ChecklistItem obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.task)
      ..writeByte(1)
      ..write(obj.isCompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChecklistItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SurgicalChecklistAdapter extends TypeAdapter<SurgicalChecklist> {
  @override
  final int typeId = 7;

  @override
  SurgicalChecklist read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SurgicalChecklist(
      phase: fields[0] as String,
      items: (fields[1] as List).cast<ChecklistItem>(),
    );
  }

  @override
  void write(BinaryWriter writer, SurgicalChecklist obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.phase)
      ..writeByte(1)
      ..write(obj.items);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SurgicalChecklistAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
