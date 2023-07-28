import 'package:estimation_land_online_flutter/components/player.dart';
import 'package:estimation_land_online_flutter/components/background_parallax.dart';
import 'package:estimation_land_online_flutter/components/level.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

const String pmFrog = 'Ninja Frog';
const String pmMask = 'Mask Dude';
const String pmMan = 'Pink Man';
const String pmPink = 'TH_Pink Monster';
const String pmDude = 'TH_Dude Monster';
const String pmOwlet = 'TH_Owlet Monster';

class EstimationLand extends FlameGame
    with HasKeyboardHandlerComponents, DragCallbacks, HasCollisionDetection {
  late final CameraComponent cam;
  late final ParallaxBackground bg;
  Player player = Player(character: pmMask);
  late JoystickComponent joystick;
  bool showJoystick = false;

  @override
  Color backgroundColor() => const Color.fromARGB(255, 185, 210, 234);

  @override
  Future<void> onLoad() async {
    // Load all images into cache
    await images.loadAllImages();
    debugColor = Colors.red;
    final world = Level(
      player: player,
      levelName: 'result',
    );

    const width = 640.0;
    cam = CameraComponent.withFixedResolution(
        world: world, width: width, height: 320);

    cam.follow(player, snap: true, horizontalOnly: true);
    cam.setBounds(Rectangle.fromLTRB(width / 2, 160, 1920 - width / 2, 320));
    final fps = FpsTextComponent(position: Vector2(10, 10));

    bg = ParallaxBackground();
    addAll([bg, cam, world, fps]);

    if (showJoystick) {
      addJoystick();
    }
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (showJoystick) {
      updateJoystick();
    }

    super.update(dt);
  }

  void addJoystick() {
    joystick = JoystickComponent(
      knob: SpriteComponent(
        sprite: Sprite(
          images.fromCache('Knob.png'),
        ),
      ),
      background: SpriteComponent(
        sprite: Sprite(
          images.fromCache('Joystick.png'),
        ),
      ),
      margin: const EdgeInsets.only(left: 32, bottom: 32),
    );

    add(joystick);
  }

  void updateJoystick() {
    switch (joystick.direction) {
      case JoystickDirection.left:
      case JoystickDirection.upLeft:
      case JoystickDirection.downLeft:
        player.horizontalMovement = -1;
        break;
      case JoystickDirection.right:
      case JoystickDirection.upRight:
      case JoystickDirection.downRight:
        player.horizontalMovement = 1;
        break;
      default:
        player.horizontalMovement = 0;
        break;
    }
  }
}
