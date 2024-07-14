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
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      print('Data fetched from Firebase: $data'); // Debugging statement
      if (data != null) {
        _documents = data.entries.map((entry) {
          var documentData = entry.value as Map<dynamic, dynamic>;
          return Document(
            id: entry.key,
            title: documentData['title'] ?? documentData['filename'], // Handle both cases
            content: documentData['content'],
          );
        }).toList();
        print('Parsed documents: $_documents'); // Debugging statement
        notifyListeners();
      } else {
        print('No data found in the documents node'); // Debugging statement
      }
    });
  }

  Future<Document?> fetchDocumentById(String id) async {
    DatabaseReference documentRef = ref.child('documents').child(id);
    DatabaseEvent event = await documentRef.once();
    if (event.snapshot.value != null) {
      var documentData = event.snapshot.value as Map<dynamic, dynamic>;
      return Document(
        id: id,
        title: documentData['title'],
        content: documentData['content'],
      );
    }
    return null;
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
