import 'package:flutter/material.dart';

import '../kid.dart';

class KidSummaryTile extends StatelessWidget {
  KidSummaryTile({
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
      margin: const EdgeInsets.all(8),
      elevation: 2.5,
      child: ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon),
          ],
        ),
        title: Text(
          kid.firstName,
        ),
        subtitle: kid.lastName != null ? Text(kid.lastName!) : null,
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 4),
                child: Icon(Icons.star, color: Theme.of(context).colorScheme.secondary),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.25),
                      spreadRadius: -1,
                      blurRadius: 6,
                      offset: const Offset(0, -3), // changes position of shadow
                    ),
                  ],
                )),
            Text("${kid.points}"),
          ],
        ),
      ),
    );
  }
}
