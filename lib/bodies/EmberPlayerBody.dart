import 'package:flame/components.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import '../players/EmberPlayer.dart';
import '../players/EmberPlayer2.dart';

class EmberPlayerBody extends BodyComponent
    with KeyboardHandler, ContactCallbacks {
  int vidas = 5;
  bool saltando = false;
  bool mirandoDerecha1 = true;
  bool mirandoDerecha2 = true;
  int horizontalDirection = 0;
  int verticalDirection = 0;
  Vector2 initialPosition;
  Vector2 velocidad = Vector2.zero();
  late Vector2 vector2Tamano;
  late int iTipo = -1;
  late Vector2 tamano;
  static const int PLAYER_1 = 0;
  static const int PLAYER_2 = 1;
  final double aceleracion = 1000;
  late EmberPlayer emberPlayer;
  late EmberPlayer2 emberPlayer2;
  final derechaSalto1 = <LogicalKeyboardKey>{
    LogicalKeyboardKey.arrowRight,
    LogicalKeyboardKey.space
  };
  final izquierdaSalto1 = <LogicalKeyboardKey>{
    LogicalKeyboardKey.arrowLeft,
    LogicalKeyboardKey.space
  };
  final derechaSalto2 = <LogicalKeyboardKey>{
    LogicalKeyboardKey.keyD,
    LogicalKeyboardKey.keyT
  };
  final izquierdaSalto2 = <LogicalKeyboardKey>{
    LogicalKeyboardKey.keyA,
    LogicalKeyboardKey.keyT
  };

  /*final diagonalNE = <LogicalKeyboardKey>{
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
  };*/

  EmberPlayerBody(
      {required this.initialPosition,
      required this.iTipo,
      required this.tamano})
      : super();

  @override
  Future<void> onLoad() {
    if (iTipo == PLAYER_1) {
      emberPlayer =
          EmberPlayer(position: Vector2(-10, -10), iTipo: iTipo, size: tamano);
      add(emberPlayer);
    } else if (iTipo == PLAYER_2) {
      emberPlayer2 =
          EmberPlayer2(position: Vector2(-10, -10), iTipo: iTipo, size: tamano);
      add(emberPlayer2);
    }
    return super.onLoad();
  }

  /*@override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    //print("TECLA:" + event.data.logicalKey.keyId.toString());
    //horizontalDirection = 0;
    //verticalDirection = 0;
    if (keysPressed.containsAll(diagonalNO) &&
        iTipo == EmberPlayerBody.PLAYER_1) {
      horizontalDirection = -1;
      verticalDirection = -1;
      if (mirandoDerecha1) {
        emberPlayer.flipHorizontallyAroundCenter();
        mirandoDerecha1 = false;
      }
    } else if (keysPressed.containsAll(diagonalNE) &&
        iTipo == EmberPlayerBody.PLAYER_1) {
      horizontalDirection = 1;
      verticalDirection = -1;
      if (!mirandoDerecha1) {
        emberPlayer.flipHorizontallyAroundCenter();
        mirandoDerecha1 = true;
      }
    } else if (keysPressed.containsAll(diagonalSE) &&
        iTipo == EmberPlayerBody.PLAYER_1) {
      horizontalDirection = 1;
      verticalDirection = 1;
      if (!mirandoDerecha1) {
        emberPlayer.flipHorizontallyAroundCenter();
        mirandoDerecha1 = true;
      }
    } else if (keysPressed.containsAll(diagonalSO) &&
        iTipo == EmberPlayerBody.PLAYER_1) {
      horizontalDirection = -1;
      verticalDirection = 1;
      if (mirandoDerecha1) {
        emberPlayer.flipHorizontallyAroundCenter();
        mirandoDerecha1 = false;
      }
    } else if (keysPressed.containsAll(diagonalNO2) &&
        iTipo == EmberPlayerBody.PLAYER_2) {
      horizontalDirection = -1;
      verticalDirection = -1;
      if (mirandoDerecha2) {
        emberPlayer.flipHorizontallyAroundCenter();
        mirandoDerecha2 = false;
      }
    } else if (keysPressed.containsAll(diagonalNE2) &&
        iTipo == EmberPlayerBody.PLAYER_2) {
      horizontalDirection = 1;
      verticalDirection = -1;
      if (!mirandoDerecha2) {
        emberPlayer.flipHorizontallyAroundCenter();
        mirandoDerecha2 = true;
      }
    } else if (keysPressed.containsAll(diagonalSE2) &&
        iTipo == EmberPlayerBody.PLAYER_2) {
      horizontalDirection = 1;
      verticalDirection = 1;
      if (!mirandoDerecha2) {
        emberPlayer.flipHorizontallyAroundCenter();
        mirandoDerecha2 = true;
      }
    } else if (keysPressed.containsAll(diagonalSO2) &&
        iTipo == EmberPlayerBody.PLAYER_2) {
      horizontalDirection = -1;
      verticalDirection = 1;
      if (mirandoDerecha2) {
        emberPlayer.flipHorizontallyAroundCenter();
        mirandoDerecha2 = false;
      }
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowRight) &&
        iTipo == EmberPlayerBody.PLAYER_1) {
      horizontalDirection = 1;
      if (!mirandoDerecha1) {
        emberPlayer.flipHorizontallyAroundCenter();
        mirandoDerecha1 = true;
      }
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowLeft) &&
        iTipo == EmberPlayerBody.PLAYER_1) {
      horizontalDirection = -1;
      if (mirandoDerecha1) {
        emberPlayer.flipHorizontallyAroundCenter();
        mirandoDerecha1 = false;
      }
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowUp) &&
        iTipo == EmberPlayerBody.PLAYER_1) {
      verticalDirection = -1;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowDown) &&
        iTipo == PLAYER_1) {
      verticalDirection = 1;
    } else if (keysPressed.contains(LogicalKeyboardKey.keyD) &&
        iTipo == EmberPlayerBody.PLAYER_2) {
      horizontalDirection = 1;
      if (!mirandoDerecha2) {
        emberPlayer.flipHorizontallyAroundCenter();
        mirandoDerecha2 = true;
      }
    } else if (keysPressed.contains(LogicalKeyboardKey.keyA) &&
        iTipo == EmberPlayerBody.PLAYER_2) {
      horizontalDirection = -1;
      if (mirandoDerecha2) {
        emberPlayer.flipHorizontallyAroundCenter();
        mirandoDerecha2 = false;
      }
    } else if (keysPressed.contains(LogicalKeyboardKey.keyW) &&
        iTipo == EmberPlayerBody.PLAYER_2) {
      verticalDirection = -1;
    } else if (keysPressed.contains(LogicalKeyboardKey.keyS) &&
        iTipo == EmberPlayerBody.PLAYER_2) {
      verticalDirection = 1;
    } else if (keysPressed.contains(LogicalKeyboardKey.space)) {
      if(!saltando) {
        verticalDirection = -1000;
        //saltando = true;
      }
    } else {
      horizontalDirection = 0;
      verticalDirection = 0;
    }
    return super.onKeyEvent(event, keysPressed);
  }*/

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (keysPressed.containsAll(derechaSalto1) &&
        iTipo == EmberPlayerBody.PLAYER_1) {
      if (!mirandoDerecha1) {
        emberPlayer.flipHorizontallyAroundCenter();
        mirandoDerecha1 = true;
      }
      if (true) {
        horizontalDirection = 1000;
        verticalDirection = -1000;
      } else {
        verticalDirection = 0;
      }
    } else if (keysPressed.containsAll(izquierdaSalto1) &&
        iTipo == EmberPlayerBody.PLAYER_1) {
      if (mirandoDerecha1) {
        emberPlayer.flipHorizontallyAroundCenter();
        mirandoDerecha1 = false;
      }
      if (true) {
        horizontalDirection = -1000;
        verticalDirection = -1000;
      } else {
        verticalDirection = 0;
      }
    } else if (keysPressed.containsAll(derechaSalto2) &&
        iTipo == EmberPlayerBody.PLAYER_2) {
      if (!mirandoDerecha2) {
        emberPlayer2.flipHorizontallyAroundCenter();
        mirandoDerecha2 = true;
      }
      if (true) {
        horizontalDirection = 1000;
        verticalDirection = -1000;
      } else {
        verticalDirection = 0;
      }
    } else if (keysPressed.containsAll(izquierdaSalto2) &&
        iTipo == EmberPlayerBody.PLAYER_2) {
      if (mirandoDerecha2) {
        emberPlayer2.flipHorizontallyAroundCenter();
        mirandoDerecha2 = false;
      }
      if (true) {
        horizontalDirection = -1000;
        verticalDirection = -1000;
      } else {
        verticalDirection = 0;
      }
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowRight) &&
        iTipo == EmberPlayerBody.PLAYER_1) {
      horizontalDirection = 1;
      verticalDirection = 0;
      if (!mirandoDerecha1) {
        emberPlayer.flipHorizontallyAroundCenter();
        mirandoDerecha1 = true;
      }
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowLeft) &&
        iTipo == EmberPlayerBody.PLAYER_1) {
      horizontalDirection = -1;
      verticalDirection = 0;
      if (mirandoDerecha1) {
        emberPlayer.flipHorizontallyAroundCenter();
        mirandoDerecha1 = false;
      }
    } else if (keysPressed.contains(LogicalKeyboardKey.keyD) &&
        iTipo == EmberPlayerBody.PLAYER_2) {
      horizontalDirection = 1;
      verticalDirection = 0;
      if (!mirandoDerecha2) {
        emberPlayer2.flipHorizontallyAroundCenter();
        mirandoDerecha2 = true;
      }
    } else if (keysPressed.contains(LogicalKeyboardKey.keyA) &&
        iTipo == EmberPlayerBody.PLAYER_2) {
      horizontalDirection = -1;
      verticalDirection = 0;
      if (mirandoDerecha2) {
        emberPlayer2.flipHorizontallyAroundCenter();
        mirandoDerecha2 = false;
      }
    } else if (keysPressed.contains(LogicalKeyboardKey.space) &&
        iTipo == EmberPlayerBody.PLAYER_1) {
      if (true) {
        verticalDirection = -1000;
        saltando = true;
      } else {
        verticalDirection = 0;
      }
    } else if (keysPressed.contains(LogicalKeyboardKey.keyT) &&
        iTipo == EmberPlayerBody.PLAYER_2) {
      if (true) {
        verticalDirection = -1000;
        saltando = true;
      } else {
        verticalDirection = 0;
      }
    } else if (keysPressed.contains(LogicalKeyboardKey.digit5)) {
      if (world.gravity == Vector2(0, 1000)) {
        world.gravity = Vector2(0, 0);
      } else {
        world.gravity = Vector2(0, 1000);
      }
    } else {
      horizontalDirection = 0;
      verticalDirection = 0;
    }
    return super.onKeyEvent(event, keysPressed);
  }

  @override
  Body createBody() {
    BodyDef definicionCuerpo = BodyDef(
        position: initialPosition,
        type: BodyType.dynamic,
        fixedRotation: true,
        userData: this);
    Body cuerpo = world.createBody(definicionCuerpo);

    final shape = CircleShape();
    shape.radius = tamano.x / 3;
    FixtureDef fixtureDef = FixtureDef(shape,
        density: 0.5, friction: 1, restitution: 0, userData: this);
    //debugMode = true;
    cuerpo..createFixture(fixtureDef);
    return cuerpo;
  }

  @override
  void update(double dt) {
    velocidad.x = horizontalDirection * aceleracion;
    velocidad.y = verticalDirection * aceleracion;
    Vector2 impulse = Vector2(velocidad.x, velocidad.y);
    body.applyLinearImpulse(impulse * dt * 1000);
    super.update(dt);
  }
}
