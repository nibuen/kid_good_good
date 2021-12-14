// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$UsersTearOff {
  const _$UsersTearOff();

  _Users call(
      {@HiveField(0) required List<User> users,
      @HiveField(1) dynamic selectedUserIndex = -1}) {
    return _Users(
      users: users,
      selectedUserIndex: selectedUserIndex,
    );
  }
}

/// @nodoc
const $Users = _$UsersTearOff();

/// @nodoc
mixin _$Users {
  @HiveField(0)
  List<User> get users => throw _privateConstructorUsedError;
  @HiveField(1)
  dynamic get selectedUserIndex => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UsersCopyWith<Users> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UsersCopyWith<$Res> {
  factory $UsersCopyWith(Users value, $Res Function(Users) then) =
      _$UsersCopyWithImpl<$Res>;
  $Res call(
      {@HiveField(0) List<User> users,
      @HiveField(1) dynamic selectedUserIndex});
}

/// @nodoc
class _$UsersCopyWithImpl<$Res> implements $UsersCopyWith<$Res> {
  _$UsersCopyWithImpl(this._value, this._then);

  final Users _value;
  // ignore: unused_field
  final $Res Function(Users) _then;

  @override
  $Res call({
    Object? users = freezed,
    Object? selectedUserIndex = freezed,
  }) {
    return _then(_value.copyWith(
      users: users == freezed
          ? _value.users
          : users // ignore: cast_nullable_to_non_nullable
              as List<User>,
      selectedUserIndex: selectedUserIndex == freezed
          ? _value.selectedUserIndex
          : selectedUserIndex // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
abstract class _$UsersCopyWith<$Res> implements $UsersCopyWith<$Res> {
  factory _$UsersCopyWith(_Users value, $Res Function(_Users) then) =
      __$UsersCopyWithImpl<$Res>;
  @override
  $Res call(
      {@HiveField(0) List<User> users,
      @HiveField(1) dynamic selectedUserIndex});
}

/// @nodoc
class __$UsersCopyWithImpl<$Res> extends _$UsersCopyWithImpl<$Res>
    implements _$UsersCopyWith<$Res> {
  __$UsersCopyWithImpl(_Users _value, $Res Function(_Users) _then)
      : super(_value, (v) => _then(v as _Users));

  @override
  _Users get _value => super._value as _Users;

  @override
  $Res call({
    Object? users = freezed,
    Object? selectedUserIndex = freezed,
  }) {
    return _then(_Users(
      users: users == freezed
          ? _value.users
          : users // ignore: cast_nullable_to_non_nullable
              as List<User>,
      selectedUserIndex: selectedUserIndex == freezed
          ? _value.selectedUserIndex
          : selectedUserIndex,
    ));
  }
}

/// @nodoc

@HiveType(typeId: UsersTypeId, adapterName: 'UsersAdapter')
class _$_Users implements _Users {
  const _$_Users(
      {@HiveField(0) required this.users,
      @HiveField(1) this.selectedUserIndex = -1});

  @override
  @HiveField(0)
  final List<User> users;
  @JsonKey(defaultValue: -1)
  @override
  @HiveField(1)
  final dynamic selectedUserIndex;

  @override
  String toString() {
    return 'Users(users: $users, selectedUserIndex: $selectedUserIndex)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Users &&
            const DeepCollectionEquality().equals(other.users, users) &&
            const DeepCollectionEquality()
                .equals(other.selectedUserIndex, selectedUserIndex));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(users),
      const DeepCollectionEquality().hash(selectedUserIndex));

  @JsonKey(ignore: true)
  @override
  _$UsersCopyWith<_Users> get copyWith =>
      __$UsersCopyWithImpl<_Users>(this, _$identity);
}

abstract class _Users implements Users {
  const factory _Users(
      {@HiveField(0) required List<User> users,
      @HiveField(1) dynamic selectedUserIndex}) = _$_Users;

  @override
  @HiveField(0)
  List<User> get users;
  @override
  @HiveField(1)
  dynamic get selectedUserIndex;
  @override
  @JsonKey(ignore: true)
  _$UsersCopyWith<_Users> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
class _$UserTearOff {
  const _$UserTearOff();

  _User call(
      {@HiveField(1) required String firstName,
      @HiveField(2) String? lastName,
      @HiveField(3) required bool registered,
      @HiveField(4) required String id}) {
    return _User(
      firstName: firstName,
      lastName: lastName,
      registered: registered,
      id: id,
    );
  }
}

/// @nodoc
const $User = _$UserTearOff();

/// @nodoc
mixin _$User {
  @HiveField(1)
  String get firstName => throw _privateConstructorUsedError;
  @HiveField(2)
  String? get lastName => throw _privateConstructorUsedError;
  @HiveField(3)
  bool get registered => throw _privateConstructorUsedError;
  @HiveField(4)
  String get id => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res>;
  $Res call(
      {@HiveField(1) String firstName,
      @HiveField(2) String? lastName,
      @HiveField(3) bool registered,
      @HiveField(4) String id});
}

/// @nodoc
class _$UserCopyWithImpl<$Res> implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  final User _value;
  // ignore: unused_field
  final $Res Function(User) _then;

  @override
  $Res call({
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? registered = freezed,
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      firstName: firstName == freezed
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: lastName == freezed
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      registered: registered == freezed
          ? _value.registered
          : registered // ignore: cast_nullable_to_non_nullable
              as bool,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) then) =
      __$UserCopyWithImpl<$Res>;
  @override
  $Res call(
      {@HiveField(1) String firstName,
      @HiveField(2) String? lastName,
      @HiveField(3) bool registered,
      @HiveField(4) String id});
}

/// @nodoc
class __$UserCopyWithImpl<$Res> extends _$UserCopyWithImpl<$Res>
    implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(_User _value, $Res Function(_User) _then)
      : super(_value, (v) => _then(v as _User));

  @override
  _User get _value => super._value as _User;

  @override
  $Res call({
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? registered = freezed,
    Object? id = freezed,
  }) {
    return _then(_User(
      firstName: firstName == freezed
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: lastName == freezed
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      registered: registered == freezed
          ? _value.registered
          : registered // ignore: cast_nullable_to_non_nullable
              as bool,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@HiveType(typeId: SelectedUserTypeId, adapterName: 'UserAdapter')
class _$_User implements _User {
  const _$_User(
      {@HiveField(1) required this.firstName,
      @HiveField(2) this.lastName,
      @HiveField(3) required this.registered,
      @HiveField(4) required this.id});

  @override
  @HiveField(1)
  final String firstName;
  @override
  @HiveField(2)
  final String? lastName;
  @override
  @HiveField(3)
  final bool registered;
  @override
  @HiveField(4)
  final String id;

  @override
  String toString() {
    return 'User(firstName: $firstName, lastName: $lastName, registered: $registered, id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _User &&
            const DeepCollectionEquality().equals(other.firstName, firstName) &&
            const DeepCollectionEquality().equals(other.lastName, lastName) &&
            const DeepCollectionEquality()
                .equals(other.registered, registered) &&
            const DeepCollectionEquality().equals(other.id, id));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(firstName),
      const DeepCollectionEquality().hash(lastName),
      const DeepCollectionEquality().hash(registered),
      const DeepCollectionEquality().hash(id));

  @JsonKey(ignore: true)
  @override
  _$UserCopyWith<_User> get copyWith =>
      __$UserCopyWithImpl<_User>(this, _$identity);
}

abstract class _User implements User {
  const factory _User(
      {@HiveField(1) required String firstName,
      @HiveField(2) String? lastName,
      @HiveField(3) required bool registered,
      @HiveField(4) required String id}) = _$_User;

  @override
  @HiveField(1)
  String get firstName;
  @override
  @HiveField(2)
  String? get lastName;
  @override
  @HiveField(3)
  bool get registered;
  @override
  @HiveField(4)
  String get id;
  @override
  @JsonKey(ignore: true)
  _$UserCopyWith<_User> get copyWith => throw _privateConstructorUsedError;
}
