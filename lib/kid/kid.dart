import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:kid_good_good/kid/reward/reward.dart';
import 'package:kid_good_good/main.dart';

import '../constants.dart';
import 'history/history.dart';

part 'kid.g.dart';

final repositoryProvider = Provider((ref) => KidRepository(ref.read));

final boxKidsProvider = Provider<Kids>((ref) {
  final box = ref.read(boxProvider);
  return box.get(KidsTypeId, defaultValue: Kids()) as Kids;
});

final kidsProvider = StateNotifierProvider<KidsState, Kids>(
  (ref) => KidsState(ref.watch(boxKidsProvider)),
);

final selectedKidsProvider = StateNotifierProvider<Kid, KidHive>(
  (ref) {
    final provider = ref.watch(kidsProvider);
    final selectedIndex = provider.selectedKidIndex;
    if (selectedIndex > -1 && selectedIndex < provider.kids.length) {
      return Kid(provider.kids[selectedIndex], ref.read);
    } else
      return Kid(KidHive(firstName: "Unknown", registered: false), ref.read);
  },
);

class KidRepository {
  KidRepository(this._read);

  final Reader _read;

  void add(KidHive kid) {
    select(kid);
    final kids = _read(kidsProvider.notifier);
    kids.add(kid);
    kids.select(kids.length - 1); // select one just added
    _read(kidsProvider).save();
    //final notifier = _read(kidsProvider.notifier);
    //final box = _read(boxProvider);
    //final kids = box.get(KidsTypeId, defaultValue: Kids()) as Kids;
  }

  select(KidHive kid) {
    _read(boxProvider).put(SelectedKidTypeId, kid);
    kid.save();
  }

  bool removeSelectedKid() {
    final kids = _read(kidsProvider.notifier);
    final changed = kids.remove(_read(selectedKidsProvider));
    if (changed) kids.save();
    return changed;
  }
}

class KidsState extends StateNotifier<Kids> {
  KidsState(Kids kids) : super(kids);

  void add(KidHive kid) {
    state = state..kids.add(kid);
  }

  bool remove(KidHive kid) {
    bool changed = state.kids.remove(kid);
    state = state;
    return changed;
  }

  int get length => state.kids.length;

  void select(int index) {
    state = state..selectedKidIndex = index;
  }

  void save() {
    state.save();
  }
}

@HiveType(typeId: KidsTypeId)
class Kids with HiveObjectMixin {
  @HiveField(0)
  List<KidHive> kids = [];

  @HiveField(1)
  int selectedKidIndex = -1;
}

class Kid extends StateNotifier<KidHive> {
  Kid(KidHive kid, this._read) : super(kid);

  final Reader _read;

  int get points => state.points;

  set points(int value) {
    state.pointHistory.add(
        PointHistory(dateTime: DateTime.now(), points: value - state.points));
    state = state..points = value;
    _read(kidsProvider).save();
  }

  void addPointsAtTime(int value, DateTime dateTime) {
    state.pointHistory.add(PointHistory(dateTime: dateTime, points: value));
    state = state..points += value;
    _read(kidsProvider).save();
  }

  String get firstName => state.firstName;

  String? get lastName => state.lastName;

  bool get registered => state.registered;

  List<PointHistory> get pointHistory => state.pointHistory;

  bool claimReward(Reward reward) {
    if (points >= reward.cost) {
      points -= reward.cost;
      state = state
        ..pointHistory.add(
          PointHistory(
            dateTime: DateTime.now(),
            points: -reward.cost,
            reward: reward,
          ),
        );
      _read(kidsProvider).save();
      return true;
    }

    //state = state;
    return false;
  }

  void deleteHistory(PointHistory item) {
    if (pointHistory.remove(item)) {
      // go directly to inner state so we don't add to history
      state.points -= item.points;
      _read(kidsProvider).save();
      state = state;
    }
  }
}

@HiveType(typeId: SelectedKidTypeId)
class KidHive with HiveObjectMixin {
  KidHive({
    required this.firstName,
    this.lastName,
    this.registered = true,
  });

  @HiveField(0)
  int points = 0;

  @HiveField(1)
  List<PointHistory> pointHistory = [];

  @HiveField(2)
  String firstName;

  @HiveField(3)
  String? lastName;

  @HiveField(4)
  bool registered;
}
