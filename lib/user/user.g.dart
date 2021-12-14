// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UsersAdapter extends TypeAdapter<_$_Users> {
  @override
  final int typeId = 4;

  @override
  _$_Users read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_Users(
      users: (fields[0] as List).cast<User>(),
      selectedUserIndex: fields[1] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, _$_Users obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.users)
      ..writeByte(1)
      ..write(obj.selectedUserIndex);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UsersAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UserAdapter extends TypeAdapter<_$_User> {
  @override
  final int typeId = 3;

  @override
  _$_User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_User(
      firstName: fields[1] as String,
      lastName: fields[2] as String?,
      registered: fields[3] as bool,
      id: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, _$_User obj) {
    writer
      ..writeByte(4)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.registered)
      ..writeByte(4)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
