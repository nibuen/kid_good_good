// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kid.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KidAdapter extends TypeAdapter<Kid> {
  @override
  final int typeId = 0;

  @override
  Kid read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Kid(
      firstName: fields[2] as String,
      lastName: fields[3] as String?,
    )
      .._points = fields[0] as int
      ..pointHistory = (fields[1] as List).cast<PointHistory>();
  }

  @override
  void write(BinaryWriter writer, Kid obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj._points)
      ..writeByte(1)
      ..write(obj.pointHistory)
      ..writeByte(2)
      ..write(obj.firstName)
      ..writeByte(3)
      ..write(obj.lastName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KidAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
