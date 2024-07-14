import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/models.dart';

class FirebaseState extends ChangeNotifier {
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  final Document curDocument =
      Document(id: '0', title: 'title', content: 'content');

  void createUser(String name, List<String> documents) {
    ref.child('users').push().set({
      'name': name,
      'documents': documents,
    });
  }

  void addDocument(String filename, String content) {
    ref.child('documents').push().set({
      'filename': filename,
      'content': content,
    });
  }

  void updateDocument(String id, String title, String content) {
    ref.child('documents').child(id).update({
      'title': title,
      'content': content,
    });
  }

  void detectChange(String id) {
    DatabaseReference curDocument =
        FirebaseDatabase.instance.ref('documents').child(id);
    curDocument.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      updateCurDocument(data);
    });
  }

  void updateCurDocument(var data) {
    //TODO: parse response data
    curDocument.id = data['id'];
    curDocument.title = data['title'];
    curDocument.content = data['content'];
    notifyListeners();
  }
}
