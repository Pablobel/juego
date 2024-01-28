import 'package:flame/components.dart';
import 'package:juego/games/UghGame.dart';

class VidasVacias extends SpriteComponent
    with HasGameRef<UghGame> {

  VidasVacias({
    required super.position,required super.size
  });

  @override
  Future<void> onLoad() async {
    sprite = Sprite(game.images.fromCache('heart_half.png'));
    //anchor = Anchor.center;
    return super.onLoad();


  }
}
