import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

//game provider
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
  List<int> get topHighScores => highScores;

  //setter
  set game(FlameGame? value) {
    _theGame = value;
  }

  //audio players
  AudioPlayer musicPlayer = AudioPlayer();
  AudioPlayer sfxPlayer = AudioPlayer();
  final audioContext =
      AudioContextConfig(focus: AudioContextConfigFocus.mixWithOthers).build();
  //play bgm
  void playBgm(String url) async {
    musicPlayer.setAudioContext(audioContext); // allow mixing sounds
    musicPlayer.setReleaseMode(ReleaseMode.loop);
    await musicPlayer.play(AssetSource(url));
  }

  //play sfx
  void playSfx(String url) async {
    await sfxPlayer.play(AssetSource(url));
  }

  //music
  set musicVolume(double value) {
    _musicVolume = value;
    musicPlayer.setVolume(_musicVolume);
    //save setting
    SharedPreferences.getInstance().then((prefs) {
      prefs.setDouble('musicVolume', _musicVolume);
    });
    notifyListeners();
  }

  //sound effects
  set sfxVolume(double value) {
    _sfxVolume = value;
    sfxPlayer.setVolume(_sfxVolume);
    //save setting
    SharedPreferences.getInstance().then((prefs) {
      prefs.setDouble('sfxVolume', _sfxVolume);
    });
    notifyListeners();
  }

  //load volume pref
  Future<void> loadVolumes() async {
    final prefs = await SharedPreferences.getInstance();
    _musicVolume = prefs.getDouble('musicVolume') ?? 1.0;
    _sfxVolume = prefs.getDouble('sfxVolume') ?? 1.0;

    // apply loaded volumes
    musicPlayer.setVolume(_musicVolume);
    sfxPlayer.setVolume(_sfxVolume);

    notifyListeners();
  }

  //score
  set lastScore(int value) {
    _lastScore = value;
    notifyListeners();
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

  //load scores
  Future<void> loadHighScores() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedScores = prefs.getStringList('highScores');
    if (savedScores != null) {
      highScores = savedScores.map((score) => int.parse(score)).toList();
    } else {
      highScores = [];
    }
    //sort scores
    highScores.sort((a, b) => b.compareTo(a));
    notifyListeners();
  }

  //save scores
  Future<void> saveHighScores() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //shared preferences
    prefs.setStringList(
        'highScores', highScores.map((score) => score.toString()).toList());
  }

  //add new score
  void addHighScore(int newScore) {
    highScores.add(newScore);
    //sort
    highScores.sort((a, b) => b.compareTo(a));
    //keep ten
    if (highScores.length > 10) {
      highScores = highScores.sublist(0, 10);
    }
    //save
    saveHighScores();
    notifyListeners();
  }

  //refresh score
  Future<void> refreshHighScores() async {
    await loadHighScores();
    notifyListeners();
  }

  //disposeaudio player
  @override
  void dispose() {
    musicPlayer.dispose();
    sfxPlayer.dispose();
    super.dispose();
  }
}
