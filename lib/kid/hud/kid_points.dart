import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../main.dart';
import '../kid.dart';
import 'point_selector.dart';

class SelectedKidPointer extends ConsumerWidget {
  SelectedKidPointer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return watch(selectedKidProvider).when(
      data: (kid) {
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
                child: MyCustomForm(),
              );
      },
      loading: () => Card(
        child: Text(
          "Loading",
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      error: (error, stack) {
        print(error);
        return Card(
        child: Text(
          "$error",
          style: Theme.of(context).textTheme.headline4,
        ),
      );
      },
    );
  }
}

class KidPointer extends ConsumerWidget {
  KidPointer({
    Key? key,
    required this.kid,
  }) : super(key: key);

  final Kid kid;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
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
            child: MyCustomForm(),
          );
  }
}
