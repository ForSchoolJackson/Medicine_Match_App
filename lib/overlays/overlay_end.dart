import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//lib
import '../providers/provider_game.dart';
import '../theme.dart';

//overlay for end screen
Widget endGameOverlay(BuildContext context, dynamic game) {
  final gameProvider = Provider.of<GameProvider>(context, listen: false);
  final int finalScore = gameProvider.score;

  // message based on score
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

  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;

  //style
  return Center(
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: screenWidth * 0.8,
        constraints: BoxConstraints(
          maxWidth: 350,
          maxHeight: screenHeight * 0.9,
        ),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color.fromARGB(235, 21, 3, 49),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //message
            Text(
              endMessage,
              style: GameTextStyles.title,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            //score
            Text(
              "Score: ${gameProvider.score}",
              style: GameTextStyles.bar,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            //button
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
    ),
  );
}
