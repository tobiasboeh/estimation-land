import 'package:estimation_land_online_flutter/estimation_land.dart';
import 'package:flame/components.dart';
import 'package:flame/parallax.dart';

class ParallaxBackground extends ParallaxComponent<EstimationLand> {
  @override
  Future<void> onLoad() async {
    parallax = await gameRef.loadParallax(
      [
        ParallaxImageData('background/04_background.png'),
        ParallaxImageData('background/07_huge_clouds.png'),
        ParallaxImageData('background/08_clouds.png'),
        ParallaxImageData('background/09_distant_clouds.png'),
        ParallaxImageData('background/10_distant_clouds.png'),
      ],
      baseVelocity: Vector2(20, 0),
      velocityMultiplierDelta: Vector2(1.3, 1.0),
    );
  }
}
