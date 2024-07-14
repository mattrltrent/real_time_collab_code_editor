import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class AppState extends ChangeNotifier {
  DatabaseReference ref = FirebaseDatabase.instance.ref();

  void createUser(String name, List<String> documents) {
    ref.child('users').push().set({
      'name': name,
      'documents': documents,
    });
  }

  void addDocument(String title, String content) {
    ref.child('documents').push().set({
      'title': title,
      'content': content,
    });
  }

  void updateDocument(String id, String title, String content) {
    ref.child('documents').child(id).update({
      'title': title,
      'content': content,
    });
  }
}
