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
  Widget build(BuildContext context, ScopedReader watch) {
    final history = kid.pointHistory;
    final missingDaysList = findMissingDays();

    List<PointHistory> historyAndMissingDays = List.from(history)
      ..addAll(missingDaysList)
      ..sort();
    historyAndMissingDays = historyAndMissingDays.reversed.toList();

    return ListView.separated(
      itemBuilder: (context, index) {
        final item = historyAndMissingDays[index];
        final isMissingDay = missingDaysList.contains(item);
        final rewardName = item.reward?.name;
        return ListTile(
          leading: rewardName != null ? Text("$rewardName") : null,
          title: Text(
            "${item.points} Points",
            style: TextStyle(color: isMissingDay ? Colors.red : null),
          ),
          subtitle: Text(
            "${DateFormat.yMMMEd().format(item.dateTime)}",
          ),
          trailing: ButtonBar(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!isMissingDay)
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.redAccent),
                  onPressed: () {
                    kid.deleteHistory(item);
                  },
                ),
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Update Points'),
                      content: KidPointer(
                        kid: kid,
                        initialValue: item.points,
                        dateTime: item.dateTime,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => index == 0 ? Divider() : Divider(),
      itemCount: historyAndMissingDays.length,
    );
  }

  List<PointHistory> findMissingDays([DateTime? latestDateTime]) {
    var now = latestDateTime;
    if (now == null) {
      now = DateTime.now();
    }

    final history = kid.pointHistory;
    final firstDay = history.first.dateTime;
    final deltaInDays = now.difference(firstDay).inDays;
    final List<PointHistory> missingDays = [];

    for (int i = 0; i < deltaInDays; i++) {
      final checkDate = firstDay.add(Duration(days: i));
      final PointHistory check = history.firstWhere(
          (element) => element.dateTime.day == checkDate.day,
          orElse: () => MissingPointHistory(checkDate));
      if (check is MissingPointHistory) {
        missingDays.add(check);
      }
    }
    return missingDays;
  }

  int dayOfYear(DateTime date) {
    final diff = date.difference(new DateTime(date.year, 1, 1, 0, 0));
    return diff.inDays;
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
