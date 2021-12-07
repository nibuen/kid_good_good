import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:kid_good_good/constants.dart';
import 'package:kid_good_good/kid/hud/kid_points.dart';
import 'package:kid_good_good/kid/reward/reward.dart';

import '../../app_bar.dart';
import '../kid.dart';
import 'monthly_history_line_chart.dart';

part 'history.g.dart';

final historyProvider = Provider((ref) => History());

class History {
  /// Finds missing days between the first historical item in time order and missing days up till now.
  /// This is limited to only checking within one year.
  List<PointHistory> findMissingDays(List<PointHistory> pointHistory,
      [DateTime? latestDateTime]) {
    var now = latestDateTime;
    final List<PointHistory> missingDays = [];

    if (now == null) {
      now = DateTime.now();
    }

    if (pointHistory.isNotEmpty) {
      pointHistory.sort();
      final daysWithPoints = Set.of(pointHistory.map((e) => e.dateTime.day));
      final firstDay = pointHistory.first.dateTime;
      final deltaInDays = now.difference(firstDay).inDays;

      for (int i = 1; i < deltaInDays + 1; i++) {
        final checkDate = firstDay.add(Duration(days: i));
        final PointHistory? check = daysWithPoints.contains(checkDate.day)
            ? null
            : MissingPointHistory(checkDate);

        if (check is MissingPointHistory) {
          missingDays.add(check);
        }
      }
    }

    return missingDays;
  }
}

class HistoryPage extends StatefulWidget {
  const HistoryPage({
    Key? key,
    required this.title,
    required this.kid,
  }) : super(key: key);

  final String title;
  final Kid kid;

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KidAppBar(
        title: widget.title,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 16,
            child: PointHistoryList(kid: widget.kid),
          ),
          Flexible(
            flex: 5,
            child: FractionallySizedBox(
              heightFactor: 1.0,
              widthFactor: .9,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: MonthlyHistoryLineChart(kid: widget.kid),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PointHistoryList extends ConsumerWidget {
  const PointHistoryList({
    Key? key,
    required this.kid,
  }) : super(key: key);

  final Kid kid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(selectedKidProvider);
    final History history = ref.watch(historyProvider);
    final pointHistory = kid.pointHistory;
    final missingDaysList = history.findMissingDays(pointHistory);

    List<PointHistory> historyAndMissingDays = List.from(pointHistory)
      ..addAll(missingDaysList)
      ..sort();
    historyAndMissingDays = historyAndMissingDays.reversed.toList();

    return HistoryList(
      historyAndMissingDays: historyAndMissingDays,
      missingDaysList: missingDaysList,
      kid: kid,
    );
  }

  /// Finds missing days between the first historical item in time order and missing days up till now.
  List<PointHistory> findMissingDays([DateTime? latestDateTime]) {
    var now = latestDateTime;
    if (now == null) {
      now = DateTime.now();
    }
    final history = kid.pointHistory;
    final List<PointHistory> missingDays = [];

    if (history.isNotEmpty) {
      final firstDay = history.first.dateTime;
      final deltaInDays = now.difference(firstDay).inDays;

      for (int i = 1; i < deltaInDays + 1; i++) {
        final checkDate = firstDay.add(Duration(days: i));
        final PointHistory check = history.firstWhere(
            (element) => element.dateTime.day == checkDate.day,
            orElse: () => MissingPointHistory(checkDate));
        if (check is MissingPointHistory) {
          missingDays.add(check);
        }
      }
    }

    return missingDays;
  }

  int dayOfYear(DateTime date) {
    final diff = date.difference(new DateTime(date.year, 1, 1, 0, 0));
    return diff.inDays;
  }
}

class HistoryList extends StatefulWidget {
  const HistoryList({
    required this.historyAndMissingDays,
    required this.missingDaysList,
    required this.kid,
    Key? key,
  }) : super(key: key);

  final Kid kid;
  final List<PointHistory> historyAndMissingDays;
  final List<PointHistory> missingDaysList;

  @override
  _HistoryListState createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  List<bool> itemsSelected = const [];
  int selectedCount = 0;

  @override
  void initState() {
    super.initState();

    itemsSelected =
        List.filled(widget.historyAndMissingDays.length, false, growable: true);
  }

  @override
  void didUpdateWidget(HistoryList oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (itemsSelected.length > widget.historyAndMissingDays.length) {
      itemsSelected =
          itemsSelected.sublist(0, widget.historyAndMissingDays.length);
    } else if (itemsSelected.length < widget.historyAndMissingDays.length) {
      itemsSelected.addAll(
        List.filled(
            widget.historyAndMissingDays.length - itemsSelected.length, false),
      );
    }
    assert(itemsSelected.length == widget.historyAndMissingDays.length);
  }

  @override
  Widget build(BuildContext context) {
    final buttonBar = SliverAppBar(
      automaticallyImplyLeading: false,
      title: Text("Edit History Items"),
      floating: true,
      actions: [
        IconButton(
            icon: Icon(Icons.delete, color: Colors.redAccent),
            onPressed: () {
              setState(() {
                for (int i = itemsSelected.length - 1; i >= 0; i--) {
                  if (itemsSelected[i]) {
                    widget.kid.deleteHistory(widget.historyAndMissingDays[i]);
                    itemsSelected.removeAt(i);
                  }
                }
                updateSelectedCount();
              });
            }),
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            final mappedItems = itemsSelected
                .asMap()
                .entries
                .where((element) => element.value)
                .map((e) => widget.historyAndMissingDays[e.key]);

            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Update Points'),
                content: KidPointsOrRegister(
                  kid: widget.kid,
                  initialValue:
                      mappedItems.isNotEmpty ? mappedItems.first.points : 20,
                  historyUpdates: mappedItems.toList(),
                ),
              ),
            );
          },
        ),
        VerticalDivider(thickness: 2),
        SelectedCounter(
          selectedCount: selectedCount,
          onSelectAll: () {
            setState(() {
              for (int i = 0; i < itemsSelected.length; i++) {
                itemsSelected[i] = true;
              }
              selectedCount = itemsSelected.length;
            });
          },
          onSelectAllMissing: () {
            setState(() {
              for (int i = 0; i < widget.historyAndMissingDays.length; i++) {
                if (widget.historyAndMissingDays[i] is MissingPointHistory) {
                  itemsSelected[i] = true;
                }
              }
              updateSelectedCount();
            });
          },
          onDeselectAll: () {
            setState(() {
              for (int i = 0; i < itemsSelected.length; i++) {
                itemsSelected[i] = false;
              }
              selectedCount = 0;
            });
          },
        ),
        VerticalDivider(thickness: 2),
      ],
    );

    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: <Widget>[
              buttonBar,
              StatefulBuilder(
                builder: (context, setState) => SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final item = widget.historyAndMissingDays[index];
                      final isMissingDay =
                          widget.missingDaysList.contains(item);
                      final rewardName = item.reward?.name;
                      return CheckboxListTile(
                        secondary:
                            rewardName != null ? Text("$rewardName") : null,
                        title: Text(
                          "${item.points} Points",
                          style: TextStyle(
                              color: isMissingDay ? Colors.red : null),
                        ),
                        subtitle: Text(
                          "${DateFormat.yMMMEd().format(item.dateTime)}",
                        ),
                        onChanged: (bool? value) {
                          setState(() {
                            itemsSelected[index] = value!;
                            updateSelectedCount();
                          });
                        },
                        value: itemsSelected[index],
                      );
                    },
                    childCount: widget.historyAndMissingDays.length,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  void updateSelectedCount() {
    setState(() {
      selectedCount = itemsSelected.fold(
          0,
          (previousValue, element) =>
              element ? previousValue + 1 : previousValue);
    });
  }
}

