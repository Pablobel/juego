import 'dart:ui';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'dart:async';

import 'package:juego/elementos/Estrella.dart';
import 'package:juego/elementos/Gota.dart';
import 'package:juego/players/EmberPlayer.dart';

class UghGame extends FlameGame with HasKeyboardHandlerComponents,HasCollisionDetection {
  final world = World();
  late final CameraComponent cameraComponent;
  late EmberPlayer _player1, _player2;
  late TiledComponent mapComponent;

  @override
  Future<void> onLoad() async {
    await images.loadAll([
      'ember.png',
      'heart_half.png',
      'heart.png',
      'star.png',
      'water_enemy.png',
      'tilemap1_32.png'
    ]);

    cameraComponent = CameraComponent(world: world);
    cameraComponent.viewfinder.anchor = Anchor.topLeft;
    addAll([cameraComponent, world]);

    mapComponent = await TiledComponent.load('mapa1.tmx', Vector2.all(32));
    world.add(mapComponent);

    ObjectGroup? estrellas =
        mapComponent.tileMap.getLayer<ObjectGroup>("estrellas");

    for (final estrella in estrellas!.objects) {
      Estrella spriteStar = Estrella(position: Vector2(estrella.x, estrella.y));
      add(spriteStar);
    }

    ObjectGroup? gotas = mapComponent.tileMap.getLayer<ObjectGroup>("gotas");

    for (final gota in gotas!.objects) {
      Gota spriteGota =
          Gota(position: Vector2(gota.x, gota.y), size: Vector2.all(64));
      add(spriteGota);
    }

    _player1 = EmberPlayer(
      position: Vector2(128, canvasSize.y - 70),
      iTipo: EmberPlayer.PLAYER_1,
    );

    _player2 = EmberPlayer(
      position: Vector2(228, canvasSize.y - 70),
      iTipo: EmberPlayer.PLAYER_2,
    );

    world.add(_player1);
    world.add(_player2);
  }

  @override
  Color backgroundColor() {
    return Color.fromRGBO(255, 255, 0, 1.0);
  }
}
