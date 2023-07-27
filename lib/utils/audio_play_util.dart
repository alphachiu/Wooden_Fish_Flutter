import 'package:audioplayers/audioplayers.dart';

class AudioPlayUtil {
  late AudioPlayer audioPlayer;
  static final AudioPlayUtil _instance = AudioPlayUtil.internal();
  factory AudioPlayUtil() {
    return _instance;
  }

  AudioPlayUtil.internal() {
    audioPlayer = AudioPlayer();
  }

  Future play(String path) async {
    await audioPlayer.setSource(AssetSource(path));
    await audioPlayer.setVolume(1.0);
    await audioPlayer.resume();
  }

  Future stop() async {
    await audioPlayer.stop();
  }
}
