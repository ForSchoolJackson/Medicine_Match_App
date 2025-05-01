import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//lib
import '../providers/provider_game.dart';
import '../theme.dart';

//overlay for pause screen
Widget pauseOverlay(context, game) {

  //style
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
          const Text(
            "Paused",
            style: GameTextStyles.title,
          ),
          const SizedBox(
            height: 20,
          ),
          //resume
          ElevatedButton(
            onPressed: () {
              game.paused = false;
              game.overlays.remove("pause");
            },
            child: const Text("Resume"),
          ),
          //quit
          ElevatedButton(
            onPressed: () {
              //game provider
              late GameProvider gameProvider =
                  Provider.of<GameProvider>(context, listen: false);

              //remove overlays
              game.pauseEngine();
              game.overlays.remove("pause");
              game.overlays.remove("game");
              game.overlays.add("start");

              //remove all game componants
              game.removeAll(game.children.toList());

              //clear game
              game.flippedCards.clear();
              game.cards.clear();
              game.canFlip = true;

              //provider reset
              gameProvider.resetScore();
              gameProvider.game = null;
            },
            child: const Text("Quit"),
          ),
        ],
      ),
    ),
  );
}
