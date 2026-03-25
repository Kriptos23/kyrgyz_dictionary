import 'package:firebase_storage/firebase_storage.dart';
import 'package:just_audio/just_audio.dart';

class AudioService {
  final AudioPlayer player = AudioPlayer();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> playWord(String word) async {
    try {
      // Get the download URL from Firebase Storage
      final ref = _storage.ref().child('audios/words/$word');
      final url = await ref.getDownloadURL();

      await player.setUrl(url);
      player.play();
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  void stop() {
    player.stop();
  }
}
