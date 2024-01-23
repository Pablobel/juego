import 'dart:html';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:juego/games/UghGame.dart';

import '../elementos/Gota.dart';

class GotaBody extends BodyComponent with CollisionCallbacks {
  Vector2 posicionInicial;
  Vector2 tamano;
  bool movimientoDerecha = true;
  int numeroMovimientos = 0;

  GotaBody({required this.posicionInicial, required this.tamano}) : super();

  @override
  Body createBody() {
    BodyDef bodyDef = BodyDef(type: BodyType.static, position: posicionInicial);
    Body cuerpo = world.createBody(bodyDef);
    CircleShape shape = CircleShape();
    shape.radius = tamano.x / 2;
    FixtureDef fixtureDef = FixtureDef(shape,
        density: 0, friction: 0, restitution: 0, userData: this);
    //debugMode = true;
    cuerpo..createFixture(fixtureDef);
    return cuerpo;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    Gota gota = Gota(position: Vector2.zero(), size: tamano);
    add(gota);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (movimientoDerecha) {
      position.x += 1;
      numeroMovimientos += 1;
    } else {
      position.x -= 1;
      numeroMovimientos += 1;
    }
    if (numeroMovimientos == 200) {
      numeroMovimientos = 0;
      movimientoDerecha = !movimientoDerecha;
    }
  }
}
