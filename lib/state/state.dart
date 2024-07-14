import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  bool _terminalShown = true;
  bool _sidebarShown = true;
  int _terminalTabSelected = 0;

  bool get terminalShown => _terminalShown;
  bool get sidebarShown => _sidebarShown;
  int get terminalTabSelected => _terminalTabSelected;

  void toggleTerminal() {
    _terminalShown = !_terminalShown;
    notifyListeners();
  }

  void toggleSidebar() {
    _sidebarShown = !_sidebarShown;
    notifyListeners();
  }

  void setTerminalTabSelected(int idx) {
    _terminalTabSelected = idx;
    notifyListeners();
  }
}
