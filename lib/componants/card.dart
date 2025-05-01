import 'package:flame/components.dart';
import 'package:flame/events.dart';

//handles card componants
class CardComponent extends SpriteComponent with TapCallbacks {
  final String frontImagePath;
  final String backImagePath;

  final void Function(CardComponent) onFlipped;

  final bool Function() canFlipCallback;

  bool isFlipped = false;
  bool isMatched = false;

  late Sprite frontSprite;
  late Sprite backSprite;

  //constructor
  CardComponent({
    required this.frontImagePath,
    required this.backImagePath,
    required this.onFlipped,
    required this.canFlipCallback,
    Vector2? position,
    Vector2? size,
  }) : super(position: position, size: size);

  //on load
  @override
  Future<void> onLoad() async {
    frontSprite = await Sprite.load(frontImagePath);
    backSprite = await Sprite.load(backImagePath);

    //show front sprite first
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
  }

//for matching
  void flip() {
    if (isMatched) return;
    isFlipped = !isFlipped;
    sprite = isFlipped ? frontSprite : backSprite;
  }

  //when tapped
  @override
  void onTapDown(TapDownEvent event) {
    if (!isFlipped && !isMatched && canFlipCallback()) {
      flip();
      onFlipped(this);
    }
  }
}
