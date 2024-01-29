import 'dart:js';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:juego/bodies/EmberPlayerBody.dart';
import 'package:juego/bodies/EstrellaBody.dart';
import 'package:juego/bodies/GotaBody.dart';
import 'package:juego/bodies/TierraBody.dart';
import 'dart:async';
import 'package:juego/elementos/Estrella.dart';
import 'package:juego/elementos/Gota.dart';
import 'package:juego/players/EmberPlayer.dart';
import '../bodies/PuertaBody.dart';
import '../bodies/RayoBody.dart';
import '../elementos/Fondo.dart';
import '../elementos/Puerta.dart';
import '../elementos/Vidas.dart';
import '../elementos/VidasVacias.dart';

class UghGame extends Forge2DGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  //final world = World();
  late final CameraComponent cameraComponent;
  late EmberPlayerBody _player1, _player2;
  late RayoBody rayoBody1, rayoBody2;
  late TiledComponent mapComponent;
  List<dynamic> vidas1 = [];
  List<dynamic> vidas2 = [];
  int estrellasConseguidas = 0;

  UghGame() : super(gravity: Vector2(0, 1000));

  @override
  Future<void> onLoad() async {
    await images.loadAll([
      'ember.png',
      'heart_half.png',
      'heart.png',
      'star.png',
      'water_enemy.png',
      'tilemap1_32.png',
      'megaman.png',
      'megamanrojo.png',
      'puerta.png',
      'rayo.png',
      'universo.png'
    ]);

    final background = Fondo();
    add(background);

    cameraComponent = CameraComponent(world: world);
    cameraComponent.viewfinder.anchor = Anchor.topLeft;
    addAll([cameraComponent, world]);

    mapComponent = await TiledComponent.load('mapa1.tmx', Vector2.all(32));
    add(mapComponent);

    PuertaBody puertaBody =
        PuertaBody(posicionInicial: Vector2(800, 370), tamano: Vector2(75, 75));
    add(puertaBody);

    rayoBody1 =
        RayoBody(posicionInicial: Vector2(700, 240), tamano: Vector2(100, 400));
    add(rayoBody1);

    rayoBody2 =
        RayoBody(posicionInicial: Vector2(900, 240), tamano: Vector2(100, 400));
    add(rayoBody2);

    ObjectGroup? estrellas =
        mapComponent.tileMap.getLayer<ObjectGroup>("estrellas");

    for (final estrella in estrellas!.objects) {
      EstrellaBody estrellaBody = EstrellaBody(
          posicionInicial: Vector2(estrella.x, estrella.y),
          tamano: Vector2(50, 50));
      add(estrellaBody);
    }

    ObjectGroup? gotas = mapComponent.tileMap.getLayer<ObjectGroup>("gotas");

    for (final gota in gotas!.objects) {
      GotaBody gotaBody = GotaBody(
          posicionInicial: Vector2(gota.x, gota.y), tamano: Vector2(25, 25));
      add(gotaBody);
    }

    ObjectGroup? tierras = mapComponent.tileMap.getLayer<ObjectGroup>("tierra");

    for (final tiledObjectTierra in tierras!.objects) {
      TierraBody tierraBody = TierraBody(tiledBody: tiledObjectTierra);
      add(tierraBody);
    }

    cargarVidasPlayer1(5);
    cargarVidasPlayer2(5);

    _player1 = EmberPlayerBody(
        initialPosition: Vector2(100, canvasSize.y - 50),
        iTipo: EmberPlayerBody.PLAYER_1,
        tamano: Vector2(75, 75));
    _player1.onBeginContact = colisionesPlayer1;
    _player2 = EmberPlayerBody(
        initialPosition: Vector2(1500, canvasSize.y - 51),
        iTipo: EmberPlayerBody.PLAYER_2,
        tamano: Vector2(75, 75));
    _player2.onBeginContact = colisionesPlayer2;
    add(_player1);
    add(_player2);
  }

  /*@override
  Color backgroundColor() {
    return const Color.fromRGBO(255, 255, 0, 1.0);
  }*/

  void colisionesPlayer1(Object objeto1, Object objeto2) {
    if (objeto1 is GotaBody) {
      _player1.vidas -= 1;
      cargarVidasPlayer1(_player1.vidas);
      if (_player1.position.x < objeto1.position.x) {
        _player1.horizontalDirection = -1;
      } else {
        _player1.horizontalDirection = 1;
      }
    } else if (objeto1 is EstrellaBody) {
      objeto1.removeFromParent();
      estrellasConseguidas += 1;
    } else if (objeto1 is RayoBody) {
      _player1.vidas = 0;
    } else if (objeto1 is PuertaBody) {
      mostrarVictoria();
    }

    if (_player1.vidas == 0) {
      _player1.removeFromParent();
      if (_player2.vidas == 0) {
        mostrarGameOver();
      }
    }
    if (estrellasConseguidas == 10) {
      rayoBody1.removeFromParent();
      rayoBody2.removeFromParent();
    }
  }

  void colisionesPlayer2(Object objeto1, Object objeto2) {
    if (objeto1 is GotaBody) {
      _player2.vidas -= 1;
      cargarVidasPlayer2(_player2.vidas);
      if (_player2.position.x < objeto1.position.x) {
        _player2.horizontalDirection = -1;
      } else {
        _player2.horizontalDirection = 1;
      }
    } else if (objeto1 is EstrellaBody) {
      objeto1.removeFromParent();
      estrellasConseguidas += 1;
    } else if (objeto1 is RayoBody) {
      _player2.vidas = 0;
    } else if (objeto1 is PuertaBody) {
      mostrarVictoria();
    }

    if (_player2.vidas == 0) {
      _player2.removeFromParent();
      if (_player1.vidas == 0) {
        mostrarGameOver();
      }
    }
    if (estrellasConseguidas == 10) {
      rayoBody1.removeFromParent();
      rayoBody2.removeFromParent();
    }
  }

  void mostrarGameOver() {
    var gameOverText = TextComponent(
      text: 'Game Over',
      textRenderer:
          TextPaint(style: TextStyle(fontSize: 200, color: Colors.red)),
    )
      ..anchor = Anchor.center
      ..position = size / 2; // Centrar en la pantalla
    add(gameOverText);
  }

  void mostrarVictoria() {
    var victoria = TextComponent(
      text: 'YOU WIN',
      textRenderer:
          TextPaint(style: TextStyle(fontSize: 200, color: Colors.red)),
    )
      ..anchor = Anchor.center
      ..position = size / 2; // Centrar en la pantalla
    add(victoria);
  }

  void cargarVidasPlayer1(int vidasRestantes) {
    if (!vidas1.isEmpty) {
      for (Object i in vidas1) {
        if (i is Vidas) {
          i.removeFromParent();
        }
        if (i is VidasVacias) {
          i.removeFromParent();
        }
      }
      vidas1.clear();
    }
    Vidas vidasLlenasPlayer1;
    VidasVacias vidasVaciasPlayer1;
    double posicionX = 10;
    for (int i = 0; i < vidasRestantes; i++) {
      vidasLlenasPlayer1 =
          Vidas(position: Vector2(posicionX, 10), size: Vector2(25, 25));
      add(vidasLlenasPlayer1);
      posicionX += 30;
      vidas1.add(vidasLlenasPlayer1);
    }
    for (int i = vidasRestantes; i < 5; i++) {
      vidasVaciasPlayer1 =
          VidasVacias(position: Vector2(posicionX, 10), size: Vector2(25, 25));
      add(vidasVaciasPlayer1);
      posicionX += 30;
      vidas1.add(vidasVaciasPlayer1);
    }
  }

  void cargarVidasPlayer2(int vidasRestantes) {
    if (!vidas2.isEmpty) {
      for (Object i in vidas2) {
        if (i is Vidas) {
          i.removeFromParent();
        }
        if (i is VidasVacias) {
          i.removeFromParent();
        }
      }
      vidas2.clear();
    }
    Vidas vidasLlenasPlayer2;
    VidasVacias vidasVaciasPlayer2;
    double posicionX = 1500;
    for (int i = 0; i < vidasRestantes; i++) {
      vidasLlenasPlayer2 =
          Vidas(position: Vector2(posicionX, 10), size: Vector2(25, 25));
      add(vidasLlenasPlayer2);
      posicionX += 30;
      vidas2.add(vidasLlenasPlayer2);
    }
    for (int i = vidasRestantes; i < 5; i++) {
      vidasVaciasPlayer2 =
          VidasVacias(position: Vector2(posicionX, 10), size: Vector2(25, 25));
      add(vidasVaciasPlayer2);
      posicionX += 30;
      vidas2.add(vidasVaciasPlayer2);
    }
  }
}
