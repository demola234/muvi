// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmarked.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookmarkedAdapter extends TypeAdapter<Bookmarked> {
  @override
  final int typeId = 0;

  @override
  Bookmarked read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Bookmarked(
      id: fields[0] as int,
      title: fields[1] as String,
      posterPath: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Bookmarked obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.posterPath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookmarkedAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
