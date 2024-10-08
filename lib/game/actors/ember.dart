import 'package:ember_quest/game/actors/water_enemy.dart';
import 'package:ember_quest/game/ember_quest_game.dart';
import 'package:ember_quest/game/objects/ground_block.dart';
import 'package:ember_quest/game/objects/platform_block.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../objects/star.dart';

class EmberPlayer extends SpriteAnimationComponent
    with HasGameReference<EmberQuestGame>, KeyboardHandler, CollisionCallbacks {
  EmberPlayer({required super.position})
      : super(size: Vector2.all(64.0), anchor: Anchor.center);

  int horizontalDirection = 0;
  final double moveSpeed = 200;
  final Vector2 velocity = Vector2.zero();

  final Vector2 fromAbove = Vector2(0, -1);
  bool isOnGround = false;

  final double gravity = 15;
  final double jumpSpeed = 600;
  final double terminalVelocity = 150;

  bool hasJumped = false;

  bool hitByEnemy = false;

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
    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    //super.update(dt);
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

    velocity.y += gravity;

    if (hasJumped) {
      if (this.isOnGround) {
        velocity.y = -jumpSpeed;
        this.isOnGround = false;
      }
      hasJumped = false;
    }

    velocity.y = velocity.y.clamp(-jumpSpeed, terminalVelocity);

    position += velocity * dt;
    //print("[Ember]velocity.y: ${velocity.y} / position: $position / isOnGround: $isOnGround");

    if (horizontalDirection < 0 && scale.x > 0) {
      flipHorizontally();
    } else if (horizontalDirection > 0 && scale.x < 0) {
      flipHorizontally();
    }

    if (position.y > game.size.y + size.y) {
      game.health = 0;
    }

    if (game.health <= 0) {
      removeFromParent();
    }

    super.update(dt);
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

    hasJumped = keysPressed.contains(LogicalKeyboardKey.space);
    return true;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is PlatformBlock || other is GroundBlock) {
      if (intersectionPoints.length == 2) {
        final mid = (intersectionPoints.elementAt(0) +
                intersectionPoints.elementAt(1)) /
            2;
        final collisionNormal = absoluteCenter - mid;
        final separationDistance = (size.x / 2) - collisionNormal.length;
        collisionNormal.normalize();

        if (fromAbove.dot(collisionNormal) > 0.9) {
          this.isOnGround = true;
        }

        position += collisionNormal.scaled(separationDistance);
      }
    }

    if (other is Star) {
      other.removeFromParent();
      game.starsCollected++;
      print("[獲った星の数]${game.starsCollected}");
    }

    if (other is WaterEnemy) {
      hit();
    }

    super.onCollision(intersectionPoints, other);
  }

  void hit() {
    if (!hitByEnemy) {
      game.health--;
      hitByEnemy = true;
    }
    add(
      OpacityEffect.fadeOut(
        EffectController(
          alternate: true,
          duration: 0.1,
          repeatCount: 6,
        ),
      )..onComplete = () {
        hitByEnemy = false;
      },
    );
  }
}
