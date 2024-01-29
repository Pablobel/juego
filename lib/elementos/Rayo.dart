import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:juego/games/UghGame.dart';

class Rayo extends SpriteAnimationComponent
    with HasGameReference<UghGame>, CollisionCallbacks {


  final _collisionStartColor = Colors.black87;
  final _defaultColor = Colors.red;
  late ShapeHitbox hitbox;

  Rayo({required super.position, required super.size})
      : super(anchor: Anchor.center);

  @override
  void onLoad() {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('rayo.png'),
      SpriteAnimationData.sequenced(
        amount: 3,
        amountPerRow: 2,
        textureSize: Vector2(250,250),
        stepTime: 0.12,
      ),
    );

    final defaultPaint = Paint()
      ..color = _defaultColor
      ..style = PaintingStyle.stroke;

    hitbox = RectangleHitbox();
    hitbox.paint=defaultPaint;
    hitbox.isSolid=true;
    add(hitbox);
  }


}
