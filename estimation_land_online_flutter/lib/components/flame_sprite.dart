import 'dart:async';

import 'package:estimation_land_online_flutter/estimation_land.dart';
import 'package:flame/components.dart';

class FlameSprite extends SpriteAnimationComponent
    with HasGameRef<EstimationLand> {
  FlameSprite({
    position,
    size,
  }) : super(
          position: position,
          size: size,
        ) {
    // debugMode = true;
  }

  @override
  FutureOr<void> onLoad() {
    final spriteAnimation = SpriteAnimation.fromFrameData(
      game.images.fromCache('flame.png'),
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.1,
        textureSize: Vector2.all(32),
      ),
    );
    animation = spriteAnimation;
    return super.onLoad();
  }
}
