import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:kid_good_good/kid/reward/reward.dart';
import 'package:kid_good_good/main.dart';
import 'package:uuid/uuid.dart';

import '../constants.dart';
import 'history/history.dart';
import 'hive/hive_object_wrapper.dart';

part 'kid.freezed.dart';
part 'kid.g.dart';

const _uuid = Uuid();

final repositoryProvider =
    Provider<KidRepository>((ref) => KidRepository(ref.read));

final boxKidsProvider = Provider<Kids>((ref) {
  final Box box = ref.read(boxProvider);
  return box.get(KidsTypeId, defaultValue: Kids(kids: const [])) as Kids;
});

final kidsProvider = StateNotifierProvider<KidsState, Kids>(
  (ref) => KidsState(ref.watch(boxKidsProvider), ref.read),
);

final selectedKidProvider = Provider<Kid>(
  (ref) {
    // TODO for now this just watches the whole kids list, but could provider.select on selectedKidIndex if there was a watch provider for kid itself
    final int selectedIndex = ref.watch(kidsProvider).selectedKidIndex;
    final provider = ref.read(kidsProvider);
    if (selectedIndex > -1 && selectedIndex < provider.kids.length) {
      return provider.kids[selectedIndex];
    } else
      return Kid(
        id: _uuid.v4(),
        firstName: "Unknown",
        registered: false,
        pointHistory: const [],
        points: 0,
      );
  },
);

class KidRepository {
  KidRepository(this._read);

  final Reader _read;

  void add(Kid kid) {
    select(kid);
    final kids = _read(kidsProvider.notifier);
    kids.add(kid);
    kids.select(kids.length - 1); // select one just added
    kids.save();
  }

  select(Kid kid) {
    _read(boxProvider).put(SelectedKidTypeId, kid);
    save(kid);
  }

  bool removeSelectedKid() {
    final kids = _read(kidsProvider.notifier);
    final changed = kids.remove(_read(selectedKidProvider));
    if (changed) kids.save();
    return changed;
  }

  void addPoints({
    required String id,
    required int points,
    DateTime? dateTime,
    Reward? reward,
  }) {
    _read(kidsProvider.notifier).addPoints(
      id: id,
      points: points,
      dateTime: dateTime,
      reward: reward,
    );
  }

  void updatePoints(
      {required String id,
      required PointHistory pointHistoryItem,
      required int newPoints}) {
    _read(kidsProvider.notifier).updatePoints(
        id: id, pointHistoryItem: pointHistoryItem, newPoints: newPoints);
  }

  Kid getKid(String id) {
    return _read(kidsProvider).kids.firstWhere((element) => element.id == id);
  }

  void save(Kid kid) {
    HiveObjectWrapper(
      box: _read(boxProvider),
      key: SelectedKidTypeId,
      classToSave: kid,
    ).save();
  }

  bool claimReward({required Kid kid, required Reward reward}) {
    if (kid.points >= reward.cost) {
      addPoints(id: kid.id, points: -reward.cost, reward: reward);
      return true;
    }
    return false;
  }

  void deleteHistory({required Kid kid, required PointHistory item}) {
    _read(kidsProvider.notifier).deleteHistory(id: kid.id, item: item);
  }
}

class KidsState extends StateNotifier<Kids> {
  KidsState(
    Kids kids,
    this.reader,
  ) : super(kids);

  Reader reader;

  void add(Kid kid) {
    state = state.copyWith(
      kids: List.from(state.kids)..add(kid),
    );
    save();
  }

  bool remove(Kid kid) {
    final newList = List<Kid>.from(state.kids);
    bool changed = newList.remove(kid);
    state = state.copyWith(kids: newList);
    save();
    return changed;
  }

  int get length => state.kids.length;

  void select(int index) {
    state = state.copyWith(selectedKidIndex: index);
    save();
  }

  void save() {
    HiveObjectWrapper(
      box: reader(boxProvider),
      key: KidsTypeId,
      classToSave: state,
    ).save();
  }

  void addPoints({
    required String id,
    required int points,
    DateTime? dateTime,
    Reward? reward,
  }) {
    final pointHistoryDateTime = dateTime != null ? dateTime : DateTime.now();
    final newPointHistoryItem = PointHistory(
        points: points, dateTime: pointHistoryDateTime, reward: reward);

    state = state.copyWith(
      kids: [
        for (final kid in state.kids)
          if (kid.id == id)
            kid.copyWith(
                points: kid.points + points,
                pointHistory: [...kid.pointHistory, newPointHistoryItem])
          else
            kid,
      ],
    );

    save();
  }

  void updatePoints({
    required String id,
    required PointHistory pointHistoryItem,
    required int newPoints,
  }) {
    state = state.copyWith(
      kids: [
        for (final kid in state.kids)
          if (kid.id == id)
            kid.copyWith(
              points: kid.points - pointHistoryItem.points + newPoints,
              pointHistory: [
                for (final item in kid.pointHistory)
                  if (item == pointHistoryItem)
                    PointHistory(
                        points: newPoints, dateTime: pointHistoryItem.dateTime)
                  else
                    item
              ],
            )
          else
            kid,
      ],
    );
    save();
  }

  void deleteHistory({required String id, required PointHistory item}) {
    // don't add to history since this is a removal (maybe logs in future)
    state = state.copyWith(
      kids: [
        for (final kid in state.kids)
          if (kid.id == id)
            kid.copyWith(
              points: kid.points - item.points,
              pointHistory: kid.pointHistory..remove(item),
            )
          else
            kid,
      ],
    );
    save();
  }
}

@freezed
class Kids with _$Kids {
  @HiveType(typeId: KidsTypeId, adapterName: 'KidsAdapter')
  const factory Kids({
    @HiveField(0) required List<Kid> kids,
    @Default(-1) @HiveField(1) selectedKidIndex,
  }) = _Kids;
}

@freezed
class Kid with _$Kid {
  @HiveType(typeId: SelectedKidTypeId)
  const factory Kid({
    @HiveField(0) required int points,
    @HiveField(1) required List<PointHistory> pointHistory,
    @HiveField(2) required String firstName,
    @HiveField(3) String? lastName,
    @HiveField(4) required bool registered,
    @HiveField(5) required String id,
  }) = _Kid;
}
