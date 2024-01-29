import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import '../elementos/Rayo.dart';

class RayoBody extends BodyComponent with CollisionCallbacks {
  Vector2 posicionInicial;
  Vector2 tamano;

  RayoBody({required this.posicionInicial, required this.tamano}) : super();

  @override
  Body createBody() {
    BodyDef bodyDef = BodyDef(type: BodyType.static, position: posicionInicial);
    Body cuerpo = world.createBody(bodyDef);
    CircleShape shape = CircleShape();
    shape.radius = tamano.x / 2;
    FixtureDef fixtureDef = FixtureDef(shape,
        density: 0, friction: 0, restitution: 0, userData: this);
    //debugMode = true;
    cuerpo.createFixture(fixtureDef);
    return cuerpo;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    Rayo rayo = Rayo(position: Vector2.zero(), size: tamano);
    add(rayo);
  }
}
