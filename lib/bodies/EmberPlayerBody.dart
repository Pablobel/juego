import 'dart:html';

import 'package:flame/components.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import '../players/EmberPlayer.dart';

class EmberPlayerBody extends BodyComponent with KeyboardHandler,ContactCallbacks {
  bool mirandoDerecha1 = true;
  bool mirandoDerecha2 = true;
  int horizontalDirection = 0;
  int verticalDirection = 0;
  Vector2 initialPosition;
  final Vector2 velocidad = Vector2.zero();
  late Vector2 vector2Tamano;
  late int iTipo = -1;
  late Vector2 tamano;
  static const int PLAYER_1 = 0;
  static const int PLAYER_2 = 1;
  final double aceleracion = 10;
  late EmberPlayer emberPlayer;
  final diagonalNE = <LogicalKeyboardKey>{
    LogicalKeyboardKey.arrowUp,
    LogicalKeyboardKey.arrowRight
  };
  final diagonalSE = <LogicalKeyboardKey>{
    LogicalKeyboardKey.arrowDown,
    LogicalKeyboardKey.arrowRight
  };
  final diagonalSO = <LogicalKeyboardKey>{
    LogicalKeyboardKey.arrowDown,
    LogicalKeyboardKey.arrowLeft
  };
  final diagonalNO = <LogicalKeyboardKey>{
    LogicalKeyboardKey.arrowUp,
    LogicalKeyboardKey.arrowLeft
  };
  final diagonalNE2 = <LogicalKeyboardKey>{
    LogicalKeyboardKey.keyW,
    LogicalKeyboardKey.keyD
  };
  final diagonalSE2 = <LogicalKeyboardKey>{
    LogicalKeyboardKey.keyS,
    LogicalKeyboardKey.keyD
  };
  final diagonalSO2 = <LogicalKeyboardKey>{
    LogicalKeyboardKey.keyS,
    LogicalKeyboardKey.keyA
  };
  final diagonalNO2 = <LogicalKeyboardKey>{
    LogicalKeyboardKey.keyW,
    LogicalKeyboardKey.keyA
  };

  EmberPlayerBody(
      {required this.initialPosition, required this.iTipo, required this.tamano})
      : super(
          fixtureDefs: [
            FixtureDef(
              CircleShape()..radius = 35,
              restitution: 0.8,
              friction: 0.4,
            ),
          ],
          bodyDef: BodyDef(
              angularDamping: 0.8,
              position: initialPosition ?? Vector2.zero(),
              type: BodyType.dynamic),
        );

