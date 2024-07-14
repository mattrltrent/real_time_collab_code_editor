import 'package:file_icon/file_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uvec/config/typography.dart';
import 'package:uvec/effects/touchable_opacity.dart';
import 'package:uvec/models/models.dart';

class FileTab extends StatefulWidget {
  const FileTab(
      {super.key, required this.document, required this.onClose, required this.onSelect, required this.isSelected});

  final Document document;
  final VoidCallback onClose;
  final VoidCallback onSelect;
  final bool isSelected;

  @override
  State<FileTab> createState() => _FileTabState();
}

class _FileTabState extends State<FileTab> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    // Extract the file extension
    final String fileExtension = widget.document.title.split('.').last;

    return TouchableOpacity(
      onTap: widget.onSelect,
      child: MouseRegion(
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
        cursor: SystemMouseCursors.click,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            border: Border(
              bottom: BorderSide(
                color: widget.isSelected
                    ? Theme.of(context).colorScheme.secondary
                    : _isHovered
                        ? Theme.of(context).colorScheme.primary
                        : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // File extension icon
              FileIcon(
                '.$fileExtension',
                size: 24.0,
              ),
              // File name
              Text(
                widget.document.title,
                style: miniFont.copyWith(color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(width: 8.0),
              // Close button
              TouchableOpacity(
                child: Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Icon(
                    CupertinoIcons.xmark,
                    size: 12.0,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                onTap: widget.onClose,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
