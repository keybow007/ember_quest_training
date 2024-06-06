import 'package:ember_quest/game/actors/ember.dart';
import 'package:ember_quest/game/actors/water_enemy.dart';
import 'package:ember_quest/game/managers/segment_manager.dart';
import 'package:ember_quest/game/objects/ground_block.dart';
import 'package:ember_quest/game/objects/platform_block.dart';
import 'package:ember_quest/game/objects/star.dart';
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
    initializeGame();
  }

  void initializeGame() {

    //TODo 仮
    loadGameSegments(0);

    _emberPlayer = EmberPlayer(
      position: Vector2(128, canvasSize.y - 70),
    );
    world.add(_emberPlayer);
  }

  void loadGameSegments(int segmentIndex) {
    final blocks = segments[segmentIndex];
    for (int i = 0; i < blocks.length; i++) {
      final block = blocks[i];
      switch (block.blockType) {
        case GroundBlock:
          break;
        case PlatformBlock:
          add(PlatformBlock(gridPosition: block.gridPosition));
          break;
        case Star:
          break;
        case WaterEnemy:
          break;
      }
    }
  }
}
