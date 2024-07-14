import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uvec/config/typography.dart';
import 'package:uvec/widgets/file_edit.dart';
import 'package:uvec/widgets/file_tab.dart';
import '../models/models.dart';
import '../state/state.dart';
import '../state/firebase.dart';

class FilePanels extends StatefulWidget {
  const FilePanels({super.key});

  @override
  State<FilePanels> createState() => _FilePanelsState();
}

class _FilePanelsState extends State<FilePanels> {
  @override
  void initState() {
    super.initState();
    final firebaseState = Provider.of<FirebaseState>(context, listen: false);
    firebaseState.addListener(_onDocumentsUpdated);
  }

  void _onDocumentsUpdated() {
    final appState = Provider.of<AppState>(context, listen: false);
    final firebaseState = Provider.of<FirebaseState>(context, listen: false);

    final openFileIds = appState.openFiles.map((doc) => doc.id).toList();
    final documentIds = firebaseState.documents.map((doc) => doc.id).toList();

    // Remove files from openFiles if they are no longer in Firebase
    final filesToRemove = openFileIds.where((id) => !documentIds.contains(id)).toList();
    for (var id in filesToRemove) {
      final doc = appState.openFiles.firstWhere((doc) => doc.id == id);
      appState.removeOpenFile(doc);
    }

    // Update titles of open files if they have changed in Firebase
    final updatedDocuments = firebaseState.documents.where((doc) => openFileIds.contains(doc.id)).toList();
    for (var updatedDoc in updatedDocuments) {
      final openDocIndex = appState.openFiles.indexWhere((doc) => doc.id == updatedDoc.id);
      if (openDocIndex != -1 && appState.openFiles[openDocIndex].title != updatedDoc.title) {
        appState.updateOpenFile(updatedDoc);
      }
    }
  }

  @override
  void dispose() {
    final firebaseState = Provider.of<FirebaseState>(context, listen: false);
    firebaseState.removeListener(_onDocumentsUpdated);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: appState.openFiles.map((document) {
                  return FileTab(
                    document: document,
                    isSelected: document.id == appState.selectedFileId,
                    onClose: () => appState.removeOpenFile(document),
                    onSelect: () => appState.setSelectedFileId(document.id),
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
            child: appState.openFiles.isEmpty
                ? Center(
                    child: Text(
                      "No files open",
                      style: miniFont.copyWith(color: Theme.of(context).colorScheme.primary),
                    ),
                  )
                : IndexedStack(
                    index: appState.openFiles.indexWhere((doc) => doc.id == appState.selectedFileId),
                    children: appState.openFiles.map((document) {
                      return FileEdit(doc: document);
                    }).toList(),
                  ),
          ),
        ],
      ),
    );
  }
}
