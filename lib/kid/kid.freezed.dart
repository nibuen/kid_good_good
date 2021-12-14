// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'kid.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$KidsTearOff {
  const _$KidsTearOff();

  _Kids call(
      {@HiveField(0) required List<Kid> kids,
      @HiveField(1) dynamic selectedKidIndex = -1}) {
    return _Kids(
      kids: kids,
      selectedKidIndex: selectedKidIndex,
    );
  }
}

/// @nodoc
const $Kids = _$KidsTearOff();

/// @nodoc
mixin _$Kids {
  @HiveField(0)
  List<Kid> get kids => throw _privateConstructorUsedError;
  @HiveField(1)
  dynamic get selectedKidIndex => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $KidsCopyWith<Kids> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KidsCopyWith<$Res> {
  factory $KidsCopyWith(Kids value, $Res Function(Kids) then) =
      _$KidsCopyWithImpl<$Res>;
  $Res call(
      {@HiveField(0) List<Kid> kids, @HiveField(1) dynamic selectedKidIndex});
}

/// @nodoc
class _$KidsCopyWithImpl<$Res> implements $KidsCopyWith<$Res> {
  _$KidsCopyWithImpl(this._value, this._then);

  final Kids _value;
  // ignore: unused_field
  final $Res Function(Kids) _then;

  @override
  $Res call({
    Object? kids = freezed,
    Object? selectedKidIndex = freezed,
  }) {
    return _then(_value.copyWith(
      kids: kids == freezed
          ? _value.kids
          : kids // ignore: cast_nullable_to_non_nullable
              as List<Kid>,
      selectedKidIndex: selectedKidIndex == freezed
          ? _value.selectedKidIndex
          : selectedKidIndex // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
abstract class _$KidsCopyWith<$Res> implements $KidsCopyWith<$Res> {
  factory _$KidsCopyWith(_Kids value, $Res Function(_Kids) then) =
      __$KidsCopyWithImpl<$Res>;
  @override
  $Res call(
      {@HiveField(0) List<Kid> kids, @HiveField(1) dynamic selectedKidIndex});
}

/// @nodoc
class __$KidsCopyWithImpl<$Res> extends _$KidsCopyWithImpl<$Res>
    implements _$KidsCopyWith<$Res> {
  __$KidsCopyWithImpl(_Kids _value, $Res Function(_Kids) _then)
      : super(_value, (v) => _then(v as _Kids));

  @override
  _Kids get _value => super._value as _Kids;

  @override
  $Res call({
    Object? kids = freezed,
    Object? selectedKidIndex = freezed,
  }) {
    return _then(_Kids(
      kids: kids == freezed
          ? _value.kids
          : kids // ignore: cast_nullable_to_non_nullable
              as List<Kid>,
      selectedKidIndex: selectedKidIndex == freezed
          ? _value.selectedKidIndex
          : selectedKidIndex,
    ));
  }
}

/// @nodoc

@HiveType(typeId: KidsTypeId, adapterName: 'KidsAdapter')
class _$_Kids with DiagnosticableTreeMixin implements _Kids {
  const _$_Kids(
      {@HiveField(0) required this.kids,
      @HiveField(1) this.selectedKidIndex = -1});

  @override
  @HiveField(0)
  final List<Kid> kids;
  @JsonKey(defaultValue: -1)
  @override
  @HiveField(1)
  final dynamic selectedKidIndex;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Kids(kids: $kids, selectedKidIndex: $selectedKidIndex)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Kids'))
      ..add(DiagnosticsProperty('kids', kids))
      ..add(DiagnosticsProperty('selectedKidIndex', selectedKidIndex));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Kids &&
            const DeepCollectionEquality().equals(other.kids, kids) &&
            const DeepCollectionEquality()
                .equals(other.selectedKidIndex, selectedKidIndex));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(kids),
      const DeepCollectionEquality().hash(selectedKidIndex));

  @JsonKey(ignore: true)
  @override
  _$KidsCopyWith<_Kids> get copyWith =>
      __$KidsCopyWithImpl<_Kids>(this, _$identity);
}

abstract class _Kids implements Kids {
  const factory _Kids(
      {@HiveField(0) required List<Kid> kids,
      @HiveField(1) dynamic selectedKidIndex}) = _$_Kids;

  @override
  @HiveField(0)
  List<Kid> get kids;
  @override
  @HiveField(1)
  dynamic get selectedKidIndex;
  @override
  @JsonKey(ignore: true)
  _$KidsCopyWith<_Kids> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
class _$KidTearOff {
  const _$KidTearOff();

  _Kid call(
      {@HiveField(0) required int points,
      @HiveField(1) required List<PointHistory> pointHistory,
      @HiveField(2) required String firstName,
      @HiveField(3) String? lastName,
      @HiveField(4) required bool registered,
      @HiveField(5) required String id}) {
    return _Kid(
      points: points,
      pointHistory: pointHistory,
      firstName: firstName,
      lastName: lastName,
      registered: registered,
      id: id,
    );
  }
}

/// @nodoc
const $Kid = _$KidTearOff();

/// @nodoc
mixin _$Kid {
  @HiveField(0)
  int get points => throw _privateConstructorUsedError;
  @HiveField(1)
  List<PointHistory> get pointHistory => throw _privateConstructorUsedError;
  @HiveField(2)
  String get firstName => throw _privateConstructorUsedError;
  @HiveField(3)
  String? get lastName => throw _privateConstructorUsedError;
  @HiveField(4)
  bool get registered => throw _privateConstructorUsedError;
  @HiveField(5)
  String get id => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $KidCopyWith<Kid> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KidCopyWith<$Res> {
  factory $KidCopyWith(Kid value, $Res Function(Kid) then) =
      _$KidCopyWithImpl<$Res>;
  $Res call(
      {@HiveField(0) int points,
      @HiveField(1) List<PointHistory> pointHistory,
      @HiveField(2) String firstName,
      @HiveField(3) String? lastName,
      @HiveField(4) bool registered,
      @HiveField(5) String id});
}

/// @nodoc
class _$KidCopyWithImpl<$Res> implements $KidCopyWith<$Res> {
  _$KidCopyWithImpl(this._value, this._then);

  final Kid _value;
  // ignore: unused_field
  final $Res Function(Kid) _then;

  @override
  $Res call({
    Object? points = freezed,
    Object? pointHistory = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? registered = freezed,
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      points: points == freezed
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
      pointHistory: pointHistory == freezed
          ? _value.pointHistory
          : pointHistory // ignore: cast_nullable_to_non_nullable
              as List<PointHistory>,
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
abstract class _$KidCopyWith<$Res> implements $KidCopyWith<$Res> {
  factory _$KidCopyWith(_Kid value, $Res Function(_Kid) then) =
      __$KidCopyWithImpl<$Res>;
  @override
  $Res call(
      {@HiveField(0) int points,
      @HiveField(1) List<PointHistory> pointHistory,
      @HiveField(2) String firstName,
      @HiveField(3) String? lastName,
      @HiveField(4) bool registered,
      @HiveField(5) String id});
}

/// @nodoc
class __$KidCopyWithImpl<$Res> extends _$KidCopyWithImpl<$Res>
    implements _$KidCopyWith<$Res> {
  __$KidCopyWithImpl(_Kid _value, $Res Function(_Kid) _then)
      : super(_value, (v) => _then(v as _Kid));

  @override
  _Kid get _value => super._value as _Kid;

  @override
  $Res call({
    Object? points = freezed,
    Object? pointHistory = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? registered = freezed,
    Object? id = freezed,
  }) {
    return _then(_Kid(
      points: points == freezed
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
      pointHistory: pointHistory == freezed
          ? _value.pointHistory
          : pointHistory // ignore: cast_nullable_to_non_nullable
              as List<PointHistory>,
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

@HiveType(typeId: SelectedKidTypeId)
class _$_Kid with DiagnosticableTreeMixin implements _Kid {
  const _$_Kid(
      {@HiveField(0) required this.points,
      @HiveField(1) required this.pointHistory,
      @HiveField(2) required this.firstName,
      @HiveField(3) this.lastName,
      @HiveField(4) required this.registered,
      @HiveField(5) required this.id});

  @override
  @HiveField(0)
  final int points;
  @override
  @HiveField(1)
  final List<PointHistory> pointHistory;
  @override
  @HiveField(2)
  final String firstName;
  @override
  @HiveField(3)
  final String? lastName;
  @override
  @HiveField(4)
  final bool registered;
  @override
  @HiveField(5)
  final String id;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Kid(points: $points, pointHistory: $pointHistory, firstName: $firstName, lastName: $lastName, registered: $registered, id: $id)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Kid'))
      ..add(DiagnosticsProperty('points', points))
      ..add(DiagnosticsProperty('pointHistory', pointHistory))
      ..add(DiagnosticsProperty('firstName', firstName))
      ..add(DiagnosticsProperty('lastName', lastName))
      ..add(DiagnosticsProperty('registered', registered))
      ..add(DiagnosticsProperty('id', id));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Kid &&
            const DeepCollectionEquality().equals(other.points, points) &&
            const DeepCollectionEquality()
                .equals(other.pointHistory, pointHistory) &&
            const DeepCollectionEquality().equals(other.firstName, firstName) &&
            const DeepCollectionEquality().equals(other.lastName, lastName) &&
            const DeepCollectionEquality()
                .equals(other.registered, registered) &&
            const DeepCollectionEquality().equals(other.id, id));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(points),
      const DeepCollectionEquality().hash(pointHistory),
      const DeepCollectionEquality().hash(firstName),
      const DeepCollectionEquality().hash(lastName),
      const DeepCollectionEquality().hash(registered),
      const DeepCollectionEquality().hash(id));

  @JsonKey(ignore: true)
  @override
  _$KidCopyWith<_Kid> get copyWith =>
      __$KidCopyWithImpl<_Kid>(this, _$identity);
}

abstract class _Kid implements Kid {
  const factory _Kid(
      {@HiveField(0) required int points,
      @HiveField(1) required List<PointHistory> pointHistory,
      @HiveField(2) required String firstName,
      @HiveField(3) String? lastName,
      @HiveField(4) required bool registered,
      @HiveField(5) required String id}) = _$_Kid;

  @override
  @HiveField(0)
  int get points;
  @override
  @HiveField(1)
  List<PointHistory> get pointHistory;
  @override
  @HiveField(2)
  String get firstName;
  @override
  @HiveField(3)
  String? get lastName;
  @override
  @HiveField(4)
  bool get registered;
  @override
  @HiveField(5)
  String get id;
  @override
  @JsonKey(ignore: true)
  _$KidCopyWith<_Kid> get copyWith => throw _privateConstructorUsedError;
}
