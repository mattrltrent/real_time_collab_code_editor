import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_resizable_container/flutter_resizable_container.dart';
import 'package:provider/provider.dart';
import 'package:uvec/widgets/bottom_indicators.dart';
import 'package:uvec/widgets/file_panels.dart';
import 'package:uvec/widgets/sidebar.dart';
import 'package:uvec/widgets/terminal_panels.dart';

import '../state/state.dart';

class EditorScreen extends StatefulWidget {
  const EditorScreen({super.key});

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  final ResizableController _horizontalController = ResizableController();
  final ResizableController _verticalController = ResizableController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _horizontalController.dispose();
    _verticalController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  KeyEventResult listenForKeyboardShortcuts(FocusNode node, KeyEvent event) {
    final appState = Provider.of<AppState>(context, listen: false);

    if (event is KeyDownEvent) {
      final isMetaPressed = HardwareKeyboard.instance.logicalKeysPressed.contains(LogicalKeyboardKey.metaLeft) ||
          HardwareKeyboard.instance.logicalKeysPressed.contains(LogicalKeyboardKey.metaRight);

      if (isMetaPressed && event.logicalKey == LogicalKeyboardKey.keyJ) {
        appState.toggleTerminal();
        return KeyEventResult.handled;
      } else if (isMetaPressed && event.logicalKey == LogicalKeyboardKey.keyB) {
        appState.toggleSidebar();
        return KeyEventResult.handled;
      }
      // if cmd + w, close the current tab
      else if (isMetaPressed && event.logicalKey == LogicalKeyboardKey.keyW) {
        appState.closeFocusedFile();
        return KeyEventResult.handled;
      }
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      body: Focus(
        autofocus: true,
        onKeyEvent: listenForKeyboardShortcuts,
        child: Column(
          children: [
            Expanded(
              child: ResizableContainer(
                direction: Axis.horizontal,
                controller: _horizontalController,
                children: [
                  if (appState.sidebarShown)
                    ResizableChild(
                      size: const ResizableSize.ratio(0.2),
                      minSize: MediaQuery.of(context).size.width * 0.1,
                      maxSize: MediaQuery.of(context).size.width * 0.5,
                      child: const Sidebar(),
                    ),
                  ResizableChild(
                    size: const ResizableSize.expand(),
                    child: ResizableContainer(
                      direction: Axis.vertical,
                      controller: _verticalController,
                      children: [
                        const ResizableChild(
                          size: ResizableSize.expand(),
                          child: FilePanels(),
                        ),
                        if (appState.terminalShown)
                          ResizableChild(
                            size: const ResizableSize.ratio(0.3),
                            minSize: MediaQuery.of(context).size.height * 0.1,
                            maxSize: MediaQuery.of(context).size.height * 0.8,
                            child: const TerminalPanels(),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const BottomIndicators(),
          ],
        ),
      ),
    );
  }
}
