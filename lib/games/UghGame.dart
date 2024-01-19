import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:juego/bodies/EmberPlayerBody.dart';
import 'package:juego/bodies/TierraBody.dart';
import 'dart:async';
import 'package:juego/elementos/Estrella.dart';
import 'package:juego/elementos/Gota.dart';
import 'package:juego/players/EmberPlayer.dart';

class UghGame extends Forge2DGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  //final world = World();
  late final CameraComponent cameraComponent;
  late EmberPlayerBody _player1, _player2;
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

    ObjectGroup? tierras = mapComponent.tileMap.getLayer<ObjectGroup>("tierra");

    for (final tiledObjectTierra in tierras!.objects) {
      TierraBody tierraBody = TierraBody(tiledBody: tiledObjectTierra);
      add(tierraBody);
    }

    _player1 = EmberPlayerBody(
        initialPosition: Vector2(150, canvasSize.y - 600),
        iTipo: EmberPlayerBody.PLAYER_1,
        tamano: Vector2(50, 100));

    _player2 = EmberPlayerBody(
        initialPosition: Vector2(0, canvasSize.y - 0),
        iTipo: EmberPlayerBody.PLAYER_2,
        tamano: Vector2(50, 100));

    world.add(_player1);
    world.add(_player2);
  }

  @override
  Color backgroundColor() {
    return const Color.fromRGBO(255, 255, 0, 1.0);
  }
}
