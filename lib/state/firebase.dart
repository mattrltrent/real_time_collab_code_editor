import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/models.dart';

class FirebaseState extends ChangeNotifier {
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  var _documents = <Document>[];

  List<Document> get documents => _documents;

  AppState() {
    fetchDocuments();
  }

  void fetchDocuments() {
    ref.child('documents').onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>;
      _documents = data.entries.map((entry) {
        var documentData = entry.value as Map<dynamic, dynamic>;
        return Document(
          id: entry.key,
          title: documentData['title'],
          content: documentData['content'],
        );
      }).toList();
      notifyListeners();
    });
  }

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

}
