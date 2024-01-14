import 'package:flutter/material.dart';
import 'package:flame/game.dart';

import 'games/UghGame.dart';

void main() {
  runApp(
    const GameWidget<UghGame>.controlled(
      gameFactory: UghGame.new,
    ),
  );
}




