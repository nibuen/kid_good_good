import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../kid.dart';
import 'kid_signup.dart';
import 'point_selector.dart';

class SelectedKidPointer extends ConsumerWidget {
  SelectedKidPointer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final kid = watch(selectedKidsProvider.notifier);
    return kid.registered
        ? Card(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    '${kid.firstName} ${kid.lastName}',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  PointSelector(
                    initialValue: 20,
                    kid: kid,
                  )
                ],
              ),
            ),
          )
        : Text(
            "Select or Add a Child Below",
            style: Theme.of(context).textTheme.headline4,
            textAlign: TextAlign.center,
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
            child: KidSignupForm(),
          );
  }
}
