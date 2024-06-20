import 'package:ember_quest/game/ember_quest_game.dart';
import 'package:flame/components.dart';

class WaterEnemy extends SpriteAnimationComponent
    with HasGameReference<EmberQuestGame> {
  final Vector2 gridPosition;
  double xOffset;

  WaterEnemy({
    required this.gridPosition,
    required this.xOffset,
  }) : super(
          size: Vector2.all(64),
          anchor: Anchor.bottomLeft,
        );

  @override
  void onLoad() {
    super.onLoad();
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache("water_enemy.png"),
      SpriteAnimationData.sequenced(
        amount: 2,
        stepTime: 0.7,
        textureSize: Vector2.all(16),
      ),
    );

    position = Vector2(
      xOffset + size.x * gridPosition.x,
      game.size.y - size.y * gridPosition.y,
    );
  }


}
