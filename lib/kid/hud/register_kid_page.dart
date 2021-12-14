import 'package:flutter/material.dart';
import 'package:kid_good_good/kid/hud/kid_signup.dart';

import '../../app_bar.dart';
import '../kid.dart';

class RegisterKidPage extends StatelessWidget {
  const RegisterKidPage({
    Key? key,
    required this.title,
    required this.kid,
  }) : super(key: key);

  final String title;
  final Kid kid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UserAppBar(title: title, showPoints: false, showChildName: false),
      body: KidSignupForm(onSubmitted: () => Navigator.pop(context)),
    );
  }
}
