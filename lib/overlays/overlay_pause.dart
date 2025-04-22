import 'package:flutter/material.dart';

import '../theme.dart';

Widget pauseOverlay(context, game) {
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
          ElevatedButton(
            onPressed: () {
              game.paused = false;
              game.overlays.remove("pause");
            },
            child: const Text("Resume"),
          ),
          // ElevatedButton(
          //   onPressed: () {},
          //   child: const Text("Settings"),
          // ),
          ElevatedButton(
            onPressed: () {},
            child: const Text("Quit"),
          ),
        ],
      ),
    ),
  );
}
