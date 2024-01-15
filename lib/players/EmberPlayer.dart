import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:juego/games/UghGame.dart';


class EmberPlayer extends SpriteAnimationComponent
    with HasGameReference<UghGame>,KeyboardHandler {

  int horizontalDirection=0;

  EmberPlayer({
    required super.position,
  }) : super(size: Vector2.all(64), anchor: Anchor.center);

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
    //print("TECLA:"+event.data.logicalKey.keyId.toString());
    horizontalDirection=0;
    if(keysPressed.contains(LogicalKeyboardKey.arrowRight)){
      //horizontalDirection=1;
      position.x+=20;
    }
    if(keysPressed.contains(LogicalKeyboardKey.arrowLeft)){
      //horizontalDirection=1;
      position.x-=20;
    }
    if(keysPressed.contains(LogicalKeyboardKey.arrowUp)){
      //horizontalDirection=1;
      position.y-=20;
    }
    if(keysPressed.contains(LogicalKeyboardKey.arrowDown)){
      //horizontalDirection=1;
      position.y+=20;
    }
    return super.onKeyEvent(event, keysPressed);
  }
}