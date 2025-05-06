import 'package:flutter/material.dart';
import 'package:zenmind_timer/widgets/control_buttons.dart';
import 'package:zenmind_timer/widgets/sound_picker.dart';
import 'package:zenmind_timer/widgets/timer_display.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  int _seconds = 0;
  bool _isRunning = false;
  bool _isPaused = false;
  final TextEditingController _controller = TextEditingController();
  String _selectedSound = 'Calm';
  final AudioPlayer _audioPlayer = AudioPlayer();
  Timer? _timer;

  void _startTimer() {
    if (!_isRunning || _isPaused) {
      setState(() {
        _isRunning = true;
        _isPaused = false;
        if (!_isPaused) {
          _seconds = (int.tryParse(_controller.text) ?? 0);
        }
      });
      _runTimer();
    }
  }

  void _togglePause() {
    if (_isRunning) {
      setState(() {
        _isPaused = !_isPaused;
        if (_isPaused) {
          _timer?.cancel();
        } else {
          _runTimer();
        }
      });
    }
  }

  Future<void> _stopTimer() async {
    setState(() {
      _isRunning = false;
      _isPaused = false;
      _seconds = 0;
      _timer?.cancel();
      _controller.clear();
    });
    await _audioPlayer.stop();
  }


  void _runTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isRunning && !_isPaused && _seconds > 0) {
        setState(() => _seconds--);
      } else if (_seconds == 0 && _isRunning) {
        _isRunning = false;
        _timer?.cancel();
        _playSelectedSound();
      }
    });
  }

  Future<void> _playSelectedSound() async {
    try {
      String soundPath;
      switch (_selectedSound) {
        case 'Calm':
          soundPath = 'calm.mp3';
          break;
        case 'Calm Down':
          soundPath = 'calm_down.mp3';
          break;
        case 'You And Me':
          soundPath = 'you_and_me.mp3';
          break;
        default:
          soundPath = 'calm.mp3';
      }

      await _audioPlayer.stop();
      await _audioPlayer.play(AssetSource(soundPath));
    } catch (e) {
      debugPrint('Error playing sound: $e');
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _audioPlayer.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6E8FA),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'ZenMind',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4682B4),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Enter Time (in Seconds)',
                  labelStyle: TextStyle(color: Color(0xFF4682B4)),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TimerDisplay(seconds: _seconds),
            const SizedBox(height: 30),
            ControlButtons(
              onStart: _startTimer,
              onPause: _togglePause,
              onStop: _stopTimer,
              isPaused: _isPaused,
            ),
            const SizedBox(height: 30),
            SoundPicker(
              onSoundChanged: (sound) {
                setState(() => _selectedSound = sound);
              },
            ),
          ],
        ),
      ),
    );
  }
}