class SelectedCounter extends StatefulWidget {
  const SelectedCounter({
    required this.selectedCount,
    required this.onSelectAll,
    required this.onSelectAllMissing,
    required this.onDeselectAll,
    Key? key,
  }) : super(key: key);

  final int selectedCount;
  final VoidCallback onSelectAll;
  final VoidCallback onSelectAllMissing;
  final VoidCallback onDeselectAll;

  @override
  State<SelectedCounter> createState() => _SelectedCounterState();
}

enum Selections { select_all, select_all_missing, deselect_all }

class _SelectedCounterState extends State<SelectedCounter> {
  Selections _selection = Selections.select_all;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text("${widget.selectedCount}"),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: popupMenuButton(),
        ),
      ],
    );
  }

  Widget popupMenuButton() {
    return PopupMenuButton<Selections>(
      icon: Icon(Icons.check_box),
      onSelected: (Selections result) {
        setState(() {
          _selection = result;
          switch (_selection) {
            case Selections.select_all:
              widget.onSelectAll();
              break;
            case Selections.select_all_missing:
              widget.onSelectAllMissing();
              break;
            case Selections.deselect_all:
              widget.onDeselectAll();
              break;
          }
        });
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Selections>>[
        const PopupMenuItem<Selections>(
          value: Selections.select_all,
          child: Text('Select All'),
        ),
        const PopupMenuItem<Selections>(
          value: Selections.select_all_missing,
          child: Text('Select All Missing'),
        ),
        const PopupMenuItem<Selections>(
          value: Selections.deselect_all,
          child: Text('Deselect All'),
        ),
      ],
    );
  }
}

@HiveType(typeId: HistoryTypeId)
class PointHistory with Comparable<PointHistory> {
  PointHistory({
    required this.points,
    required this.dateTime,
    this.reward,
  });

  @HiveField(0)
  final int points;
  @HiveField(1)
  final DateTime dateTime;

  final Reward? reward;

  @override
  int compareTo(PointHistory other) {
    return dateTime.compareTo(other.dateTime);
  }
}

class MissingPointHistory extends PointHistory {
  MissingPointHistory(DateTime dateTime) : super(points: 0, dateTime: dateTime);

  @override
  String toString() {
    return "MissingPointHistory(dateTime = $dateTime , points = $points)";
  }
}
