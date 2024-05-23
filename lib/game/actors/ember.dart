import 'package:ember_quest/game/ember_quest_game.dart';
import 'package:flame/components.dart';

class EmberPlayer extends SpriteAnimationComponent
    with HasGameReference<EmberQuestGame> {
  EmberPlayer({required super.position})
      : super(size: Vector2.all(64.0), anchor: Anchor.center);

  @override
  void onLoad() {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache("ember.png"),
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.12,
        textureSize: Vector2.all(16.0),
      ),
    );
  }
}
