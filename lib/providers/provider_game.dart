import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameProvider extends ChangeNotifier {
  FlameGame? _theGame;
  double _musicVolume = 1.0;
  double _sfxVolume = 1.0;
  int _score = 0;
  int _lastScore = 0;
  bool inGame = false;
  List<int> highScores = [];

  //getter
  FlameGame? get game => _theGame;
  double get musicVolume => _musicVolume;
  double get sfxVolume => _sfxVolume;
  int get score => _score;
  int get lastScore => _lastScore;
  List<int> get topHighScores => highScores;  // Expose high scores

  //setter
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

  //add score
  void addScore(int value) {
    _score += value;
    print("Updated Score: $_score");
    notifyListeners();
  }

  //reset score
  void resetScore() {
    _score = 0;
    notifyListeners();
  }

  // Load high scores from SharedPreferences
  Future<void> loadHighScores() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedScores = prefs.getStringList('highScores');
    if (savedScores != null) {
      highScores = savedScores.map((score) => int.parse(score)).toList();
    } else {
      highScores = [];
    }
    highScores.sort((a, b) => b.compareTo(a));  // Sort high scores in descending order
    notifyListeners();
  }

  // Save high scores to SharedPreferences
  Future<void> saveHighScores() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
        'highScores', highScores.map((score) => score.toString()).toList());
  }

  // Add a new score and update high scores
  void addHighScore(int newScore) {
    highScores.add(newScore);
    highScores.sort((a, b) => b.compareTo(a));  // Sort in descending order
    if (highScores.length > 10) {  // Keep only top 10 scores
      highScores = highScores.sublist(0, 10);
    }
    saveHighScores();  // Save the updated list to SharedPreferences
    notifyListeners();
  }

  // Refresh the high scores from SharedPreferences
  Future<void> refreshHighScores() async {
    await loadHighScores();
    notifyListeners();
  }

  // dispose audio
  void dispose() {
    musicPlayer.dispose();
    sfxPlayer.dispose();
    super.dispose();
  }
}
