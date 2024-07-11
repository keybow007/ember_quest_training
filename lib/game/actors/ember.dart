import 'package:ember_quest/game/ember_quest_game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EmberPlayer extends SpriteAnimationComponent
    with HasGameReference<EmberQuestGame>, KeyboardHandler {
  EmberPlayer({required super.position})
      : super(size: Vector2.all(64.0), anchor: Anchor.center);

  int horizontalDirection = 0;
  final double moveSpeed = 200;
  final Vector2 velocity = Vector2.zero();

  @override
  void onLoad() {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache("ember.png"),
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.12,
        textureSize: Vector2.all(16.0),
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    velocity.x = horizontalDirection * moveSpeed;

    game.objectSpeed = 0;

    //Emberが画面の左端から消えないように
    if (position.x - size.x / 2 <= 0 && horizontalDirection < 0) {
      velocity.x = 0;
    }

    /*
    * 1. Emberが画面の半分を越したら世界が動く
    * 2. 世界が動いたらEmberは画面上は止まる
    * */
    if (horizontalDirection > 0 && position.x + size.x / 2 > game.size.x / 2) {
      velocity.x = 0;
      game.objectSpeed = -moveSpeed;
    }

    position += velocity * dt;

    if (horizontalDirection < 0 && scale.x > 0) {
      flipHorizontally();
    } else if (horizontalDirection > 0 && scale.x < 0) {
      flipHorizontally();
    }
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    horizontalDirection = 0;
    if (keysPressed.contains(LogicalKeyboardKey.keyA) ||
        keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      horizontalDirection -= 1;
    }
    if (keysPressed.contains(LogicalKeyboardKey.keyD) ||
        keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      horizontalDirection += 1;
    }
    return true;
  }
}
