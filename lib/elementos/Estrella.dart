import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'package:juego/games/UghGame.dart';

class Estrella extends SpriteComponent
    with HasGameRef<UghGame>, CollisionCallbacks {

  final _collisionStartColor = Colors.black87;
  final _defaultColor = Colors.red;
  late ShapeHitbox hitbox;

  Estrella({
    required super.position,required super.size
  }): super(anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    sprite = Sprite(game.images.fromCache('star.png'));
    //anchor = Anchor.center;
    final defaultPaint = Paint()
      ..color = _defaultColor
      ..style = PaintingStyle.stroke;

    hitbox = RectangleHitbox();
    hitbox.paint=defaultPaint;
    hitbox.isSolid=true;
    add(hitbox);
    return super.onLoad();


  }
}
