import 'package:ember_quest/game/ember_quest_game.dart';
import 'package:flutter/material.dart';

class GameOver extends StatelessWidget {
  final EmberQuestGame game;

  const GameOver({
    super.key,
    required this.game,
  });

  @override
  Widget build(BuildContext context) {
    //https://docs.flame-engine.org/latest/tutorials/platformer/step_7.html#game-over-menu
    return Center(
      child: Container(
        color: Colors.white,
        width: 300.0,
        height: 150.0,
        child: Center(
          child: Text("Game Over"),
        ),
      ),
    );
  }
}
