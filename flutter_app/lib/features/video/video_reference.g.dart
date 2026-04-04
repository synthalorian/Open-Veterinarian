// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_reference.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VideoReferenceAdapter extends TypeAdapter<VideoReference> {
  @override
  final int typeId = 19;

  @override
  VideoReference read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VideoReference(
      title: fields[0] as String,
      category: fields[1] as String,
      videoUrl: fields[2] as String,
      description: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, VideoReference obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.videoUrl)
      ..writeByte(3)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VideoReferenceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
