import 'package:flutter/material.dart';

//lib
import '../theme.dart';

//overlay for start screen
class StartOverlay extends StatelessWidget {
  final dynamic game;
  const StartOverlay({super.key, required this.game});

  //build
  @override
  Widget build(BuildContext context) {
    //get screen size
    final screenHeight = MediaQuery.of(context).size.height;
    
    //style
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
            const Text(
              "OH NO!",
              style: GameTextStyles.title,
              textAlign: TextAlign.center,
            ),

            //image
            Image.asset(
              'assets/images/toadyGuy.png',
              //sized to screen
              height: screenHeight * 0.25,
            ),

            //body
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

            //start button
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
