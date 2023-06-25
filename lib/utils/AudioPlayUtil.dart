import 'package:audioplayers/audioplayers.dart';

class AudioPlayUtil{
  late AudioPlayer audioPlayer;
  static final AudioPlayUtil _instance = AudioPlayUtil.internal();
  factory AudioPlayUtil(){
    return _instance;
  }

  AudioPlayUtil.internal(){
    audioPlayer = AudioPlayer();
  }

  Future play(String path) async{
     await audioPlayer.play(AssetSource(path));
  }

}