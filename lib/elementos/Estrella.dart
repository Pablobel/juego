import 'package:flame/components.dart';

import 'package:juego/games/UghGame.dart';

class Estrella extends SpriteComponent with HasGameRef<UghGame> {
  Estrella({
    required super.position,
  });

  @override
  Future<void> onLoad() async {
    sprite = Sprite(game.images.fromCache('star.png'));
    anchor = Anchor.center;
    return super.onLoad();
  }
}
