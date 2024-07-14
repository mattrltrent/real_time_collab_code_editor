import 'package:flutter/material.dart';
import 'package:uvec/config/typography.dart';
import 'package:uvec/effects/touchable_opacity.dart';

class InfoText extends StatelessWidget {
  const InfoText({super.key, required this.text, required this.icon});

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: () {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
            size: 14,
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: miniFont.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
