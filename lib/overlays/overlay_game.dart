import 'package:flutter/material.dart';

//lib
import '../theme.dart';

//overlay for top of game
Widget gameOverlay(context, game) {

  //style
  return Align(
    alignment: Alignment.topCenter,
    child: Container(
      color: const Color.fromARGB(105, 21, 3, 49),
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.all(20),
      child: Row(
        children: [
          const Expanded(
            //title
            child: Text(
              "\t Medicine Match",
              style: GameTextStyles.bar,
            ),
          ),
          //pause button
          IconButton(
            onPressed: () {
              game.paused = true;
              game.overlays.add("pause");
            },
            icon: const Icon(
              Icons.pause,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}
