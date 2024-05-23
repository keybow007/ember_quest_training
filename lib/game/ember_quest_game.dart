import 'package:flame/game.dart';

class EmberQuestGame extends FlameGame {



  @override
  Future<void> onLoad() async {
    await images.loadAll([
      "block.png",
      "ember.png",
      "ground.png",
      "heart.png",
      "heart_half.png",
      "star.png",
      "water_enemy.png",
    ]);
  }

}