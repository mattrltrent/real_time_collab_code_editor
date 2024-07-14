import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/models.dart';

class FirebaseState extends ChangeNotifier {
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  var _documents = <Document>[];

  //Represents current document state for this user
  List<String> globalText = [''];

  final Document curDocument =
      Document(id: '0', title: 'title', content: 'content');

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
            title: documentData['title'] ??
                documentData['filename'], // Handle both cases
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

  void addDocument(String filename, String content) {
    ref.child('documents').push().set({
      'filename': filename,
      'content': content,
    });
  }

  void detectChange(String id) {
    DatabaseReference curDocument =
        FirebaseDatabase.instance.ref('documents').child(id);
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

  updateDocumentText(String id, String text) {
    print(id);
    ref.child('documents').child(id).update({
      'content': text,
    });
  }

  // void saveDocument(String id, String title, String content) {
  //   updateDocument(id, {
  //     'title': title,
  //     'content': content,
  //   });
  // }

  //void detectChange() {
  //  DatabaseReference docRef =
  //      FirebaseDatabase.instance.ref('documents').child('0');
  //  docRef.onValue.listen((DatabaseEvent event) {
  //    final data = event.snapshot.value;
  //    updateCurDocument(data);
  //  });
  //}

  void updateCurDocument(var data) {
    //TODO: parse response data
    //curDocument.id = data['id'];
    //curDocument.title = data['title'];
    //curDocument.content = data['content'];
    int index = data['index'];
    String text = data['text'];
    globalText.insert(index, text);
    notifyListeners();
  }

  //TODO: Prevent keypress from going into document

  //Can think of document as a long string, we take a position as an index that the user is currently updating, every keypress is sent to the database, with index
  //At a certain interval (database events), the data is updated from the database
  //How do we recreate the document from the database data?
  //We can use a text editing controller to keep track of the current position of the cursor

  void onKeyPress(String key, int curPosition, int newPosition) {
    //get current cursor position
    //insert text from there

    if (curPosition > newPosition) {
      insertText(curPosition, key);
    }
    //else if (curPosition < newPosition) {
    //  deleteText(curPosition, 1);
    //}
  }

  void deleteText(int index, int numChars) {
    for (int i = 0; i < numChars; i++) {
      //delete character at index
      globalText.removeAt(index);
    }
  }

  void insertText(int index, String text) {
    var docText = ref.child('documents').child(curDocument.id);
    for (int i = 0; i < text.length; i++) {
      //insert character at index
      docText.push().set({
        'index': index,
        'text': text[i],
      });
    }
  }
}
