import 'package:ember_quest/game/ember_quest_game.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

class Star extends SpriteComponent with HasGameReference<EmberQuestGame> {
  final Vector2 gridPosition;
  final double xOffset;

  Star({
    required this.gridPosition,
    required this.xOffset,
  }) : super(
          size: Vector2.all(64),
          anchor: Anchor.center,
        );

  @override
  void onLoad() {
    super.onLoad();
    final image = game.images.fromCache("star.png");
    sprite = Sprite(image);

    position = Vector2(
      xOffset + size.x * gridPosition.x + (size.x / 2),
      game.size.y - size.y * gridPosition.y - (size.y / 2),
    );

    add(
      SizeEffect.by(
        Vector2(-24, -24),
        EffectController(
          duration: 0.75,
          reverseDuration: 0.5,
          infinite: true,
          curve: Curves.easeInOut,
        ),
      ),
    );
  }
}
