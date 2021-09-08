import 'package:flutter/material.dart';

import '../kid.dart';

class KidSummary extends StatelessWidget {
  KidSummary({
    Key? key,
    required this.kid,
    this.icon = Icons.person,
  }) : super(key: key);

  final IconData icon;
  final Kid kid;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).secondaryHeaderColor,
      margin: EdgeInsets.all(8),
      elevation: 2.5,
      child: ListTile(
        leading: Icon(icon),
        title: Text(
          kid.firstName,
        ),
        subtitle: kid.lastName != null ? Text(kid.lastName!) : null,
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.star),
            Text("${kid.points}"),
          ],
        ),
      ),
    );
  }
}
