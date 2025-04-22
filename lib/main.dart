import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//flame imports
import 'package:flame/flame.dart';
import 'package:flame/game.dart';

//lib imports
import 'game.dart';
import 'overlays/overlay_start.dart';
import 'overlays/overlay_pause.dart';
import 'overlays/overlay_game.dart';
import 'providers/provider_game.dart';


///
/// Project 3: Medicine Match
///
/// The last flutter project.
///
/// @author: Jackson Heim
/// @version: 1.0.0
/// @since: 2025-04-20
///
/// issues:
/// -the cards WILL NOT start on the front side
/// for the player to memorize.
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

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final game = MedicineMatchGame(context); 
    Provider.of<GameProvider>(context, listen: false).game = game;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF1E1E2C),
                Color(0xFF2E2B5F),
                Color(0xFF6A62C2),
              ],
            ),
          ),
          child: GameWidget(
            game: MedicineMatchGame(context)..paused = true,
            overlayBuilderMap: {
              'start': (_, game) => StartOverlay(game: game),
              'game': (_, game) => gameOverlay(context, game),
              'pause': (_, game) => pauseOverlay(context, game),
            },
            initialActiveOverlays: const ['start'],
          ),
        ),
      ),
    );
  }
}
