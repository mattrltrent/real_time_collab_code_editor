import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/models.dart';

class FirebaseState extends ChangeNotifier {
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  var _documents = <Document>[];

  List<Document> get documents => _documents;

  FirebaseState() {
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

  void addDocument(String title, String content) {
    ref.child('documents').push().set({
      'title': title,
      'content': content,
    });
  }

  void detectChange(String id) {
    DatabaseReference curDocument = FirebaseDatabase.instance.ref('documents').child(id);
    curDocument.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        updateDocument(id, data);
      }
    });
  }

  void updateDocument(String id, Map<dynamic, dynamic> data) {
    var updatedDocument = Document(
      id: id,
      title: data['title'],
      content: data['content'],
    );

    int index = _documents.indexWhere((doc) => doc.id == id);
    if (index != -1) {
      _documents[index] = updatedDocument;
      notifyListeners();
    }
  }

  void saveDocument(String id, String title, String content) {
    updateDocument(id, {
      'title': title,
      'content': content,
    });
  }

}
