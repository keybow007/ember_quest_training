import 'package:ember_quest/game/ember_quest_game.dart';
import 'package:ember_quest/overlays/heart.dart';
import 'package:flame/components.dart';

class Hub extends PositionComponent with HasGameReference<EmberQuestGame> {
  Hub({
    super.position,
    super.size,
  });

  @override
  void onLoad() {
    super.onLoad();

    for (var i = 1; i <= game.health; i++) {
      final positionX = 40 * i;
      add(HeartHealthComponent(
        heartNumber: i,
        position: Vector2(positionX.toDouble(), 20),
        size: Vector2.all(32),
      ));
    }
  }
}
