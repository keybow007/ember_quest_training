import 'package:ember_quest/game/ember_quest_game.dart';
import 'package:ember_quest/overlays/game_over.dart';
import 'package:ember_quest/overlays/main_menu.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget<EmberQuestGame>.controlled(
        gameFactory: EmberQuestGame.new,
        overlayBuilderMap: {
          "MainMenu": (context, game) => MainMenu(game: game),
          "GameOver": (_, game) => GameOver(game: game),
        },
        initialActiveOverlays: ["MainMenu"],
      ),
    );
  }
}
