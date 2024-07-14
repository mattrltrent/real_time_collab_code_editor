import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      color: Theme.of(context).colorScheme.background,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: const Align(
        alignment: Alignment.bottomLeft,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            // align horizontally left
            children: [
              InfoText(text: "main", icon: CupertinoIcons.arrow_branch),
              SizedBox(width: 20),
              InfoText(text: "sync", icon: CupertinoIcons.upload_circle),
              SizedBox(width: 20),
              InfoText(text: "live share", icon: CupertinoIcons.arrowshape_turn_up_right),
            ],
          ),
        ),
      ),
    );
  }
}
