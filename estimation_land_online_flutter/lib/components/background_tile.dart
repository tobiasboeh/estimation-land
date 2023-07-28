import 'dart:async';

import 'package:estimation_land_online_flutter/estimation_land.dart';
import 'package:flame/components.dart';

class BackgroundTile extends SpriteComponent with HasGameRef<EstimationLand> {
  final String color;
  BackgroundTile({
    this.color = 'Gray',
    position,
  }) : super(
          position: position,
        );

  final double scrollSpeed = 0.4;

  @override
  FutureOr<void> onLoad() {
    priority = -1;
    size = Vector2.all(64.6);
    sprite = Sprite(game.images.fromCache('background/$color.png'));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    position.y += scrollSpeed;
    double tileSize = 64;
    int scrollheight = (game.size.y / tileSize).floor();
    if (position.y > scrollheight * tileSize) position.y = -tileSize;
    super.update(dt);
  }
}
