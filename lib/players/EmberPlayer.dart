import 'dart:html';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:juego/games/UghGame.dart';

import '../elementos/Estrella.dart';
import '../elementos/Gota.dart';

class EmberPlayer extends SpriteAnimationComponent
    with HasGameReference<UghGame> {


  late int iTipo = -1;

  final _defaultColor = Colors.red;
  late ShapeHitbox hitbox;

  EmberPlayer(
      {required super.position, required this.iTipo, required super.size})
      : super(anchor: Anchor.center);

  @override
  void onLoad() {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('megaman.png'),
      SpriteAnimationData.sequenced(
        amount: 10,
        amountPerRow: 5,
        textureSize: Vector2(125,125),
        stepTime: 0.08,
      ),
    );

    final defaultPaint = Paint()
      ..color = _defaultColor
      ..style = PaintingStyle.stroke;

    hitbox = RectangleHitbox();
    hitbox.paint = defaultPaint;
    hitbox.isSolid = true;
    add(hitbox);
  }

}