  @override
  Future<void> onLoad() {
    EmberPlayer player =
        EmberPlayer(position: Vector2(0, 0), iTipo: iTipo, size: tamano);
    add(player);
    return super.onLoad();
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    //print("TECLA:" + event.data.logicalKey.keyId.toString());
    horizontalDirection = 0;
    verticalDirection = 0;
    if (keysPressed.containsAll(diagonalNO) && iTipo == EmberPlayerBody.PLAYER_1) {
      horizontalDirection = -10;
      verticalDirection = -10;
      if (mirandoDerecha1) {
        //flipHorizontally();
        mirandoDerecha1 = false;
      }
    } else if (keysPressed.containsAll(diagonalNE) &&
        iTipo == EmberPlayerBody.PLAYER_1) {
      horizontalDirection = 10;
      verticalDirection = -10;
      if (!mirandoDerecha1) {
        //flipHorizontally();
        mirandoDerecha1 = true;
      }
    } else if (keysPressed.containsAll(diagonalSE) &&
        iTipo == EmberPlayerBody.PLAYER_1) {
      horizontalDirection = 10;
      verticalDirection = 10;
      if (!mirandoDerecha1) {
        //flipHorizontally();
        mirandoDerecha1 = true;
      }
    } else if (keysPressed.containsAll(diagonalSO) &&
        iTipo == EmberPlayerBody.PLAYER_1) {
      horizontalDirection = -10;
      verticalDirection = 10;
      if (mirandoDerecha1) {
        //flipHorizontally();
        mirandoDerecha1 = false;
      }
    } else if (keysPressed.containsAll(diagonalNO2) &&
        iTipo == EmberPlayerBody.PLAYER_2) {
      horizontalDirection = -10;
      verticalDirection = -10;
      if (mirandoDerecha2) {
        //flipHorizontally();
        mirandoDerecha2 = false;
      }
    } else if (keysPressed.containsAll(diagonalNE2) &&
        iTipo == EmberPlayerBody.PLAYER_2) {
      horizontalDirection = 10;
      verticalDirection = -10;
      if (!mirandoDerecha2) {
        //flipHorizontally();
        mirandoDerecha2 = true;
      }
    } else if (keysPressed.containsAll(diagonalSE2) &&
        iTipo == EmberPlayerBody.PLAYER_2) {
      horizontalDirection = 10;
      verticalDirection = 10;
      if (!mirandoDerecha2) {
        //flipHorizontally();
        mirandoDerecha2 = true;
      }
    } else if (keysPressed.containsAll(diagonalSO2) &&
        iTipo == EmberPlayerBody.PLAYER_2) {
      horizontalDirection = -10;
      verticalDirection = 10;
      if (mirandoDerecha2) {
        //flipHorizontally();
        mirandoDerecha2 = false;
      }
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowRight) &&
        iTipo == EmberPlayerBody.PLAYER_1) {
      horizontalDirection = 10;
      if (!mirandoDerecha1) {
        //flipHorizontally();
        mirandoDerecha1 = true;
      }
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowLeft) &&
        iTipo == EmberPlayerBody.PLAYER_1) {
      horizontalDirection = -10;
      if (mirandoDerecha1) {
        //flipHorizontally();
        mirandoDerecha1 = false;
      }
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowUp) &&
        iTipo == EmberPlayerBody.PLAYER_1) {
      verticalDirection = -10;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowDown) &&
        iTipo == PLAYER_1) {
      verticalDirection = 10;
    } else if (keysPressed.contains(LogicalKeyboardKey.keyD) &&
        iTipo == EmberPlayerBody.PLAYER_2) {
      horizontalDirection = 10;
      if (!mirandoDerecha2) {
        //flipHorizontally();
        mirandoDerecha2 = true;
      }
    } else if (keysPressed.contains(LogicalKeyboardKey.keyA) &&
        iTipo == EmberPlayerBody.PLAYER_2) {
      horizontalDirection = -10;
      if (mirandoDerecha2) {
        //flipHorizontally();
        mirandoDerecha2 = false;
      }
    } else if (keysPressed.contains(LogicalKeyboardKey.keyW) &&
        iTipo == EmberPlayerBody.PLAYER_2) {
      verticalDirection = -10;
    } else if (keysPressed.contains(LogicalKeyboardKey.keyS) &&
        iTipo == EmberPlayerBody.PLAYER_2) {
      verticalDirection = 10;
    } else if (keysPressed.contains(LogicalKeyboardKey.space)) {
      horizontalDirection = 0;
      verticalDirection = -5;
    } else {
      horizontalDirection = 0;
      verticalDirection = 0;
    }
    return super.onKeyEvent(event, keysPressed);
  }

  @override
  Body createBody() {
    BodyDef definicionCuerpo = BodyDef(
        position:initialPosition, type: BodyType.dynamic, fixedRotation: true);
    Body cuerpo = world.createBody(definicionCuerpo);

    final shape = CircleShape();
    shape.radius = tamano.x / 2;
    FixtureDef fixtureDef = FixtureDef(
      shape,
      restitution: 0.5,
    );
    debugMode = true;
    return cuerpo;
  }

  @override
  void update(double dt) {
    velocidad.x = horizontalDirection * aceleracion;
    velocidad.y = verticalDirection * aceleracion;
    position.x += velocidad.x;
    position.y += velocidad.y;
    super.update(dt);
  }
}