import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:kid_good_good/constants.dart';
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

    return ListView.separated(
        itemBuilder: (context, index) {
          final item = history[index];
          final rewardName = item.reward?.name;
          return ListTile(
            leading: rewardName != null ? Text("$rewardName") : null,
            title: Text(
                "${DateFormat.EEEE().format(item.dateTime)} : ${item.points} Points"),
            subtitle: Text(
              "${DateFormat.yMMMd().format(item.dateTime)}",
            ),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {},
            ),
          );
        },
        separatorBuilder: (context, index) =>
            index == 0 ? Divider() : Divider(),
        itemCount: history.length);
  }
}

@HiveType(typeId: HistoryTypeId)
class PointHistory {
  const PointHistory({
    required this.points,
    required this.dateTime,
    this.reward,
  });

  @HiveField(0)
  final int points;
  @HiveField(1)
  final DateTime dateTime;

  final Reward? reward;
}
