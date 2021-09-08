import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app_bar.dart';
import 'constants.dart';
import 'kid/history/history.dart';
import 'kid/hud/kid_points.dart';
import 'kid/hud/kid_summary.dart';
import 'kid/hud/register_kid_page.dart';
import 'kid/kid.dart';
import 'kid/reward/rewards_page.dart';

void main() async {
  await Hive.initFlutter();
  Hive
    ..registerAdapter(KidHiveAdapter())
    ..registerAdapter(KidsAdapter())
    ..registerAdapter(PointHistoryAdapter());
  await Hive.openBox(hiveBoxName);

  runApp(ProviderScope(child: App()));
}

class Adult {}

final boxProvider = Provider<Box<dynamic>>((ref) {
  final box = Hive.box(hiveBoxName);
  ref.onDispose(() async => await box.close());
  return box;
});

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kid Good Good',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        secondaryHeaderColor: Colors.orangeAccent,
      ),
      home: SummaryPage(title: 'Summary'),
      routes: {
        '/rewards': (c) {
          return RewardsPage(
              title: 'Buy Rewards', kid: c.read(selectedKidsProvider.notifier));
        },
        '/history': (c) {
          return HistoryPage(
              title: 'Kid History', kid: c.read(selectedKidsProvider.notifier));
        },
        '/register_kid': (c) {
          return RegisterKidPage(
              title: 'Register New Child',
              kid: c.read(selectedKidsProvider.notifier));
        },
      },
    );
  }
}

class SummaryPage extends StatefulWidget {
  SummaryPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _SummaryPageState createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KidAppBar(
        title: widget.title,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SelectedKidPointer(),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: KidsPointerList(),
            )),
            ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, "/register_kid"),
                  child: Text("New Child"),
                ),
                ButtonBar(
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pushNamed(context, "/rewards"),
                      child: Text("Rewards"),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.pushNamed(context, "/history"),
                      child: Text("History"),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class KidsPointerList extends ConsumerWidget {
  const KidsPointerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    watch(selectedKidsProvider); // TODO This helps selected kid update correctly, should narrow rebuild
    final kidsHive = watch(kidsProvider);
    final kids = kidsHive.kids;
    final selectedIndex = kidsHive.selectedKidIndex;
    //debugPrint("$kids with $selectedIndex");

    return ListView.builder(
      itemBuilder: (context, index) => index != selectedIndex
          ? GestureDetector(
              onTap: () => context.read(kidsProvider.notifier).select(index),
              child: KidSummary(
                kid: Kid(kids[index], context.read),
              ),
            )
          : KidSummary(
              kid: Kid(kids[index], context.read),
              icon: Icons.check,
            ),
      itemCount: kids.length,
    );
  }
}
