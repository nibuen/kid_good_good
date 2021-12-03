import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:kid_good_good/constants.dart';
import 'package:kid_good_good/kid/hud/kid_points.dart';
import 'package:kid_good_good/kid/reward/reward.dart';

import '../../app_bar.dart';
import '../kid.dart';

part 'history.g.dart';

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
      body: PointHistoryList(kid: widget.kid),
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
    final history = kid.pointHistory;
    final missingDaysList = findMissingDays();

    List<PointHistory> historyAndMissingDays = List.from(history)
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
  late List<bool> itemsSelected;
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

    if (oldWidget.historyAndMissingDays.length >
        widget.historyAndMissingDays.length) {
      itemsSelected =
          itemsSelected.sublist(0, widget.historyAndMissingDays.length);
    } else if (oldWidget.historyAndMissingDays.length <
        widget.historyAndMissingDays.length) {
      itemsSelected.addAll(
        List.filled(
            widget.historyAndMissingDays.length -
                oldWidget.historyAndMissingDays.length,
            false),
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

            // final mappedItems = itemsSelected.asMap()
            //   ..removeWhere((key, value) => !value);
            // final otherItems = mappedItems.map((key, value) =>
            //     MapEntry(key, widget.historyAndMissingDays[key].dateTime));

            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Update Points'),
                content: KidPointer(
                  kid: widget.kid,
                  initialValue: 20,
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
                if(widget.historyAndMissingDays[i] is MissingPointHistory) {
                  itemsSelected[i] = true;
                }
              }
              selectedCount = 0;
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
class PointHistory extends Comparable<PointHistory> {
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
}
