import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kid_good_good/point_selector.dart';

import 'app_bar.dart';
import 'kid/history/history.dart';
import 'kid/kid.dart';
import 'kid/reward/rewards_page.dart';

void main() async {
  await Hive.initFlutter();
  Hive
    ..registerAdapter(KidAdapter())
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

final kidStreamProvider = StreamProvider<Kid>((ref) async* {
  final usersBox = ref.watch(boxProvider);

  yield* Stream.value(usersBox.get(0,
      defaultValue: Kid(firstName: "new", registered: false)) as Kid);
  yield* usersBox.watch(key: 0).map((usersBoxEvent) {
    return usersBoxEvent.value == null
        ? Kid(firstName: "new", registered: false)
        : usersBoxEvent.value as Kid;
  });
});

// class SelectedKid extends StateNotifier<Kid> {
//   SelectedKid() : super(Kid(firstName: 'Ezra'));
// }

// final userProvider = StreamProvider.autoDispose.family<Kid, String>((ref, id) {
//
// });

// final kidProvider = ChangeNotifierProvider<Kid>(
//   (ref) {
//     return ref.watch(selectedKidProvider).when(
//         data: (data) {
//           debugPrint("new data ${data.firstName}");
//           return data;
//         },
//         loading: () => Kid(firstName: "new", registered: false),
//         error: (e, s) => Kid(firstName: "new", registered: false));
//   },
// );

//final selectedKidProvider = Provider<ChangeNotifierProvider<Kid>>((ref) => ref.watch(kidProvider));

final selectedKidProvider = FutureProvider<Kid>((ref) async {
  final kid = await ref.watch(kidStreamProvider.last);
  //final kid = ref.watch(kidProvider.notifier);
  debugPrint("new kid selected ${kid.firstName}");
  return kid;
});

// final kidProvider = StateNotifierProvider<SelectedKid, Kid>(
//   (ref) => ref.watch(kidStreamProvider).when(
//       data: (data) {
//         debugPrint("new data ${data.firstName}");
//         return data;
//       },
//       loading: () => Kid(firstName: "new", registered: false),
//       error: (e, s) => Kid(firstName: "new", registered: false)),
// );
//
// class SelectedKid extends StateNotifier<Kid> {
//   SelectedKid() : super(Kid(firstName: 'Ezra'));
// }

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
      },
    );
  }
}

class SummaryPage extends StatefulWidget {
  const SummaryPage({Key? key}) : super(key: key);

  @override
  _SummaryPageState createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
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
            KidPointer(),
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

class KidPointer extends ConsumerWidget {
  KidPointer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return watch(selectedKidProvider).when(
      data: (kid) {
        debugPrint("${kid.firstName} built for pointer");
        return kid.registered
            ? Card(
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        kid.firstName,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      PointSelector(
                        initialValue: 20,
                        kid: kid,
                      ),
                    ],
                  ),
                ),
              )
            : Card(
                child: MyCustomForm(kid: kid),
              );
      },
      loading: () => Card(),
      error: (error, stack) => Card(),
    );
  }
}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({
    Key? key,
    required this.kid,
  }) : super(key: key);

  final Kid kid;

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
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
          TextFormField(
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
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final kid = widget.kid;
                kid.firstName = firstNameController.text;
                kid.lastName = firstNameController.text;
                kid.registered = true;
                kid.save();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Saved Child Information')),
                );
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
