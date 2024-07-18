import 'dart:math';

import 'package:ember_quest/game/ember_quest_game.dart';
import 'package:ember_quest/game/managers/segment_manager.dart';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';

class GroundBlock extends SpriteComponent
    with HasGameReference<EmberQuestGame> {
  final Vector2 gridPosition;
  final double xOffset;

  final Vector2 velocity = Vector2.zero();

  final UniqueKey _blockKey = UniqueKey();

  GroundBlock({
    required this.gridPosition,
    required this.xOffset,
  }) : super(
          size: Vector2.all(64),
          anchor: Anchor.bottomLeft,
        );

  @override
  void onLoad() {
    super.onLoad();
    final image = game.images.fromCache("ground.png");
    sprite = Sprite(image);

    position = Vector2(
      xOffset + size.x * gridPosition.x,
      game.size.y - size.y * gridPosition.y,
    );

    if (gridPosition.x == 9 && position.x > game.lastBlockXPosition) {
      game.lastBlockKey = _blockKey;
      game.lastBlockXPosition = position.x + size.x;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    velocity.x = game.objectSpeed;
    if (position.x < -size.x) {
      removeFromParent();
      if (gridPosition.x == 0) {
        game.loadGameSegments(
          Random().nextInt(segments.length),
          game.lastBlockXPosition,
        );
      }
    }

    position += velocity * dt;

    if (gridPosition.x == 9) {
      if (game.lastBlockKey == _blockKey) {
        game.lastBlockXPosition = position.x + size.x - 10;
      }
    }
  }
}
