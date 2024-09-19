import 'package:ember_quest/game/ember_quest_game.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {
  final EmberQuestGame game;

  const MainMenu({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: SizedBox(
          width: 300,
          height: 150,
          child: ElevatedButton(
            onPressed: () {
              //TODO
              game.overlays.remove("MainMenu");
            },
            child: Text("PLAY"),
          ),
        ),
      ),
    );
  }
}
