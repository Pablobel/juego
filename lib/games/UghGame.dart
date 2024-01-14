import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'dart:async';

import '../players/EmberPlayer.dart';

class UghGame extends FlameGame{

  final world = World();
  late final CameraComponent cameraComponent;
  late EmberPlayer _player1, _player2;

  @override
  Future<void> onLoad() async {
    await images.loadAll([

      'ember.png',
      'heart_half.png',
      'heart.png',
      'star.png',
      'water_enemy.png',
    ]);

    cameraComponent = CameraComponent(world:world);
    cameraComponent.viewfinder.anchor = Anchor.topLeft;

    addAll([cameraComponent,world]);

    _player1 = EmberPlayer(
      position: Vector2(128, canvasSize.y - 70),
    );

    _player2 = EmberPlayer(
      position: Vector2(228, canvasSize.y - 70),
    );

    world.add(_player1);
    world.add(_player2);
  }
}