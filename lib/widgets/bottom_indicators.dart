import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uvec/state/state.dart';
import 'package:uvec/widgets/info_text.dart';

class BottomIndicators extends StatefulWidget {
  const BottomIndicators({super.key});

  @override
  State<BottomIndicators> createState() => _BottomIndicatorsState();
}

class _BottomIndicatorsState extends State<BottomIndicators> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.shadow,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            // align horizontally left
            children: [
              InfoText(
                text: "main",
                icon: CupertinoIcons.arrow_branch,
                onTap: () => print("tap"),
              ),
              SizedBox(width: 20),
              InfoText(
                text: "sync",
                icon: CupertinoIcons.upload_circle,
                onTap: () => print("tap"),
              ),
              SizedBox(width: 20),
              InfoText(
                text: "live share",
                icon: CupertinoIcons.arrowshape_turn_up_right,
                onTap: () => print("tap"),
              ),
              SizedBox(width: 20),
              InfoText(
                text: "2 users here",
                icon: CupertinoIcons.profile_circled,
                onTap: () => print("tap"),
              ),
              SizedBox(width: 20),
              InfoText(
                text: "toggle terminal (cmd + j)",
                icon: CupertinoIcons.square,
                onTap: () => Provider.of<AppState>(context, listen: false).toggleTerminal(),
              ),
              SizedBox(width: 20),
              InfoText(
                text: "toggle sidebar (cmd + b)",
                icon: CupertinoIcons.sidebar_left,
                onTap: () => Provider.of<AppState>(context, listen: false).toggleSidebar(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
