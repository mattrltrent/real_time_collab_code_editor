import 'package:flutter/material.dart';

class BottomIndicators extends StatefulWidget {
  const BottomIndicators({super.key});

  @override
  State<BottomIndicators> createState() => _BottomIndicatorsState();
}

class _BottomIndicatorsState extends State<BottomIndicators> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [Text("test")],
    );
  }
}
