import 'package:flutter/material.dart';

class TimerDisplay extends StatefulWidget {
  final int seconds;

  const TimerDisplay({super.key, required this.seconds});

  @override
  State<TimerDisplay> createState() => _TimerDisplayState();
}

class _TimerDisplayState extends State<TimerDisplay> {
  @override
  Widget build(BuildContext context) {
    String minutes = (widget.seconds ~/ 60).toString().padLeft(2, '0');
    String seconds = (widget.seconds % 60).toString().padLeft(2, '0');

    return Text(
      '$minutes:$seconds',
      style: const TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.bold,
        color: Color(0xFF4682B4),
      ),
    );
  }
}