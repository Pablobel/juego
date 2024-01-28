import 'package:flame/components.dart';
import 'package:juego/games/UghGame.dart';

class Vidas extends SpriteComponent
    with HasGameRef<UghGame> {

  Vidas({
    required super.position,required super.size
  });

  @override
  Future<void> onLoad() async {
    sprite = Sprite(game.images.fromCache('heart.png'));
    //anchor = Anchor.center;
    return super.onLoad();


  }
}
