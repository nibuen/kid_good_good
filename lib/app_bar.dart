import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kid_good_good/user/user.dart';

import 'kid/kid.dart';

const double kToolbarHeight = 56.0;

class UserAppBar extends ConsumerWidget with PreferredSizeWidget {
  const UserAppBar({
    Key? key,
    required this.title,
    this.showPoints = true,
    this.showChildName = true,
  }) : super(key: key);

  final String title;

  final bool showPoints;
  final bool showChildName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      centerTitle: true,
      title: Text.rich(
        TextSpan(
          text:
              "${showChildName ? ref.watch(selectedKidProvider).firstName + "'s " : ''}$title",
          children: <TextSpan>[
            if (showPoints)
              TextSpan(
                text: "   ${ref.watch(selectedKidProvider).points}",
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
          child: _UserAvatar(),
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
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, "user_select"),
      child: CircleAvatar(
        foregroundColor: Colors.deepOrange,
        child: Text("${ref.watch(selectedKidProvider).firstName}"),
      ),
    );
  }
}

class _UserAvatar extends ConsumerWidget {
  const _UserAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, "user_select"),
      child: CircleAvatar(
        foregroundColor: Colors.deepOrange,
        child: Text("${ref.watch(selectedUserProvider).firstName}"),
      ),
    );
  }
}