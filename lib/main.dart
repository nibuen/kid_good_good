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
import 'kid/kid.dart';
import 'kid/reward/rewards_page.dart';

void main() async {
  await Hive.initFlutter();
  Hive
    ..registerAdapter(KidAdapter())
    ..registerAdapter(KidsAdapter())
    ..registerAdapter(
      PointHistoryAdapter(),
    );
  await Hive.openBox("myBox");

  runApp(ProviderScope(child: App()));
}

class Adult {}

final boxProvider = Provider<Box<dynamic>>((ref) {
  final box = Hive.box("myBox");
  ref.onDispose(() async => await box.close());
  return box;
});

final selectedKidStreamProvider = StreamProvider<Kid>((ref) async* {
  final usersBox = ref.watch(boxProvider);

  yield* Stream.value(usersBox.get(
    SelectedKidTypeId,
    defaultValue: Kid(firstName: "new", registered: false),
  ) as Kid);
  yield* usersBox.watch(key: SelectedKidTypeId).map((usersBoxEvent) {
    return usersBoxEvent.value == null
        ? Kid(firstName: "new", registered: false)
        : usersBoxEvent.value as Kid;
  });
});

final selectedKidProvider = FutureProvider<Kid>((ref) async {
  return await ref.watch(kidProvider);
});

final kidProvider = ChangeNotifierProvider<Kid>(
  (ref) {
    return ref.watch(selectedKidStreamProvider).when(
        data: (data) {
          //debugPrint("new data ${data.firstName}");
          return data;
        },
        loading: () => Kid(firstName: "new", registered: false),
        error: (e, s) => Kid(firstName: "new", registered: false));
  },
);

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kid Good Good',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Today\'s Points'),
      routes: {
        '/rewards': (c) {
          return c.read(selectedKidProvider).when(
                data: (kid) => RewardsPage(title: 'Buy Rewards', kid: kid),
                loading: () => MyHomePage(title: 'Today\'s Points'),
                error: (e, s) => MyHomePage(title: 'Today\'s Points'),
              );
        },
        '/history': (c) {
          return c.read(selectedKidProvider).when(
                data: (kid) => HistoryPage(title: 'Kid History', kid: kid),
                loading: () => MyHomePage(title: 'Today\'s Points'),
                error: (e, s) => MyHomePage(title: 'Today\'s Points'),
              );
        },
        // '/user_select' : (c) {
        //   return c.read(kidStreamProvider.last).
        // }
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
            Card(
              child: MyCustomForm(),
            ),
            SelectedKidPointer(),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: KidsPointerList(),
            )),
            ButtonBar(children: [
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, "/rewards"),
                child: Text("Rewards"),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, "/history"),
                child: Text("History"),
              ),
            ]),
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
    final List<Kid> kids = watch(kidsProvider).kids;
    return ListView.builder(
      itemBuilder: (context, index) => GestureDetector(
        onTap: () => context.read(repositoryProvider).select(kids[index]),
        child: KidSummary(kid: kids[index]),
      ),
      itemCount: kids.length,
    );
  }
}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({
    Key? key,
  }) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: firstNameController,
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Child\'s First Name?',
                labelText: 'First Name *',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: lastNameController,
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Child\'s Last Name?',
                labelText: 'Last Name',
              ),
              validator: (value) {
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final kid = Kid(firstName: firstNameController.text)
                    ..lastName = lastNameController.text
                    ..registered = true;
                  context.read(repositoryProvider).add(kid);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Saved Child Information')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
