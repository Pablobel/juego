import 'package:flame/collisions.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_tiled/flame_tiled.dart';

class TierraBody extends BodyComponent with CollisionCallbacks {
  TiledObject tiledBody;

  TierraBody({required this.tiledBody});

  @override
  Future<void> onLoad() {
    renderBody = false;
    return super.onLoad();
  }

  @override
  Body createBody() {
    late FixtureDef fixtureDef;
    if (tiledBody.isRectangle) {
      PolygonShape shape = PolygonShape();
      final vertices = [
        Vector2(0, 0),
        Vector2(tiledBody.width, 0),
        Vector2(tiledBody.width, tiledBody.height),
        Vector2(0, tiledBody.height),
      ];
      shape.set(vertices);
      fixtureDef = FixtureDef(shape);
    } else if (tiledBody.isPolygon) {
      ChainShape shape = ChainShape();
      //List<Vector2> vertices = [];
      for (final point in tiledBody.polygon) {
        shape.vertices.add(Vector2(point.x, point.y));
      }
      Point point0 = tiledBody.polygon[0];
      shape.vertices.add(Vector2(point0.x, point0.y));
      fixtureDef = FixtureDef(shape,userData: this);
      debugMode=true;
    }
    BodyDef definicionCuerpo = BodyDef(
        position: Vector2(tiledBody.x, tiledBody.y), type: BodyType.static);
    Body cuerpo = world.createBody(definicionCuerpo);

    cuerpo.createFixture(fixtureDef);
    return cuerpo;
  }
}
