import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flame/flame.dart';

//lib imports
import 'providers/provider_game.dart';
import 'tabs/game_tab.dart';
import 'tabs/highscore_tab.dart';
import 'tabs/settings_tab.dart';
import 'tabs/help_tab.dart';

///
/// Project 3: Medicine Match
///
/// The last flutter project. I made a card matching game uing the
/// flame engine in flutter. Users will match cards to gain points to
/// get a high score. They can play the game, view scores on the score
/// page, chnage the volume settings on the settings page, and
/// visit the help page for help with playing the game.
///
/// @author: Jackson Heim
/// @version: 2.0.0
/// @since: 2025-05-01
///
/// -need to draw wayyyy more cards
///
/// notes:
/// used info from these sights
/// https://flame-engine.org/
/// https://pub.dev/
///
/// used chatgpt to help with coding
/// https://chatgpt.com/
///
/// errors:
/// -the sound does not play very clearly at all times or has a delay
/// -problem with exiting app and going back in
///
/// assets
/// https://pixabay.com/music/funk-groovy-ambient-funk-201745/
///
///

//main
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();

  // runApp(const MainApp());
  runApp(
    ChangeNotifierProvider(
      create: (_) => GameProvider(),
      child: const MainApp(),
    ),
  );
}

//main app widget
class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

//main app state
class _MainAppState extends State<MainApp> {
  //current tab
  int currentIndex = 0;

  //tabs
  final tabs = const [
    GameTab(),
    HighscoreTab(),
    SettingsTab(),
    HelpTab(),
  ];

  //init
  @override
  void initState() {
    super.initState();

    //provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<GameProvider>(context, listen: false);
      //refresh scores
      provider.refreshHighScores();

      //load volume settings
      provider.loadVolumes();

      //start music
      provider.playBgm('audio/groovy-funk.mp3');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: tabs,
        ),
        //navbar
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            final gameProvider =
                Provider.of<GameProvider>(context, listen: false);
            final game = gameProvider.game;

            setState(() {
              //Pause if not game tab
              if (currentIndex == 0 &&
                  index != 0 &&
                  game != null &&
                  !game.paused) {
                game.paused = true;
                game.overlays.add('pause');
              }
              currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: const [
            //items
            BottomNavigationBarItem(
                icon: Icon(Icons.videogame_asset), label: 'Game'),
            BottomNavigationBarItem(
                icon: Icon(Icons.star), label: 'High Scores'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings'),
            BottomNavigationBarItem(
                icon: Icon(Icons.help_outline), label: 'Help'),
          ],
        ),
      ),
    );
  }
}
