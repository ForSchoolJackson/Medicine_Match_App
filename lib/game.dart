import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flame/game.dart';

//lib imports
import 'componants/card.dart';
import 'providers/provider_game.dart';

//the game
class MedicineMatchGame extends FlameGame {
  final BuildContext context;
  late GameProvider gameProvider;

  MedicineMatchGame(this.context);

  //clear
  @override
  Color backgroundColor() => const Color(0x00000000);

  //card images
  final List<String> cardImages = [
    'toadstool.png',
    'sunflower.png',
  ];

  bool canFlip = true;

  //lists
  final List<CardComponent> cards = [];
  final List<CardComponent> flippedCards = [];

  //start
  Future<void> startGame() async {
    gameProvider = Provider.of<GameProvider>(context, listen: false);

    //screen size
    final screenWidth = size.x;
    final screenHeight = size.y;

    final cardSize = Vector2(110, 110);
    const spacing = 10.0;

    //padding
    const horizontalPadding = 20.0;
    const verticalPadding = 20.0;

    //fit cards on screen
    final cardsPerRow =
        ((screenWidth - 2 * horizontalPadding) ~/ (cardSize.x + spacing))
            .toInt();
    final cardsPerColumn =
        ((screenHeight - 2 * verticalPadding) ~/ (cardSize.y + spacing))
            .toInt();

    //always pairs
    final totalCardsThatFit = cardsPerRow * cardsPerColumn;
    final numberOfPairs = (totalCardsThatFit ~/ 2);
    final totalCards = numberOfPairs * 2;
    final rows = (totalCards / cardsPerRow).ceil();

    //find the total length
    final totalCardsWidth =
        cardsPerRow * cardSize.x + (cardsPerRow - 1) * spacing;
    final totalCardsHeight = rows * cardSize.y + (rows - 1) * spacing;

    //find starting position
    final startX = (screenWidth - totalCardsWidth) / 2;
    final startY = (screenHeight - totalCardsHeight) / 2;

    //fill list
    List<String> allCardImages = [];
    final random = Random();
    for (int i = 0; i < numberOfPairs; i++) {
      final image = cardImages[random.nextInt(cardImages.length)];
      allCardImages.add(image);
      allCardImages.add(image);
    }

    allCardImages.shuffle();

    //load
    for (int i = 0; i < allCardImages.length; i++) {
      final row = i ~/ cardsPerRow; //row
      final col = i % cardsPerRow; //column

      final x = startX + col * (cardSize.x + spacing);
      final y = startY + row * (cardSize.y + spacing);

      //componant
      final card = CardComponent(
        frontImagePath: allCardImages[i],
        backImagePath: 'back.png',
        position: Vector2(x, y),
        size: cardSize,
        onFlipped: handleCardFlip,
        canFlipCallback: () => canFlip,
      );

      //add cards
      cards.add(card);
      add(card);

      await card.loaded;
    }

    await Future.delayed(const Duration(milliseconds: 10));

    //show front first
    for (var card in cards) {
      card.showFront();
    }

    await Future.delayed(const Duration(seconds: 5));

    //than back
    for (var card in cards) {
      card.flipToBack();
    }
  }

  //card flip
  void handleCardFlip(CardComponent card) async {
    if (!canFlip || flippedCards.contains(card) || !card.isFlipped) return;

    //play flip sound
    gameProvider.playSfx("audio/flip.ogg");

    flippedCards.add(card);
    
    //flip two
    if (flippedCards.length == 2) {
      canFlip = false;

      //delay after two flipped
      await Future.delayed(const Duration(milliseconds: 500));
      
      final first = flippedCards[0];
      final second = flippedCards[1];
      
      //check correct
      if (first.frontImagePath == second.frontImagePath) {
        first.isMatched = true;
        second.isMatched = true;

        //play correct
        gameProvider.playSfx("audio/correct.wav");

        //add score
        gameProvider.addScore(10);

        //check end of game
        if (cards.every((card) => card.isMatched)) {
          await Future.delayed(const Duration(milliseconds: 500));
          //add to high scores
          gameProvider.addHighScore(gameProvider.score);
          
          overlays.add("endgame");
          pauseEngine();
        }
      } else {
        //play wrong sound
        gameProvider.playSfx("audio/wrong.wav");
        //lose score
        gameProvider.addScore(-5);

        await Future.delayed(const Duration(seconds: 1));
        first.flip();
        second.flip();
      }

      flippedCards.clear();

      // small lockout before next flip
      await Future.delayed(const Duration(milliseconds: 300));
      canFlip = true;
    }
  }


//  Future<void> saveScore(int score) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String> scores = prefs.getStringList('highScores') ?? [];

//     scores.add(score.toString());

//     //keep ten scores
//     List<int> sorted = scores.map(int.parse).toList()
//       ..sort((b, a) => a.compareTo(b));
//     if (sorted.length > 10) sorted = sorted.sublist(0, 10);

//     prefs.setStringList('highScores', sorted.map((e) => e.toString()).toList());
//   }
}
