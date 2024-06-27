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
    position += velocity * dt;
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    horizontalDirection = 0;
    if (keysPressed.contains(LogicalKeyboardKey.keyA) ||
        keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      //horizontalDirection = -1;
      horizontalDirection -= 1;
    }
    if (keysPressed.contains(LogicalKeyboardKey.keyD) ||
        keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      //horizontalDirection = 1;
      horizontalDirection += 1;
    }
    return true;
  }
}
