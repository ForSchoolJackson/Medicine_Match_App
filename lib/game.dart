import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//flame imports
import 'package:flame/game.dart';
import 'package:flame/events.dart';

//lib imports
import 'componants/card.dart';
import 'providers/provider_game.dart';

class MedicineMatchGame extends FlameGame {
  final BuildContext context;
  late final gameProvider;

  MedicineMatchGame(this.context);

  @override
  Color backgroundColor() => const Color(0x00000000);

  final List<String> cardImages = [
    'toadstool.png',
    'sunflower.png',
  ];

  bool canFlip = true;

  final List<CardComponent> cards = [];
  final List<CardComponent> flippedCards = [];

  Future<void> startGame() async {
    gameProvider = Provider.of<GameProvider>(context, listen: false);
    //gameProvider.playBgm("audio/retro_bgm.wav");

    //screen size
    final screenWidth = size.x;
    final screenHeight = size.y;

    final cardSize = Vector2(110, 110);
    const spacing = 10.0;

    // Add some padding
    const horizontalPadding = 20.0;
    const verticalPadding = 20.0;

    //fit cards on screen
    final cardsPerRow =
        ((screenWidth - 2 * horizontalPadding) ~/ (cardSize.x + spacing))
            .toInt();
    final cardsPerColumn =
        ((screenHeight - 2 * verticalPadding) ~/ (cardSize.y + spacing))
            .toInt();

    //make sure there are always pairs
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

    // Load all the cards
    for (int i = 0; i < allCardImages.length; i++) {
      final row = i ~/ cardsPerRow; //row number
      final col = i % cardsPerRow; //column number

      final x = startX + col * (cardSize.x + spacing);
      final y = startY + row * (cardSize.y + spacing);

      final card = CardComponent(
        frontImagePath: allCardImages[i],
        backImagePath: 'back.png',
        position: Vector2(x, y),
        size: cardSize,
        onFlipped: handleCardFlip,
        canFlipCallback: () => canFlip,
      );

      cards.add(card);
      add(card);

      await card.loaded;
    }

    await Future.delayed(const Duration(milliseconds: 10));

    for (var card in cards) {
      card.showFront();
    }

    await Future.delayed(const Duration(seconds: 5));

    for (var card in cards) {
      card.flipToBack();
    }
  }

  void handleCardFlip(CardComponent card) async {
    if (!canFlip || flippedCards.contains(card) || !card.isFlipped) return;

    //play flip sound
    gameProvider.playSfx("audio/flip.ogg");

    flippedCards.add(card);

    if (flippedCards.length == 2) {
      canFlip = false;

      await Future.delayed(const Duration(milliseconds: 500));

      final first = flippedCards[0];
      final second = flippedCards[1];

      if (first.frontImagePath == second.frontImagePath) {
        first.isMatched = true;
        second.isMatched = true;

        //play correct
        gameProvider.playSfx("audio/correct.wav");

        //add score
        gameProvider.addScore(10);
      } else {
        first.flip();
        second.flip();

        //play wrong sound
        gameProvider.playSfx("audio/wrong.wav");
        //lose score
        gameProvider.addScore(-5);
      }

      flippedCards.clear();

      // ✅ small lockout before next flip
      await Future.delayed(const Duration(milliseconds: 300));
      canFlip = true;
    }
  }
}
