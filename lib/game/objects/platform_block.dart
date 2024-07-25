import 'package:ember_quest/game/ember_quest_game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class PlatformBlock extends SpriteComponent
    with HasGameReference<EmberQuestGame> {
  final Vector2 gridPosition;
  final double xOffset;

  final Vector2 velocity = Vector2.zero();

  PlatformBlock({
    required this.gridPosition,
    required this.xOffset,
  }) : super(
          size: Vector2.all(64),
          anchor: Anchor.bottomLeft,
        );

  @override
  void onLoad() {
    super.onLoad();
    final image = game.images.fromCache("block.png");
    sprite = Sprite(image);

    position = Vector2(
      xOffset + size.x * gridPosition.x,
      game.size.y - size.y * gridPosition.y,
    );

    add(RectangleHitbox(collisionType: CollisionType.passive));
  }

  @override
  void update(double dt) {
    super.update(dt);
    velocity.x = game.objectSpeed;
    if (position.x < -size.x) removeFromParent();
    position += velocity * dt;
    //position = position + velocity * dt;
  }
}
