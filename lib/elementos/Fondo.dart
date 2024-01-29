import 'package:flame/components.dart';

class Fondo extends Component with HasGameRef {
  late final SpriteComponent _backgroundSprite;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final sprite = await gameRef.loadSprite('universo.png');
    _backgroundSprite = SpriteComponent(sprite: sprite, size: gameRef.size);
    add(_backgroundSprite);
  }
}
