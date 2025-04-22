import 'package:flame/components.dart';
import 'package:flame/events.dart';

class CardComponent extends SpriteComponent with TapCallbacks {
  final String frontImagePath;
  final String backImagePath;
  final void Function(CardComponent) onFlipped;

  bool isFlipped = false;
  bool isMatched = false;

  late Sprite frontSprite;
  late Sprite backSprite;

  CardComponent({
    required this.frontImagePath,
    required this.backImagePath,
    required this.onFlipped,
    Vector2? position,
    Vector2? size,
  }) : super(position: position, size: size);

  @override
  Future<void> onLoad() async {
    frontSprite = await Sprite.load(frontImagePath);
    backSprite = await Sprite.load(backImagePath);

    // ✅ Show front sprite right away
    isFlipped = true;
    sprite = frontSprite;
  }

//front
  void showFront() {
    sprite = frontSprite;
    isFlipped = true; 
  }

//back
  void flipToBack() {
    isFlipped = false;
    sprite = backSprite;
    print('Flipping to BACK manually');
  }

//for matching
  void flip() {
    if (isMatched) return;
    isFlipped = !isFlipped;
    sprite = isFlipped ? frontSprite : backSprite;
    print('Card flipped to ${isFlipped ? "FRONT" : "BACK"}');
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (!isFlipped && !isMatched) {
      flip();
      onFlipped(this);
    }
  }
}
