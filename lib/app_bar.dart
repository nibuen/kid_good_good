import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'kid/kid.dart';

const double kToolbarHeight = 56.0;

class KidAppBar extends ConsumerWidget with PreferredSizeWidget {
  const KidAppBar({
    Key? key,
    required this.title,
    this.showPoints = true,
  }) : super(key: key);

  final String title;
  final bool showPoints;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return AppBar(
      centerTitle: true,
      title: Text.rich(
        TextSpan(
          text: "${watch(selectedKidsProvider).firstName}'s $title",
          children: <TextSpan>[
            if (showPoints)
              TextSpan(
                text: "   ${watch(selectedKidsProvider).points}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
          ],
        ),
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
        child: Text("${watch(selectedKidsProvider).firstName}"),
      ),
    );
  }
}
