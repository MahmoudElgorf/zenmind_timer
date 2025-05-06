import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class SoundPicker extends StatefulWidget {
  final ValueChanged<String> onSoundChanged;

  const SoundPicker({
    required this.onSoundChanged,
    super.key,
  });

  @override
  _SoundPickerState createState() => _SoundPickerState();
}

class _SoundPickerState extends State<SoundPicker> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _selectedSound;

  @override
  void initState() {
    super.initState();
    _audioPlayer.setVolume(1.0);
  }

  Future<void> playSelectedSound() async {
    if (_selectedSound == null) return;

    try {
      String soundPath;
      switch (_selectedSound) {
        case 'Calm':
          soundPath = 'assets/calm.mp3';
          break;
        case 'Calm Down':
          soundPath = 'assets/calm_down.mp3';
          break;
        case 'You And Me':
          soundPath = 'assets/you_and_me.mp3';
          break;
        default:
          return;
      }

      await _audioPlayer.stop();
      await _audioPlayer.play(AssetSource(soundPath));
      debugPrint('Playing sound: $soundPath');
    } catch (e) {
      debugPrint('Error playing sound: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error playing sound: ${e.toString()}')),
        );
      }
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _selectedSound,
      hint: const Text('Select Sound'),
      onChanged: (selectedSound) {
        if (selectedSound != null) {
          setState(() => _selectedSound = selectedSound);
          widget.onSoundChanged(selectedSound);
        }
      },
      items: const [
        DropdownMenuItem(value: 'Calm', child: Text('Calm')),
        DropdownMenuItem(value: 'Calm Down', child: Text('Calm Down')),
        DropdownMenuItem(value: 'You And Me', child: Text('You And Me')),
      ],
    );
  }
}