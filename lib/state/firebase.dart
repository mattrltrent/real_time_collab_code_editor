import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/models.dart';

class FirebaseState extends ChangeNotifier {
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  var _documents = <Document>[];

  // Represents current document state for this user
  List<String> globalText = [''];

  final Document curDocument = Document(id: '0', title: 'title', content: 'content');

  List<Document> get documents => _documents;

  FirebaseState() {
    fetchDocuments();
  }

  void fetchDocuments() {
    ref.child('documents').onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      print('Data fetched from Firebase: $data'); // Debugging statement
      if (data != null) {
        _documents = data.entries
            .map((entry) {
              var documentData = entry.value as Map<dynamic, dynamic>;
              if (documentData['title'] != null || documentData['filename'] != null) {
                return Document(
                  id: entry.key,
                  title: documentData['title'] ?? documentData['filename'],
                  content: documentData['content'] ?? '',
                );
              }
            })
            .whereType<Document>()
            .toList(); // Filter out null values
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
      if (documentData['title'] != null || documentData['filename'] != null) {
        return Document(
          id: id,
          title: documentData['title'] ?? documentData['filename'],
          content: documentData['content'] ?? '',
        );
      }
    }
    return null;
  }

  void addDocument(String filename, String content) {
    ref.child('documents').push().set({
      'filename': filename,
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
      title: data['title'] ?? data['filename'],
      content: data['content'] ?? '',
    );

    int index = _documents.indexWhere((doc) => doc.id == id);
    if (index != -1) {
      _documents[index] = updatedDocument;
      notifyListeners();
    }
  }

  void updateFilename(String id, String filename) {
    FirebaseDatabase.instance.ref('documents').child(id).update({
      'filename': filename,
    });

    int index = _documents.indexWhere((doc) => doc.id == id);
    if (index != -1) {
      _documents[index].title = filename;
      notifyListeners();
    }
    print('Filename updated to $filename'); // Debugging statement
  }

  void updateContent(String id, String content) {
    FirebaseDatabase.instance.ref('documents').child(id).update({
      'content': content,
    });
    int index = _documents.indexWhere((doc) => doc.id == id);
    if (index != -1) {
      _documents[index].content = content;
      notifyListeners();
    }
    print('Content updated to $content'); // Debugging statement
  }

  void deleteDocument(String id) {
    FirebaseDatabase.instance.ref('documents').child(id).remove();
  }

  void updateCurDocument(var data) {
    int index = data['index'];
    String text = data['text'];
    globalText.insert(index, text);
    notifyListeners();
  }

  void onKeyPress(String key, int curPosition, int newPosition) {
    if (curPosition > newPosition) {
      insertText(curPosition, key);
    }
  }

  void deleteText(int index, int numChars) {
    for (int i = 0; i < numChars; i++) {
      globalText.removeAt(index);
    }
  }

  void insertText(int index, String text) {
    var docText = ref.child('documents').child(curDocument.id);
    for (int i = 0; i < text.length; i++) {
      docText.push().set({
        'index': index,
        'text': text[i],
      });
    }
  }
}
