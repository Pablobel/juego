import 'package:flame/components.dart';

import 'package:juego/games/UghGame.dart';


class Gota extends SpriteAnimationComponent
    with HasGameReference<UghGame> {

  Gota({
    required super.position,required super.size
  }) : super(anchor: Anchor.center);

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
}