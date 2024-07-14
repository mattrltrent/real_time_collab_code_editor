import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  int _currentView = 0;
  bool _terminalShown = true;
  bool _sidebarShown = true;

  int get currentView => _currentView;
  bool get terminalShown => _terminalShown;
  bool get sidebarShown => _sidebarShown;

  void updateCurrentView(int newScreen) {
    _currentView = newScreen;
    notifyListeners();
  }

  void toggleTerminal() {
    _terminalShown = !_terminalShown;
    notifyListeners();
  }

  void toggleSidebar() {
    _sidebarShown = !_sidebarShown;
    notifyListeners();
  }
}
