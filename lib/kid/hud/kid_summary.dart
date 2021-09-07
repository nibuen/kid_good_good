import 'package:flutter/material.dart';

import '../kid.dart';

class KidSummary extends StatelessWidget {
  KidSummary({
    Key? key,
    required this.kid,
  }) : super(key: key);

  final Kid kid;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).secondaryHeaderColor,
      margin: EdgeInsets.all(8),
      elevation: 2.5,
      child: ListTile(
        leading: Icon(Icons.person),
        title: Text(
          kid.firstName,
        ),
        subtitle: kid.lastName != null ? Text(kid.lastName!) : null,
      ),
    );
  }
}
