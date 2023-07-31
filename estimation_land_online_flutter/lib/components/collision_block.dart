import 'package:flame/components.dart';

enum CollisionBlockType {
  block,
  platform,
  levelEnd,
}

class CollisionBlock extends PositionComponent {
  CollisionBlockType collisionType;
  CollisionBlock({
    position,
    size,
    this.collisionType = CollisionBlockType.block,
  }) : super(
          position: position,
          size: size,
        ) {
    // debugMode = true;
  }
}
