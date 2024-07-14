import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class AppState extends ChangeNotifier {
  DatabaseReference ref = FirebaseDatabase.instance.ref();
}
