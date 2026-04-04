// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anesthesia_protocols.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnesthesiaProtocolAdapter extends TypeAdapter<AnesthesiaProtocol> {
  @override
  final int typeId = 9;

  @override
  AnesthesiaProtocol read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AnesthesiaProtocol(
      name: fields[0] as String,
      description: fields[1] as String,
      drugs: (fields[2] as Map).cast<String, String>(),
      indications: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AnesthesiaProtocol obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.drugs)
      ..writeByte(3)
      ..write(obj.indications);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnesthesiaProtocolAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
