import 'package:ember_quest/game/ember_quest_game.dart';
import 'package:ember_quest/overlays/heart.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Hub extends PositionComponent with HasGameReference<EmberQuestGame> {
  Hub({
    super.position,
    super.size,
  });

  late TextComponent scoreTextComponent;

  @override
  void onLoad() {
    super.onLoad();
    //ハート（ライフ）
    for (var i = 1; i <= game.health; i++) {
      final positionX = 40 * i;
      add(HeartHealthComponent(
        heartNumber: i,
        position: Vector2(positionX.toDouble(), 20),
        size: Vector2.all(32),
      ));
    }

    //星の画像
    final starImage = game.images.fromCache("star.png");
    final starSprite = Sprite(starImage);
    add(
      SpriteComponent(
          sprite: starSprite,
          position: Vector2(game.size.x - 100, 20),
          //anchor: Anchor.center,
          size: Vector2.all(32)),
    );

    //スコアの文字
    scoreTextComponent = TextComponent(
      text: game.starsCollected.toString(),
      textRenderer: TextPaint(
        style: TextStyle(
          fontSize: 32,
          color: Colors.black,
        ),
      ),
      position: Vector2(game.size.x - 60, 20),
    );
    add(scoreTextComponent);
  }

  @override
  void update(double dt) {
    super.update(dt);
    scoreTextComponent.text = game.starsCollected.toString();
  }
}
