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
              final firebaseState = Provider.of<FirebaseState>(context, listen: false);
              firebaseState.addDocument('test', textController.text);
            },
            child: const Text('Submit'),
          ),
          Expanded(
            child: Consumer<FirebaseState>(
              builder: (context, firebaseState, child) {
                if (firebaseState.documents.isEmpty) {
                  return Center(child: Text('No documents found.'));
                }
                return ListView.builder(
                  itemCount: firebaseState.documents.length,
                  itemBuilder: (context, index) {
                    final document = firebaseState.documents[index];
                    return ListTile(
                      title: Text(document.title),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

