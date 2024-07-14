import 'dart:core';

class Document {
  String id;
  String title;
  String content;

  Document({required this.id, required this.title, required this.content});
}

class User {
  String name;
  List<String> documents;
  User({required this.name, required this.documents});
}
