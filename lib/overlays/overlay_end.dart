//Score: ${gameProvider.score}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/provider_game.dart';
import '../theme.dart';

Widget endGameOverlay(BuildContext context, dynamic game) {
  final gameProvider = Provider.of<GameProvider>(context, listen: false);
  final int finalScore = gameProvider.score;

  //massage based on score
  String endMessage;
  if (finalScore >= 100) {
    endMessage = "You caught them all!";
  } else if (finalScore >= 50) {
    endMessage = "All ingredients have been collected.";
  } else if (finalScore >= 0) {
    endMessage = "Took you a while.";
  } else {
    endMessage = "You have a TERRIBLE memory.";
  }

  return Center(
    child: Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        color: const Color.fromARGB(235, 21, 3, 49),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            endMessage,
            style: GameTextStyles.title,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            "Score: ${gameProvider.score}",
            style: GameTextStyles.bar,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              final gameProvider =
                  Provider.of<GameProvider>(context, listen: false);

              game.pauseEngine();
              game.overlays.remove("endgame");
              game.overlays.remove("game");
              game.overlays.add("start");

              game.removeAll(game.children.toList());
              game.cards.clear();
              game.flippedCards.clear();
              game.canFlip = true;

              gameProvider.resetScore();
              gameProvider.game = null;
            },
            child: const Text("Restart"),
          ),
        ],
      ),
    ),
  );
}
