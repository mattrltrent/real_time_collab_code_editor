import 'package:flutter/material.dart';
import 'package:uvec/models/models.dart';
import 'package:collection/collection.dart';

class AppState extends ChangeNotifier {
  bool _terminalShown = true;
  bool _sidebarShown = true;
  int _terminalTabSelected = 1;
  List<Document> _openFiles = [];
  String? _selectedFileId;

  bool get terminalShown => _terminalShown;
  bool get sidebarShown => _sidebarShown;
  int get terminalTabSelected => _terminalTabSelected;
  List<Document> get openFiles => _openFiles;
  String? get selectedFileId => _selectedFileId;

  void toggleTerminal() {
    _terminalShown = !_terminalShown;
    notifyListeners();
  }

  void updateOpenFile(Document updatedFile) {
    int index = _openFiles.indexWhere((doc) => doc.id == updatedFile.id);
    if (index != -1) {
      _openFiles[index] = updatedFile;
      notifyListeners();
    }
  }

  void toggleSidebar() {
    _sidebarShown = !_sidebarShown;
    notifyListeners();
  }

  void setTerminalTabSelected(int idx) {
    _terminalTabSelected = idx;
    notifyListeners();
  }

  void addOpenFile(Document file) {
    _openFiles.add(file);
    notifyListeners();
  }

  int getIdxOfOpenFile(Document file) {
    return _openFiles.indexWhere((doc) => doc.id == file.id);
  }

  void closeFocusedFile() {
    if (_selectedFileId != null) {
      Document? file = _openFiles.firstWhereOrNull((doc) => doc.id == _selectedFileId);
      if (file != null) {
        removeOpenFile(file);
      }
    }
  }

  void removeOpenFile(Document file) {
    _openFiles.removeWhere((doc) => doc.id == file.id);
    if (_selectedFileId == file.id) {
      _selectedFileId = null;
    }

    // if there is still a file open, set the one closest on the left to the removed one
    if (_openFiles.isNotEmpty) {
      _selectedFileId = _openFiles.last.id;
    } else {
      _selectedFileId = null;
    }
    notifyListeners();
  }

  // clear all open files
  void clearOpenFiles() {
    _openFiles.clear();
    _selectedFileId = null;
    notifyListeners();
  }

  void setSelectedFileId(String? id) {
    _selectedFileId = id;
    notifyListeners();
  }

  Document? getSelectedFile() {
    return _openFiles.firstWhereOrNull((doc) => doc.id == _selectedFileId);
  }
}
