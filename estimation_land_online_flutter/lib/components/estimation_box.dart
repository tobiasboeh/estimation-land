import 'dart:async';

import 'package:estimation_land_online_flutter/components/player.dart';
import 'package:estimation_land_online_flutter/components/flame_sprite.dart';
import 'package:estimation_land_online_flutter/components/level.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle textStyle = GoogleFonts.pressStart2p(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    color: const Color.fromARGB(255, 72, 51, 34),
    shadows: [
      const Shadow(
          blurRadius: 1.0,
          color: Color.fromARGB(255, 160, 172, 122),
          offset: Offset(1.0, 1.0)),
    ]);
TextPaint textPaint = TextPaint(style: textStyle);

class EstimationBox extends PositionComponent with CollisionCallbacks {
  EstimationBox({
    position,
    required this.text,
  }) : super(
          position: Vector2(position.x, position.y - 32),
          size: Vector2(32, 64),
        ) {
    // debugMode = true;
  }
  final String text;
  late final FlameSprite flameSprite;
  bool isFlameOn = false;
  @override
  FutureOr<void> onLoad() async {
    TextBoxComponent textBox = TextBoxComponent(
      position: Vector2(1, 32),
      size: Vector2.all(32),
      text: text,
      textRenderer: textPaint,
    );
    await add(textBox);

    flameSprite = FlameSprite(position: Vector2(0, -3), size: Vector2.all(32));

    add(RectangleHitbox());

    return super.onLoad();
  }

  void flameOn() {
    if (!isFlameOn) {
      add(flameSprite);
      isFlameOn = true;
      _deactivateOtherFlames();
    }
  }

  void flameOff() {
    if (isFlameOn) {
      flameSprite.removeFromParent();
      isFlameOn = false;
    }
  }

  void _deactivateOtherFlames() {
    for (final box in (parent as Level).estimationBoxes) {
      if (box != this) {
        box.flameOff();
      }
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      flameOn();
    }
    super.onCollision(intersectionPoints, other);
  }
}
