import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import '../game.dart';
import '../overlays/overlay_end.dart';
import '../overlays/overlay_start.dart';
import '../overlays/overlay_pause.dart';
import '../overlays/overlay_game.dart';
import 'package:provider/provider.dart';
import '../providers/provider_game.dart';

class GameTab extends StatelessWidget {
  const GameTab({super.key});

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context, listen: false);

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1E1E2C), Color(0xFF2E2B5F), Color(0xFF6A62C2)],
        ),
      ),
      child: GameWidget.controlled(
        gameFactory: () {
          final game = MedicineMatchGame(context);
          game.paused = true;
          gameProvider.game = game;
          return game;
        },
        overlayBuilderMap: {
          'start': (_, game) => StartOverlay(game: game),
          'game': (_, game) => gameOverlay(context, game),
          'pause': (_, game) => pauseOverlay(context, game),
          'endgame': (_, game) => endGameOverlay(context, game),
        },
        initialActiveOverlays: const ['start'],
      ),
    );
  }
}
