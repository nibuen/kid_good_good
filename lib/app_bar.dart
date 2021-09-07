import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'main.dart';

const double kToolbarHeight = 56.0;

class KidAppBar extends ConsumerWidget with PreferredSizeWidget {
  const KidAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return AppBar(
      title: watch(selectedKidProvider).when(
        data: (kid) => Text("$title - Points: ${kid.points}"),
        loading: () => Text("$title"),
        error: (_, __) => Text("$title"),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: _KidAvatar(),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _KidAvatar extends ConsumerWidget {
  const _KidAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, "user_select"),
      child: CircleAvatar(
        foregroundColor: Colors.deepOrange,
        child: watch(selectedKidProvider).when(
          data: (kid) => Text("${kid.firstName}"),
          loading: () => Icon(Icons.new_label),
          error: (_, __) => Icon(Icons.error),
        ),
      ),
    );
  }
}
