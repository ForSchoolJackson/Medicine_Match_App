import 'package:flutter/material.dart';

import '../componants/theme.dart';

Widget GameOverlay(context, game) {
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
            child: Text(
              "Medicine Match",
              style: GameTextStyles.bar,
            ),
          ),
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
