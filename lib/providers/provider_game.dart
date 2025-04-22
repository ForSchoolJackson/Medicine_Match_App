import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

// game provider class
class GameProvider extends ChangeNotifier {
  FlameGame? _theGame;
  double _musicVolume = 1.0;
  double _sfxVolume = 1.0;
  int _score = 0;
  int _lastScore = 0;
  bool inGame = false;

  // get
  FlameGame? get game => _theGame;
  double get musicVolume => _musicVolume;
  double get sfxVolume => _sfxVolume;
  int get score => _score;
  int get lastScore => _lastScore;

  // set
  set game(FlameGame? value) {
    _theGame = value;
  }

  //music
  set musicVolume(double value) {
    _musicVolume = value;
    musicPlayer.setVolume(_musicVolume);
    notifyListeners();
  }

  //sound effects
  set sfxVolume(double value) {
    _sfxVolume = value;
    sfxPlayer.setVolume(_sfxVolume);
    notifyListeners();
  }

  //score
  set lastScore(int value) {
    _lastScore = value;
    notifyListeners();
  }

  // audio players
  AudioPlayer musicPlayer = AudioPlayer();
  AudioPlayer sfxPlayer = AudioPlayer();
  final audioContext =
      AudioContextConfig(focus: AudioContextConfigFocus.mixWithOthers).build();

  // play bgm
  void playBgm(String url) async {
    musicPlayer.setAudioContext(audioContext); // allow mixing sounds
    musicPlayer.setReleaseMode(ReleaseMode.loop);
    await musicPlayer.play(AssetSource(url));
  }

  //play sfx
  void playSfx(String url) async {
    await sfxPlayer.play(AssetSource(url));
  }

  // add score
  void addScore(int value) {
    _score += value;
    //notifyListeners();
  }

  // dispose audio
  void dispose() {
    //print("!!!! PROVIDER DISPOSED !!!!!");
    musicPlayer.dispose();
    sfxPlayer.dispose();
    super.dispose();
  }
}
