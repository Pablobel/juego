import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:juego/bodies/EmberPlayerBody.dart';
import 'package:juego/bodies/EstrellaBody.dart';
import 'package:juego/bodies/GotaBody.dart';
import 'package:juego/bodies/TierraBody.dart';
import 'dart:async';
import 'package:juego/elementos/Estrella.dart';
import 'package:juego/elementos/Gota.dart';
import 'package:juego/players/EmberPlayer.dart';

import '../elementos/Vidas.dart';
import '../elementos/VidasVacias.dart';

class UghGame extends Forge2DGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  //final world = World();
  late final CameraComponent cameraComponent;
  late EmberPlayerBody _player1, _player2;
  late TiledComponent mapComponent;

  UghGame() : super(gravity: Vector2(0, 1000));

  @override
  Future<void> onLoad() async {
    await images.loadAll([
      'ember.png',
      'heart_half.png',
      'heart.png',
      'star.png',
      'water_enemy.png',
      'tilemap1_32.png',
      'megaman.png'
    ]);

    cameraComponent = CameraComponent(world: world);
    cameraComponent.viewfinder.anchor = Anchor.topLeft;
    addAll([cameraComponent, world]);

    mapComponent = await TiledComponent.load('mapa1.tmx', Vector2.all(32));
    add(mapComponent);

    ObjectGroup? estrellas =
        mapComponent.tileMap.getLayer<ObjectGroup>("estrellas");

    for (final estrella in estrellas!.objects) {
      EstrellaBody estrellaBody = EstrellaBody(
          posicionInicial: Vector2(estrella.x, estrella.y),
          tamano: Vector2(50, 50));
      add(estrellaBody);
    }

    ObjectGroup? gotas = mapComponent.tileMap.getLayer<ObjectGroup>("gotas");

    for (final gota in gotas!.objects) {
      GotaBody gotaBody = GotaBody(
          posicionInicial: Vector2(gota.x, gota.y), tamano: Vector2(25, 25));

      add(gotaBody);
    }

    ObjectGroup? tierras = mapComponent.tileMap.getLayer<ObjectGroup>("tierra");

    for (final tiledObjectTierra in tierras!.objects) {
      TierraBody tierraBody = TierraBody(tiledBody: tiledObjectTierra);
      add(tierraBody);
    }

    cargarVidasPlayer1(3);


    _player1 = EmberPlayerBody(
        initialPosition: Vector2(150, canvasSize.y - 50),
        iTipo: EmberPlayerBody.PLAYER_1,
        tamano: Vector2(50, 100));
    _player1.onBeginContact = colisionesJuego;
    /*_player2 = EmberPlayerBody(
        initialPosition: Vector2(50, canvasSize.y - 51),
        iTipo: EmberPlayerBody.PLAYER_2,
        tamano: Vector2(50, 100));
    _player2.onBeginContact = colisionesJuego;
    add(_player1);*/
    add(_player1);
  }

  @override
  Color backgroundColor() {
    return const Color.fromRGBO(255, 255, 0, 1.0);
  }

  void colisionesJuego(Object objeto1, Object objeto2) {
    if (objeto1 is GotaBody) {
      _player1.vidas-=1;
      cargarVidasPlayer1(_player1.vidas);
      _player1.horizontalDirection=-1000;
    } else if (objeto1 is EstrellaBody) {
      objeto1.removeFromParent();
    }
    print(_player1.vidas);
    if(_player1.vidas==0){
      _player1.removeFromParent();
    }
  }

  void cargarVidasPlayer1(int vidasRestantes){

    double posicionX=10;
    for(int i=0;i< vidasRestantes;i++){
      Vidas vidasPlayer1=Vidas(position: Vector2(posicionX,10),size: Vector2(25, 25 ));
      add(vidasPlayer1);
      posicionX+=30;
    }
    for(int i=vidasRestantes;i<5;i++){
      VidasVacias vidasPlayer11=VidasVacias(position: Vector2(posicionX,10),size: Vector2(25, 25 ));
      add(vidasPlayer11);
      posicionX+=30;
    }
  }
}
