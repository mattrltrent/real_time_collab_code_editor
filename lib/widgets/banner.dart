import 'package:flutter/material.dart';
import 'package:uvec/config/typography.dart';

class MyBanner extends StatelessWidget {
  const MyBanner({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.error,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Text(
        text,
        style: miniFont.copyWith(
          color: Theme.of(context).colorScheme.onError,
        ),
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
