// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kid.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KidsAdapter extends TypeAdapter<Kids> {
  @override
  final int typeId = 2;

  @override
  Kids read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Kids()..kids = (fields[0] as List).cast<Kid>();
  }

  @override
  void write(BinaryWriter writer, Kids obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.kids);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KidsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
      registered: fields[4] as bool,
    )
      .._points = fields[0] as int
      ..pointHistory = (fields[1] as List).cast<PointHistory>();
  }

  @override
  void write(BinaryWriter writer, Kid obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj._points)
      ..writeByte(1)
      ..write(obj.pointHistory)
      ..writeByte(2)
      ..write(obj.firstName)
      ..writeByte(3)
      ..write(obj.lastName)
      ..writeByte(4)
      ..write(obj.registered);
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
