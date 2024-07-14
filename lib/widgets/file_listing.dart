import 'package:file_icon/file_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uvec/config/typography.dart';
import 'package:uvec/effects/touchable_opacity.dart';
import 'package:uvec/state/firebase.dart';
import 'package:uvec/widgets/banner.dart';
import 'package:alert_banner/exports.dart';

class FileListing extends StatefulWidget {
  const FileListing({
    super.key,
    required this.fileName,
    required this.onDeletePressed,
    required this.onEditPressed,
    required this.onClick,
  });

  final String fileName; // like server.js
  final VoidCallback onDeletePressed;
  final ValueChanged<String> onEditPressed;
  final VoidCallback onClick;

  @override
  State<FileListing> createState() => _FileListingState();
}

class _FileListingState extends State<FileListing> {
  bool _isHovered = false;
  bool _isEditing = false;
  late TextEditingController _textController;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.fileName);
  }

  void _startEditing() {
    setState(() {
      _isEditing = true;
    });
    _focusNode.requestFocus();
  }

  void _submitEdit() {
    final text = _textController.text;
    bool weirdChars = RegExp(r'[^\w\-.]').hasMatch(text);
    if (text.isNotEmpty && !text.contains(' ') && !weirdChars) {
      setState(() {
        _isEditing = false;
        widget.onEditPressed(_textController.text);
      });
    } else {
      showAlertBanner(
        context,
        () {},
        const MyBanner(text: "Invalid file name, try newFile.js"),
        maxLength: 500,
      );
    }
  }

  void _cancelEdit() {
    setState(() {
      _isEditing = false;
      _textController.text = widget.fileName; // Reset to original file name
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Extract the file extension
    final String fileExtension = widget.fileName.split('.').last;

    return TouchableOpacity(
      onTap: widget.onClick,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) {
          setState(() {
            _isHovered = true;
          });
        },
        onExit: (_) {
          setState(() {
            _isHovered = false;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            border: Border.all(
              color: _isEditing ? Theme.of(context).colorScheme.secondary : Colors.transparent,
            ),
          ),
          padding: const EdgeInsets.only(left: 5, top: 3, bottom: 3),
          child: Row(
            children: [
              // File extension icon
              FileIcon(
                '.$fileExtension',
                size: 24.0,
              ),
              const SizedBox(width: 8.0),
              // File name
              Expanded(
                child: _isEditing
                    ? Focus(
                        onKey: (node, event) {
                          if (event is RawKeyDownEvent) {
                            if (event.logicalKey == LogicalKeyboardKey.enter) {
                              _submitEdit();
                              return KeyEventResult.handled;
                            } else if (event.logicalKey == LogicalKeyboardKey.escape) {
                              _cancelEdit();
                              return KeyEventResult.handled;
                            }
                          }
                          return KeyEventResult.ignored;
                        },
                        child: TextField(
                          controller: _textController,
                          focusNode: _focusNode,
                          style: miniFont.copyWith(color: Theme.of(context).colorScheme.primary),
                          onSubmitted: (_) => _submitEdit(),
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                            border: InputBorder.none,
                          ),
                        ),
                      )
                    : Text(
                        widget.fileName,
                        style: miniFont.copyWith(color: Theme.of(context).colorScheme.primary),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
              ),
              Opacity(
                opacity: _isHovered ? 1 : 0,
                child: IgnorePointer(
                  ignoring: !_isHovered,
                  child: Row(
                    children: [
                      // Rename icon or Check mark icon
                      TouchableOpacity(
                        onTap: _isEditing ? _submitEdit : _startEditing,
                        child: Padding(
                          padding: const EdgeInsets.all(7),
                          child: Icon(
                            _isEditing ? CupertinoIcons.check_mark : CupertinoIcons.pencil,
                            size: 15,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                      // Garbage icon
                      TouchableOpacity(
                        onTap: widget.onDeletePressed,
                        child: Padding(
                          padding: const EdgeInsets.all(7),
                          child: Icon(
                            CupertinoIcons.trash,
                            size: 14,
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
