import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kid_good_good/kid/history/history.dart';

import '../kid.dart';
import 'kid_signup.dart';
import 'point_selector.dart';

class SelectedKidPointer extends ConsumerWidget {
  const SelectedKidPointer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kid = ref.watch(selectedKidProvider);
    return AnimatedSize(
      duration: const Duration(milliseconds: 500),
      child: kid.registered
          ? KidPointsOrRegister(kid: kid)
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

class KidPointsOrRegister extends ConsumerWidget {
  KidPointsOrRegister({
    Key? key,
    required this.kid,
    this.initialValue = 20,
    this.initialDateTime,
    this.historyUpdates = const [],
  }) : super(key: key);

  final Kid kid;
  final int initialValue;

  final DateTime? initialDateTime;
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
                    kidRepository: ref.read(repositoryProvider),
                    initialDateTime: initialDateTime,
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
