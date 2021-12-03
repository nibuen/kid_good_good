import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kid_good_good/kid/kid.dart';

class KidSignupForm extends ConsumerStatefulWidget {
  const KidSignupForm({
    Key? key,
    this.onSubmitted,
  }) : super(key: key);

  final VoidCallback? onSubmitted;

  @override
  KidSignupFormState createState() {
    return KidSignupFormState();
  }
}

class KidSignupFormState extends ConsumerState<KidSignupForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: firstNameController,
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Child\'s First Name?',
                labelText: 'First Name *',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: lastNameController,
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Child\'s Last Name?',
                labelText: 'Last Name',
              ),
              validator: (value) {
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final kid = KidHive(firstName: firstNameController.text)
                    ..lastName = lastNameController.text
                    ..registered = true;
                  ref.read(repositoryProvider).add(kid);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Saved Child Information')),
                  );
                }

                if (widget.onSubmitted != null) widget.onSubmitted!();
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
