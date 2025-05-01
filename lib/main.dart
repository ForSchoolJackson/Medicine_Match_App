import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//flame imports
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
/// get a high score.
///
/// @author: Jackson Heim
/// @version: 1.0.0
/// @since: 2025-04-20
///
///
/// -need to draw wayyyy more cards
///
///
/// notes:
/// used info from these sights
/// https://flame-engine.org/
/// https://pub.dev/
///
///
/// used chatgpt to help with coding
/// https://chatgpt.com/
///
///
/// assets
///
///
///

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

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int currentIndex = 0;

  final tabs = const [
    GameTab(),
    HighscoreTab(),
    SettingsTab(),
    HelpTab(),
  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<GameProvider>(context, listen: false);
      provider.refreshHighScores();
    });
  }

  @override
  Widget build(BuildContext context) {
    late GameProvider gameProvider =
        Provider.of<GameProvider>(context, listen: false);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        //body: tabs[currentIndex],
        body: IndexedStack(
          index: currentIndex,
          children: tabs,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
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
              //refreh scores when going to score page

              currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: const [
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
