import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../providers/provider_game.dart';
import '../theme.dart';

Widget gameOverlay(context, game) {
  final gameProvider = Provider.of<GameProvider>(context, listen: true);

  return Align(
    alignment: Alignment.topCenter,
    child: Container(
      color: const Color.fromARGB(105, 21, 3, 49),
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "Score: ${gameProvider.score}",
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
