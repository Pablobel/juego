import 'package:flame/components.dart';

import 'package:juego/games/UghGame.dart';

class Gota extends SpriteAnimationComponent with HasGameReference<UghGame> {
  bool movimientoDerecha = true;
  int numeroMovimientos = 0;

  Gota({required super.position, required super.size})
      : super(anchor: Anchor.center);

  @override
  void onLoad() {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('water_enemy.png'),
      SpriteAnimationData.sequenced(
        amount: 2,
        textureSize: Vector2.all(16),
        stepTime: 0.12,
      ),
    );
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
