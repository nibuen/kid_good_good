import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'app_bar.dart';
import 'constants.dart';
import 'kid/history/history.dart';
import 'kid/hud/kid_points.dart';
import 'kid/hud/kid_summary_tile.dart';
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

  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://956a05a25ccb4b36a2248624aa283ced@o1082895.ingest.sentry.io/6091897';
      options.tracesSampleRate = .1;
    },
    appRunner: () => runApp(ProviderScope(child: App())),
  );
}

class Adult {}

final boxProvider = Provider<Box<dynamic>>((ref) {
  final box = Hive.box(hiveBoxName);
  ref.onDispose(() async => await box.close());
  return box;
});

class App extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //debugPrint('attempting read of noitifications');
    //context.read(notificationProvider(context).future);

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
            title: 'Rewards',
            kid: ref.read(selectedKidProvider.notifier),
          );
        },
        '/history': (c) {
          return Consumer(
            builder: (_, ref, __) {
              ref.watch(selectedKidProvider);
              return HistoryPage(
                title: 'History',
                kid: ref.read(selectedKidProvider.notifier),
              );
            },
          );
        },
        '/register_kid': (c) {
          return RegisterKidPage(
            title: 'Register New Child',
            kid: ref.read(selectedKidProvider.notifier),
          );
        },
        '/kid_details': (c) {
          return KidDetailsPage(
            title: 'Details',
            kid: ref.read(selectedKidProvider.notifier),
          );
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
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                "Children",
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: KidsList(),
            )),
            ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, "/register_kid"),
                  child: Text("New Child"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class KidDetailsPage extends StatefulWidget {
  const KidDetailsPage({
    Key? key,
    required this.title,
    required this.kid,
  }) : super(key: key);

  final String title;
  final Kid kid;
  @override
  _KidDetailsPageState createState() => _KidDetailsPageState();
}

class _KidDetailsPageState extends State<KidDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KidAppBar(
        title: widget.title,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SelectedKidPointer(),
            ),
            Spacer(),
            ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: [
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


class KidsList extends ConsumerWidget {
  const KidsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO This helps selected kid update correctly, should narrow rebuild
    ref.watch(selectedKidProvider);
    final kidsHive = ref.watch(kidsProvider);
    final kids = kidsHive.kids;
    final selectedIndex = kidsHive.selectedKidIndex;
    //debugPrint("$kids with $selectedIndex");

    return ListView.builder(
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          ref.read(kidsProvider.notifier).select(index);
          Navigator.pushNamed(context, "/kid_details");
        },
        onLongPress: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Text("${kids[index].firstName} Options"),
              actions: [
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.redAccent),
                  onPressed: () {
                    ref.read(repositoryProvider).removeSelectedKid();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                //ElevatedButton()
              ],
            ),
          );
        },
        child: KidSummaryTile(
          kid: Kid(kids[index], ref.read),
          icon: selectedIndex == index ? Icons.check : Icons.person,
        ),
      ),
      itemCount: kids.length,
    );
  }
}
