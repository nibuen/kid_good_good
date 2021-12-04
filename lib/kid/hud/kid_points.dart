import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kid_good_good/kid/history/history.dart';

import '../kid.dart';
import 'kid_signup.dart';
import 'point_selector.dart';

class SelectedKidPointer extends ConsumerWidget {
  SelectedKidPointer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kid = ref.watch(selectedKidProvider.notifier);
    return AnimatedSize(
      duration: const Duration(milliseconds: 500),
      child: kid.registered
          ? KidPointer(kid: kid)
          : Container(
            child: Text(
                "Select or Add a Child Below",
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center,
              ),
          ),
    );
  }
}


class KidPointer extends ConsumerWidget {
  KidPointer({
    Key? key,
    required this.kid,
    this.initialValue = 20,
    this.dateTime,
    this.historyUpdates = const[],
  }) : super(key: key);

  final Kid kid;
  final int initialValue;

  final DateTime? dateTime;
  final List<PointHistory> historyUpdates;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                    initialValue: initialValue,
                    kid: kid,
                    dateTime: dateTime,
                    historyUpdates: historyUpdates,
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
