import 'package:flutter/material.dart';
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
    (ref) => KidsState(ref.read(boxKidsProvider)));

class KidRepository {
  KidRepository(this._read);

  final Reader _read;

  void add(Kid kid) {
    select(kid);
    _read(kidsProvider.notifier).add(kid);
    _read(kidsProvider).save();
    //final notifier = _read(kidsProvider.notifier);

    //final box = _read(boxProvider);
    //final kids = box.get(KidsTypeId, defaultValue: Kids()) as Kids;
  }

  select(Kid kid) {
    _read(boxProvider).put(SelectedKidTypeId, kid);
    kid.save();
  }
}

class KidsState extends StateNotifier<Kids> {
  KidsState(Kids kids) : super(kids);

  void add(Kid kid) {
    state = state..kids.add(kid);
  }
}

@HiveType(typeId: KidsTypeId)
class Kids with HiveObjectMixin {
  @HiveField(0)
  List<Kid> kids = [];
}

@HiveType(typeId: SelectedKidTypeId)
class Kid extends ChangeNotifier with HiveObjectMixin {
  Kid({
    required this.firstName,
    this.lastName,
    this.registered = true,
  });

  @HiveField(0)
  int _points = 0;

  int get points => _points;

  @HiveField(1)
  List<PointHistory> pointHistory = [];

  set points(int value) {
    pointHistory
        .add(PointHistory(dateTime: DateTime.now(), points: value - _points));
    _points = value;
    notifyListeners();
    save();
  }

  @HiveField(2)
  String firstName;

  @HiveField(3)
  String? lastName;

  @HiveField(4)
  bool registered;

  bool claimReward(Reward reward) {
    if (points >= reward.cost) {
      _points -= reward.cost;
      pointHistory.add(
        PointHistory(
          dateTime: DateTime.now(),
          points: -reward.cost,
          reward: reward,
        ),
      );
      notifyListeners();
      return true;
    }

    return false;
  }
}
