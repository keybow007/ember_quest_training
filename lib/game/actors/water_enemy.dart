import 'package:ember_quest/game/ember_quest_game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';

class WaterEnemy extends SpriteAnimationComponent
    with HasGameReference<EmberQuestGame> {
  final Vector2 gridPosition;
  double xOffset;

  final Vector2 velocity = Vector2.zero();

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
    add(RectangleHitbox(collisionType: CollisionType.passive));
    add(
      MoveEffect.by(
        Vector2(-2 * size.x, 0),
        EffectController(
          duration: 3.0,
          infinite: true,
          alternate: true,
        ),
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    velocity.x = game.objectSpeed;
    if (position.x < -size.x || game.health <= 0) removeFromParent();
    position += velocity * dt;
  }

}
