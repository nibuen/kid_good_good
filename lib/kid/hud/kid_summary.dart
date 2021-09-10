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
                child: Icon(Icons.star, color: Colors.indigoAccent),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: -1,
                      blurRadius: 6,
                      offset: Offset(0, 0), // changes position of shadow
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
