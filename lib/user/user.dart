import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../constants.dart';
import '../main.dart';

part 'user.g.dart';

final userRepositoryProvider =
Provider<UserRepository>((ref) => UserRepository(ref.read));

final boxUsersProvider = Provider<Users>((ref) {
  final box = ref.read(boxProvider);
  return box.get(UsersTypeId, defaultValue: Users()) as Users;
});

final usersProvider = StateNotifierProvider<UsersState, Users>(
      (ref) => UsersState(ref.watch(boxUsersProvider)),
);

final selectedUserProvider = StateNotifierProvider<User, UserHive>(
      (ref) {
    final provider = ref.watch(usersProvider);
    final selectedIndex = provider.selectedUserIndex;
    if (selectedIndex > -1 && selectedIndex < provider.users.length) {
      return User(provider.users[selectedIndex], ref.read);
    } else
      return User(UserHive(firstName: "Unknown", registered: false), ref.read);
  },
);


/// The user currently using the application, could be a parent or a child (parent hands phone to kid)
class User extends StateNotifier<UserHive> {
  User(UserHive user, this._read) : super(user);

  final Reader _read;
}

class UserRepository {
  UserRepository(this._read);

  final Reader _read;

  void add(UserHive kid) {
    select(kid);
    final users = _read(usersProvider.notifier);
    users.add(kid);
    users.select(users.length - 1); // select one just added
    _read(usersProvider).save();
  }

  select(UserHive user) {
    _read(boxProvider).put(SelectedUserTypeId, user);
    user.save();
  }

}

@HiveType(typeId: UsersTypeId)
class Users with HiveObjectMixin {
  @HiveField(0)
  List<UserHive> users = [];

  @HiveField(1)
  int selectedUserIndex = -1;
}

class UsersState extends StateNotifier<Users> {
  UsersState(Users users) : super(users);

  void add(UserHive kid) {
    state = state..users.add(kid);
  }

  bool remove(UserHive kid) {
    bool changed = state.users.remove(kid);
    state = state;
    return changed;
  }

  int get length => state.users.length;

  void select(int index) {
    state = state..selectedUserIndex = index;
  }

  void save() {
    state.save();
  }
}

@HiveType(typeId: SelectedUserTypeId)
class UserHive with HiveObjectMixin {
  UserHive({
    required this.firstName,
    this.lastName,
    this.registered = true,
    this.email,
  });

  @HiveField(1)
  String firstName;

  @HiveField(2)
  String? lastName;

  @HiveField(3)
  bool registered;

  @HiveField(4)
  String? email;
}
