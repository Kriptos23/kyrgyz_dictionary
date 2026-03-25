import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../services/database_audio.dart';


class AudioButton extends StatefulWidget {
  final String audioFile;
  final AudioService audioService;

  const AudioButton({
    super.key,
    required this.audioFile,
    required this.audioService,
  });

  @override
  State<AudioButton> createState() => _AudioButtonState();
}

class _AudioButtonState extends State<AudioButton> {
  bool isLoading = false;

  Future<void> playAudio() async {
    setState(() => isLoading = true);

    try {
      await widget.audioService.playWord(widget.audioFile);
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: isLoading ? null : playAudio,
      icon: isLoading
          ? const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(strokeWidth: 2),
      )
          : const Icon(Icons.volume_down_outlined),
    );
  }
}
