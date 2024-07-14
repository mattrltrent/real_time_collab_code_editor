import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uvec/config/constants.dart';
import 'package:uvec/state/state.dart';
import 'package:uvec/widgets/terminal_tab_text.dart';

class TerminalPanels extends StatefulWidget {
  const TerminalPanels({super.key});

  @override
  State<TerminalPanels> createState() => _TerminalPanelsState();
}

class _TerminalPanelsState extends State<TerminalPanels> {
  String getDummyBody() {
    switch (Provider.of<AppState>(context).terminalTabSelected) {
      case 0:
        return dummyProblems;
      case 1:
        return dummyOutput;
      case 2:
        return dummyDebugConsole;
      case 3:
        return dummyPorts;
      case 4:
        return dummyTerminal;
      case 5:
        return dummyComments;
      default:
        return dummyProblems;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.shadow,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Wrap(
                  // min height
                  alignment: WrapAlignment.start,
                  runAlignment: WrapAlignment.start,
                  children: [
                    TerminalTabText(
                        idx: 0,
                        text: "Problems",
                        onTap: (i) => Provider.of<AppState>(context, listen: false).setTerminalTabSelected(i)),
                    const SizedBox(width: 20),
                    TerminalTabText(
                        idx: 1,
                        text: "Output",
                        onTap: (i) => Provider.of<AppState>(context, listen: false).setTerminalTabSelected(i)),
                    const SizedBox(width: 20),
                    TerminalTabText(
                        idx: 2,
                        text: "Debug console",
                        onTap: (i) => Provider.of<AppState>(context, listen: false).setTerminalTabSelected(i)),
                    const SizedBox(width: 20),
                    TerminalTabText(
                        idx: 3,
                        text: "Ports",
                        onTap: (i) => Provider.of<AppState>(context, listen: false).setTerminalTabSelected(i)),
                    const SizedBox(width: 20),
                    TerminalTabText(
                        idx: 4,
                        text: "Terminal",
                        onTap: (i) => Provider.of<AppState>(context, listen: false).setTerminalTabSelected(i)),
                    const SizedBox(width: 20),
                    TerminalTabText(
                        idx: 5,
                        text: "Comments",
                        onTap: (i) => Provider.of<AppState>(context, listen: false).setTerminalTabSelected(i)),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: double.infinity,
                color: Theme.of(context).colorScheme.shadow,
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  child: Text(
                    getDummyBody(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
