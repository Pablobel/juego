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
  final _collisionStartColor = Colors.black87;
  final _defaultColor = Colors.red;
  late ShapeHitbox hitbox;

  EmberPlayer(
      {required super.position, required this.iTipo, required super.size})
      : super(anchor: Anchor.center);

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

    final defaultPaint = Paint()
      ..color = _defaultColor
      ..style = PaintingStyle.stroke;

    hitbox = RectangleHitbox();
    hitbox.paint = defaultPaint;
    hitbox.isSolid = true;
    add(hitbox);
  }

}
