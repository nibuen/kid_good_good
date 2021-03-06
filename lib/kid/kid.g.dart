// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kid.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KidsAdapter extends TypeAdapter<_$_Kids> {
  @override
  final int typeId = 2;

  @override
  _$_Kids read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_Kids(
      kids: (fields[0] as List).cast<Kid>(),
      selectedKidIndex: fields[1] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, _$_Kids obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.kids)
      ..writeByte(1)
      ..write(obj.selectedKidIndex);
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

class KidAdapter extends TypeAdapter<_$_Kid> {
  @override
  final int typeId = 0;

  @override
  _$_Kid read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_Kid(
      points: fields[0] as int,
      pointHistory: (fields[1] as List).cast<PointHistory>(),
      firstName: fields[2] as String,
      lastName: fields[3] as String?,
      registered: fields[4] as bool,
      id: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, _$_Kid obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.points)
      ..writeByte(1)
      ..write(obj.pointHistory)
      ..writeByte(2)
      ..write(obj.firstName)
      ..writeByte(3)
      ..write(obj.lastName)
      ..writeByte(4)
      ..write(obj.registered)
      ..writeByte(5)
      ..write(obj.id);
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
