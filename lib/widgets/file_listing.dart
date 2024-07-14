import 'package:file_icon/file_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uvec/config/typography.dart';
import 'package:uvec/effects/touchable_opacity.dart';

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
  final VoidCallback onEditPressed;
  final VoidCallback onClick;

  @override
  State<FileListing> createState() => _FileListingState();
}

class _FileListingState extends State<FileListing> {
  bool _isHovered = false;

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
          color: Theme.of(context).colorScheme.surface,
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
                child: Text(
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
                      // Rename icon
                      TouchableOpacity(
                        onTap: widget.onEditPressed,
                        child: Padding(
                          padding: const EdgeInsets.all(7),
                          child: Icon(
                            CupertinoIcons.pencil,
                            size: 15,
                            color: Theme.of(context).colorScheme.primary,
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
