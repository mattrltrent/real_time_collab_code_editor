import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uvec/state/firebase.dart';
import '../models/models.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  final _formKey = GlobalKey<FormState>();
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextField(
              controller: textController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Data',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                // If the form is valid, display a snackbar. In the real world,
                // you'd often call a server or save the information in a database.
                final firebaseState =
                    Provider.of<FirebaseState>(context, listen: false);
                firebaseState.addDocument('test', textController.text);
              },
              child: const Text('Submit'),
            ),
          ],
        ));
  }
}
