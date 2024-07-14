import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';
import 'package:flutter_highlight/themes/atom-one-light.dart';
import 'package:highlight/highlight.dart';
import 'package:highlight/languages/all.dart' as all;
import 'package:provider/provider.dart';
import 'package:uvec/config/typography.dart';
import 'package:uvec/state/firebase.dart';
import 'package:uvec/models/models.dart';

class FileEdit extends StatefulWidget {
  const FileEdit({super.key, required this.doc});

  final Document doc;

  @override
  State<FileEdit> createState() => _FileEditState();
}

class _FileEditState extends State<FileEdit> {
  late CodeController _controller;
  String _lastSyncedContent = '';
  bool _isUpdating = false;
  TextSelection? _lastSelection;

  @override
  void initState() {
    super.initState();
    _initializeController();

    final firebaseState = Provider.of<FirebaseState>(context, listen: false);
    firebaseState.detectChange(widget.doc.id);

    firebaseState.addListener(_onDocumentUpdated);
  }

  void _initializeController() {
    final String langExtension = widget.doc.title.split('.').last;
    final Mode language = _getLanguageByExtension(langExtension);

    _controller = CodeController(
      text: widget.doc.content,
      language: language,
    );

    _lastSyncedContent = widget.doc.content;

    _controller.addListener(_onLocalChange);

    // Disable auto completion
    _controller.popupController.enabled = false;
  }

  void _onLocalChange() {
    if (!_isUpdating) {
      setState(() {});
      _syncWithFirebase();
    }
  }

  void _onDocumentUpdated() {
    final firebaseState = Provider.of<FirebaseState>(context, listen: false);
    final updatedDoc = firebaseState.documents.firstWhere((doc) => doc.id == widget.doc.id, orElse: () => widget.doc);

    if (updatedDoc.content != _lastSyncedContent) {
      _mergeRemoteChanges(updatedDoc.content);
      _lastSyncedContent = updatedDoc.content;
    }
  }

  void _mergeRemoteChanges(String remoteContent) {
    _isUpdating = true;

    // Get current cursor position
    final cursorPosition = _controller.selection.baseOffset;

    // Merge remote changes with the current content
    _controller.text = remoteContent;

    // Restore cursor position if possible
    if (cursorPosition >= 0 && cursorPosition <= _controller.text.length) {
      _controller.selection = TextSelection.collapsed(offset: cursorPosition);
    }

    _isUpdating = false;
  }

  void _syncWithFirebase() {
    final firebaseState = Provider.of<FirebaseState>(context, listen: false);
    firebaseState.updateContent(widget.doc.id, _controller.text);
    _lastSyncedContent = _controller.text;
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
      'c': 'c',
      'h': 'cpp',
      'hpp': 'cpp',
      'java': 'java',
      'py': 'python',
      'rb': 'ruby',
      'php': 'php',
      'sh': 'bash',
      'bash': 'bash',
      'zsh': 'bash',
      'md': 'markdown',
      'go': 'go',
      'swift': 'swift',
      'kotlin': 'kotlin',
      'kt': 'kotlin',
      'rs': 'rust',
      'r': 'r',
      'pl': 'perl',
      'pm': 'perl',
      'scala': 'scala',
      'sc': 'scala',
      'groovy': 'groovy',
      'lua': 'lua',
      'xml': 'xml',
      'xsl': 'xml',
      'xslt': 'xml',
      'm': 'objectivec',
      'mm': 'objectivec',
      'vb': 'vbnet',
      'cs': 'csharp',
      'fs': 'fsharp',
      'erl': 'erlang',
      'ex': 'elixir',
      'exs': 'elixir',
      'hs': 'haskell',
      'jl': 'julia',
      'nim': 'nim',
      'd': 'd',
      'tsv': 'tsv',
      'csv': 'csv',
      'ini': 'ini',
      'conf': 'ini',
      'toml': 'toml',
      'dockerfile': 'dockerfile',
      'tf': 'hcl',
      'rake': 'ruby',
      'haml': 'ruby',
      'sass': 'sass',
      'scss': 'scss',
      'less': 'less',
      'styl': 'stylus',
      'coffee': 'coffeescript',
      'hx': 'haxe',
      'tex': 'latex',
      'cls': 'latex',
      'sty': 'latex',
      'lisp': 'lisp',
      'cl': 'lisp',
      'lsp': 'lisp',
      'scm': 'scheme',
      'rkt': 'scheme',
      'vhdl': 'vhdl',
      'verilog': 'verilog',
      'sv': 'systemverilog',
      'v': 'verilog',
      'bsv': 'bluespec',
      'bib': 'bibtex',
      'rmd': 'markdown',
      'pug': 'pug',
      'jade': 'pug',
      'ejs': 'ejs',
      'erb': 'erb',
      'hbs': 'handlebars',
      'jsp': 'jsp',
      'asp': 'asp',
      'aspx': 'aspx',
      'j2': 'jinja',
      'jinja': 'jinja',
      'twig': 'twig',
      'liquid': 'liquid',
      'mustache': 'mustache',
      'nunjucks': 'nunjucks',
      'njk': 'nunjucks',
      'soy': 'closuretemplates',
      'dot': 'graphviz',
      'gv': 'graphviz',
      'proto': 'protobuf',
      'thrift': 'thrift',
      'avdl': 'avro',
      'sol': 'solidity',
      'purs': 'purescript',
      'ml': 'ocaml',
      'mli': 'ocaml',
      'pp': 'puppet',
    };

    final languageKey = extensionToLanguage[extension] ?? 'plaintext';
    return all.allLanguages[languageKey]!;
  }

  @override
  void dispose() {
    final firebaseState = Provider.of<FirebaseState>(context, listen: false);
    firebaseState.removeListener(_onDocumentUpdated);

    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MediaQuery.of(context).platformBrightness == Brightness.dark
          ? const Color(0xff282c34)
          : const Color(0xfffafafa),
      height: double.infinity,
      child: CodeTheme(
        data: CodeThemeData(
          styles: MediaQuery.of(context).platformBrightness == Brightness.dark ? atomOneDarkTheme : atomOneLightTheme,
        ),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: KeyboardListener(
            focusNode: FocusNode(),
            onKeyEvent: (event) {
              _onLocalChange();
            },
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
      ),
    );
  }
}
