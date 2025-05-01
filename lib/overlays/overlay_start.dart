import 'package:flutter/material.dart';

import '../theme.dart';

class StartOverlay extends StatelessWidget {
  final dynamic game;
  const StartOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    // Get screen size to determine space available
    final screenHeight = MediaQuery.of(context).size.height;

    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 21, 3, 49),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            // Title Text
            const Text(
              "OH NO!",
              style: GameTextStyles.title,
              textAlign: TextAlign.center,
            ),

            // Image with dynamic height based on screen size
            Image.asset(
              'assets/images/toadyGuy.png',
              height: screenHeight * 0.25, // Adjust image size based on screen height
            ),

            // Body Text
            const SizedBox(height: 10),
            const Text(
              "\t There has been an incident in the lab! All of the ingredients have gained sentience and are escaping!",
              style: GameTextStyles.body,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            const Text(
              "\t You have a few seconds to memorize the cards before they flip over. After that, you need to match the pairs by tapping on two at a time. Hurry up and catch them!",
              style: GameTextStyles.body,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 30),

            // Adjust button size based on available space
            ElevatedButton(
              onPressed: () async {
                game.paused = false;
                game.overlays.remove('start');
                game.overlays.add('game');
                await game.startGame();
              },
              child: const Text("Start Game"),
            ),
          ],
        ),
      ),
    );
  }
}
