import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';

//flame imports
import 'package:flame/game.dart';

//lib imports
import 'componants/card.dart';

class MedicineMatchGame extends FlameGame {
  final BuildContext context;
  MedicineMatchGame(this.context);

  @override
  Color backgroundColor() => const Color(0x00000000);

  final List<String> cardImages = [
    'toadstool.png',
    'sunflower.png',
  ];

  final List<CardComponent> cards = [];
  final List<CardComponent> flippedCards = [];

  Future<void> startGame() async {
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
    if (card.isFlipped &&
        !flippedCards.contains(card) &&
        flippedCards.length < 2) {
      flippedCards.add(card);

      if (flippedCards.length == 2) {
        await Future.delayed(const Duration(milliseconds: 500));

        final first = flippedCards[0];
        final second = flippedCards[1];

        if (first.frontImagePath == second.frontImagePath) {
          first.isMatched = true;
          second.isMatched = true;
        } else {
          first.flip();
          second.flip();
        }

        flippedCards.clear();
      }
    }
  }
}
