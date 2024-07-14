import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uvec/config/typography.dart';
import 'package:uvec/widgets/file_edit.dart';
import 'package:uvec/widgets/file_tab.dart';
import '../state/state.dart';

class FilePanels extends StatefulWidget {
  const FilePanels({super.key});

  @override
  State<FilePanels> createState() => _FilePanelsState();
}

class _FilePanelsState extends State<FilePanels> {
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
                      style: bodyFont.copyWith(color: Theme.of(context).colorScheme.primary),
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
