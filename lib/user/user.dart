import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:kid_good_good/kid/hive/hive_object_wrapper.dart';
import 'package:uuid/uuid.dart';

import '../constants.dart';
import '../main.dart';

part 'user.freezed.dart';

part 'user.g.dart';

const _uuid = Uuid();

// final userRepositoryProvider =
//     Provider<UserRepository>((ref) => UserRepository(ref.read));

final boxUsersProvider = Provider<Users>((ref) {
  final box = ref.read(boxProvider);
  return box.get(UsersTypeId, defaultValue: Users(users: const [])) as Users;
});

final usersProvider = StateNotifierProvider<UsersState, Users>(
  (ref) => UsersState(ref.watch(boxUsersProvider), ref.read),
);

final selectedUserProvider = Provider<User>(
  (ref) {
    final provider = ref.watch(usersProvider);
    final selectedIndex = provider.selectedUserIndex;
    if (selectedIndex > -1 && selectedIndex < provider.users.length) {
      return provider.users[selectedIndex];
    } else
      return User(id: _uuid.v4(), firstName: "You", registered: false);
  },
);
//
// class UserRepository {
//   UserRepository(this._read);
//
//   final Reader _read;
//
//   void add(User user) {
//     select(kid);
//     final users = _read(usersProvider.notifier);
//     users.add(kid);
//     users.select(users.length - 1); // select one just added
//     _read(usersProvider).save();
//   }
//
//   select(User user) {
//     _read(boxProvider).put(SelectedUserTypeId, user);
//     user.save();
//   }
// }

// @HiveType(typeId: UsersTypeId)
// class Users with HiveObjectMixin {
//   @HiveField(0)
//   List<UserHive> users = [];
//
//   @HiveField(1)
//   int selectedUserIndex = -1;
// }

class UsersState extends StateNotifier<Users> {
  UsersState(Users users, this.reader) : super(users);

  final Reader reader;

  void add(User kid) {
    state.copyWith(users: [...state.users, kid]);
    save();
  }

  bool remove(User kid) {
    bool changed = state.users.remove(kid);
    state = state;
    return changed;
  }

  int get length => state.users.length;

  void select(int index) {
    state = state.copyWith(selectedUserIndex: index);
  }

  void save() {
    HiveObjectWrapper(
      box: reader(boxProvider),
      key: UsersTypeId,
      classToSave: state,
    ).save();
  }
}

@freezed
class Users with _$Users {
  @HiveType(typeId: UsersTypeId, adapterName: 'UsersAdapter')
  const factory Users({
    @HiveField(0) required List<User> users,
    @Default(-1) @HiveField(1) selectedUserIndex,
  }) = _Users;
}

@freezed
class User with _$User {
  @HiveType(typeId: SelectedUserTypeId, adapterName: 'UserAdapter')
  const factory User({
    @HiveField(1) required String firstName,
    @HiveField(2) String? lastName,
    @HiveField(3) required bool registered,
    @HiveField(4) required String id,
  }) = _User;
}

// @HiveType(typeId: SelectedUserTypeId)
// class UserHive with HiveObjectMixin {
//   UserHive({
//     required this.firstName,
//     this.lastName,
//     this.registered = true,
//     this.email,
//   });
//
//   @HiveField(1)
//   String firstName;
//
//   @HiveField(2)
//   String? lastName;
//
//   @HiveField(3)
//   bool registered;
//
//   @HiveField(4)
//   String? email;
// }
