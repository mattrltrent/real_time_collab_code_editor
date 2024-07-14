import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uvec/config/typography.dart';
import 'package:uvec/effects/touchable_opacity.dart';
import 'package:uvec/state/state.dart';

class TerminalTabText extends StatelessWidget {
  const TerminalTabText({super.key, required this.text, required this.onTap, required this.idx});

  final String text;
  final Function(int) onTap;
  final int idx;

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: () => onTap(idx),
      child: Text(
        text,
        style: Provider.of<AppState>(context).terminalTabSelected == idx
            ? bodyFont.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              )
            : bodyFont.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
      ),
    );
  }
}
