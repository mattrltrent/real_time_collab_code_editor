import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';
import 'package:highlight/highlight.dart';
import 'package:highlight/languages/all.dart' as all;
import 'package:uvec/config/typography.dart';

class FileEdit extends StatefulWidget {
  const FileEdit({super.key, required this.filename});

  final String filename;

  @override
  State<FileEdit> createState() => _FileEditState();
}

class _FileEditState extends State<FileEdit> {
  late CodeController _controller;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  void _initializeController() {
    final String langExtension = widget.filename.split('.').last;
    final Mode language = _getLanguageByExtension(langExtension);

    _controller = CodeController(
      text: "console.log('Hello, World!');",
      language: language,
    );

    _controller.addListener(() {
      setState(() {});
    });

    // Disable auto completion
    _controller.popupController.enabled = false;
  }

  Mode _getLanguageByExtension(String extension) {
    const extensionToLanguage = {
      'dart': 'dart',
      'yaml': 'yaml',
      'yml': 'yaml',
      'sql': 'sql',
      'js': 'javascript',
      'ts': 'typescript',
      'json': 'json',
      'html': 'html',
      'css': 'css',
      'cpp': 'cpp',
      'java': 'java',
      'py': 'python',
      'rb': 'ruby',
      'php': 'php',
      'sh': 'bash',
      'md': 'markdown',
    };

    final languageKey = extensionToLanguage[extension] ?? 'plaintext';
    return all.allLanguages[languageKey]!;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff282c34),
      height: double.infinity,
      child: CodeTheme(
        data: CodeThemeData(styles: atomOneDarkTheme),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: CodeField(
            lineNumbers: true,
            wrap: true,
            lineNumberBuilder: (i, style) {
              return TextSpan(
                text: '${i + 1}',
                style: codeFont.copyWith(height: 1.5),
              );
            },
            controller: _controller,
            textStyle: codeFont.copyWith(height: 1.5),
          ),
        ),
      ),
    );
  }
}
