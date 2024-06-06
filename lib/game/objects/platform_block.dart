import 'package:ember_quest/game/ember_quest_game.dart';
import 'package:flame/components.dart';

class PlatformBlock extends SpriteComponent
    with HasGameReference<EmberQuestGame> {
  final Vector2 gridPosition;

  //TODO
  PlatformBlock({required this.gridPosition})
      : super(
          size: Vector2.all(64),
          anchor: Anchor.bottomLeft,
        );

  @override
  void onLoad() {
    super.onLoad();
    final image = game.images.fromCache("block.png");
    sprite = Sprite(image);

    position = Vector2(
      size.x * gridPosition.x,
      game.size.y - size.y * gridPosition.y,
    );
  }
}
