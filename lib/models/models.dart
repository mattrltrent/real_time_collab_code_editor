import 'dart:core';

class Document {
  final String id;
  final String title;
  final String content;

  Document({required this.id, required this.title, required this.content});
}

class User {
  final String name;
  final List<String> documents;
  User({required this.name, required this.documents});
}
