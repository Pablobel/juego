import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:juego/games/UghGame.dart';

class EmberPlayer extends SpriteAnimationComponent
    with HasGameReference<UghGame>, KeyboardHandler {
  bool mirandoDerecha1 = true;
  bool mirandoDerecha2 = true;
  int horizontalDirection = 0;
  int verticalDirection = 0;
  final Vector2 velocidad = Vector2.zero();
  final double aceleracion = 1;
  late int iTipo = -1;
  static const int PLAYER_1 = 0;
  static const int PLAYER_2 = 1;
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

  EmberPlayer({required super.position, required this.iTipo})
      : super(size: Vector2.all(64), anchor: Anchor.center);

  @override
  void onLoad() {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('ember.png'),
      SpriteAnimationData.sequenced(
        amount: 4,
        textureSize: Vector2.all(16),
        stepTime: 0.12,
      ),
    );
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    print("TECLA:" + event.data.logicalKey.keyId.toString());
    horizontalDirection = 0;
    verticalDirection = 0;
    if (keysPressed.containsAll(diagonalNO) && iTipo == EmberPlayer.PLAYER_1) {
      horizontalDirection = -1;
      verticalDirection = -1;
    } else if (keysPressed.containsAll(diagonalNE) &&
        iTipo == EmberPlayer.PLAYER_1) {
      horizontalDirection = 1;
      verticalDirection = -1;
    } else if (keysPressed.containsAll(diagonalSE) &&
        iTipo == EmberPlayer.PLAYER_1) {
      horizontalDirection = 1;
      verticalDirection = 1;
    } else if (keysPressed.containsAll(diagonalSO) &&
        iTipo == EmberPlayer.PLAYER_1) {
      horizontalDirection = -1;
      verticalDirection = 1;
    } else if (keysPressed.containsAll(diagonalNO2) &&
        iTipo == EmberPlayer.PLAYER_2) {
      horizontalDirection = -1;
      verticalDirection = -1;
    } else if (keysPressed.containsAll(diagonalNE2) &&
        iTipo == EmberPlayer.PLAYER_2) {
      horizontalDirection = 1;
      verticalDirection = -1;
    } else if (keysPressed.containsAll(diagonalSE2) &&
        iTipo == EmberPlayer.PLAYER_2) {
      horizontalDirection = 1;
      verticalDirection = 1;
    } else if (keysPressed.containsAll(diagonalSO2) &&
        iTipo == EmberPlayer.PLAYER_2) {
      horizontalDirection = -1;
      verticalDirection = 1;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowRight) &&
        iTipo == PLAYER_1) {
      horizontalDirection = 1;
      //position.x += 20;
      if (!mirandoDerecha1) {
        flipHorizontally();
        mirandoDerecha1 = true;
      }
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowLeft) &&
        iTipo == PLAYER_1) {
      horizontalDirection = -1;
      //position.x -= 20;
      if (mirandoDerecha1) {
        flipHorizontally();
        mirandoDerecha1 = false;
      }
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowUp) &&
        iTipo == PLAYER_1) {
      verticalDirection = -1;
      //position.y -= 20;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowDown) &&
        iTipo == PLAYER_1) {
      verticalDirection = 1;
      //position.y += 20;
    } else if (keysPressed.contains(LogicalKeyboardKey.keyD) &&
        iTipo == PLAYER_2) {
      horizontalDirection = 1;
      //position.x += 20;
      if (!mirandoDerecha2) {
        flipHorizontally();
        mirandoDerecha2 = true;
      }
    } else if (keysPressed.contains(LogicalKeyboardKey.keyA) &&
        iTipo == PLAYER_2) {
      horizontalDirection = -1;
      //position.x -= 20;
      if (mirandoDerecha2) {
        flipHorizontally();
        mirandoDerecha2 = false;
      }
    } else if (keysPressed.contains(LogicalKeyboardKey.keyW) &&
        iTipo == PLAYER_2) {
      verticalDirection = -1;
      //position.y -= 20;
    } else if (keysPressed.contains(LogicalKeyboardKey.keyS) &&
        iTipo == PLAYER_2) {
      verticalDirection = 1;
      //position.y += 20;
    } else if (keysPressed.contains(LogicalKeyboardKey.space)) {
    } else {
      horizontalDirection = 0;
      verticalDirection = 0;
    }
    return super.onKeyEvent(event, keysPressed);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x += horizontalDirection * aceleracion;
    position.y += verticalDirection * aceleracion;
  }
}
