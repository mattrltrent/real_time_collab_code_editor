import 'package:flutter/material.dart';
import 'package:uvec/widgets/file_tab.dart';

class FilePanels extends StatefulWidget {
  const FilePanels({super.key});

  @override
  State<FilePanels> createState() => _FilePanelsState();
}

class _FilePanelsState extends State<FilePanels> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FileTab(
                    text: "server.js",
                  ),
                  FileTab(
                    text: "main.go",
                  ),
                  FileTab(
                    text: "pain.css",
                  ),
                  FileTab(
                    text: "dsa.cpp",
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: IndexedStack(
              children: [
                Container(
                  color: Colors.red,
                ),
                Container(
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
