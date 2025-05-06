import 'package:flutter/material.dart';

class ControlButtons extends StatelessWidget {
  final VoidCallback onStart;
  final VoidCallback onPause;
  final VoidCallback onStop;
  final bool isPaused;

  const ControlButtons({
    super.key,
    required this.onStart,
    required this.onPause,
    required this.onStop,
    required this.isPaused,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildButton('Start', const Color(0xFF8B4513), onStart),
        const SizedBox(width: 20),
        _buildButton(
          isPaused ? 'Resume' : 'Pause',
          Colors.grey,
          onPause,
        ),
        const SizedBox(width: 20),
        _buildButton('Stop', const Color(0xFF8B4513), onStop),
      ],
    );
  }

  Widget _buildButton(String text, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, color: Colors.white70),
      ),
    );
  }
}