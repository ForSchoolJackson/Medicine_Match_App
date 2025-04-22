import 'package:flutter/material.dart';

import '../theme.dart';

class StartOverlay extends StatelessWidget {
  final dynamic game;
  const StartOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 350,
        height: 710,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 21, 3, 49),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "OH NO!",
                style: GameTextStyles.title,
                textAlign: TextAlign.center,
              ),

              //image
              Image.asset(
                'assets/images/toadyGuy.png',
                height: 200,
              ),

              //body text
              const Text(
                "There has been an incident in the lab! All of the ingredients have gained sentience and are escaping!",
                style: GameTextStyles.body,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),

              //body text
              const Text(
                "You have a few seconds to memorize the cards before they flip over. After that, you need to match the pairs by tapping on two at a time. Hurry up and catch them! ",
                style: GameTextStyles.body,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // Start Game Button
              ElevatedButton(
                onPressed: () {
                  game.paused = false;
                  game.overlays.remove('start');
                  game.overlays.add('game');
                  game.startGame(); //start game
                },
                child: const Text("Start Game"),
              ),
              // You can add a Settings button if needed
              // ElevatedButton(
              //   onPressed: () {
              //     game.overlays.add("settings");
              //   },
              //   child: const Text("Settings"),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
