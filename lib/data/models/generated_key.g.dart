// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generated_key.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GeneratedKeyAdapter extends TypeAdapter<GeneratedKey> {
  @override
  final int typeId = 0;

  @override
  GeneratedKey read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GeneratedKey()
      ..label = fields[0] as String
      ..savedKey = fields[1] as String;
  }

  @override
  void write(BinaryWriter writer, GeneratedKey obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.label)
      ..writeByte(1)
      ..write(obj.savedKey);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GeneratedKeyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
