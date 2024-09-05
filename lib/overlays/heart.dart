import 'package:ember_quest/game/ember_quest_game.dart';
import 'package:flame/components.dart';

enum HeartState {
  available,
  unavailable,
}

class HeartHealthComponent extends SpriteGroupComponent<HeartState>
    with HasGameReference<EmberQuestGame> {
  final int heartNumber;

  HeartHealthComponent({
    required this.heartNumber,
    required super.position,
    required super.size,
  });


  @override
  void onLoad() {
    super.onLoad();

    final availableSprite = Sprite(
      game.images.fromCache("heart.png"),
      srcSize: Vector2.all(32),
    );

    final unavailableSprite = Sprite(
      game.images.fromCache("heart_half.png"),
      srcSize: Vector2.all(32),
    );

    sprites = {
      HeartState.available: availableSprite,
      HeartState.unavailable: unavailableSprite,
    };

    current = HeartState.available;
  }

  @override
  void update(double dt) {
    if (game.health < heartNumber) {
      current = HeartState.unavailable;
    } else {
      current = HeartState.available;
    }
    super.update(dt);
  }

}
