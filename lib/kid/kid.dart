import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:kid_good_good/kid/reward/reward.dart';

import 'history/history.dart';

part 'kid.g.dart';

@HiveType(typeId: 0)
class Kid extends ChangeNotifier with HiveObjectMixin {
  Kid({
    required this.firstName,
    this.lastName,
    this.registered = true,
  });

  bool registered;

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

  bool claimReward(Reward reward) {
    if (points >= reward.cost) {
      _points -= reward.cost;
      pointHistory.add(PointHistory(
        dateTime: DateTime.now(),
        points: -reward.cost,
        reward: reward,
      ));
      notifyListeners();
      return true;
    }

    return false;
  }
}
