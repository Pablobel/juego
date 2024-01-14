import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'dart:async';

class UghGame extends FlameGame{

  final world = World();
  late final CameraComponent cameraComponent;

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
  }
}