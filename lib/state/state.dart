import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  int _currentView = 0;

  int get currentView => _currentView;

  void updateCurrentView(int newScreen) {
    _currentView = newScreen;
    notifyListeners();
  }
}
