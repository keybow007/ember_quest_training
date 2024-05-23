import 'package:ember_quest/game/actors/ember.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';

class EmberQuestGame extends FlameGame {
  late EmberPlayer _emberPlayer;

  @override
  Future<void> onLoad() async {
    debugMode = true;

    await images.loadAll([
      "block.png",
      "ember.png",
      "ground.png",
      "heart.png",
      "heart_half.png",
      "star.png",
      "water_enemy.png",
    ]);

    //画面の原点座標を左上に設定
    camera.viewfinder.anchor = Anchor.topLeft;

    _emberPlayer = EmberPlayer(
      position: Vector2(128, canvasSize.y - 70),
    );
    world.add(_emberPlayer);
  }
}
