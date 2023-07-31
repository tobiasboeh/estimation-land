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
const width = 640.0;
const height = 320.0;

class EstimationLand extends FlameGame
    with HasKeyboardHandlerComponents, DragCallbacks, HasCollisionDetection {
  late CameraComponent cam;
  late ParallaxBackground bg;
  late Level world;
  late FpsTextComponent fps;
  late Player player;
  late JoystickComponent joystick;
  bool showJoystick = false;
  bool levelLoaded = false;

  @override
  Color backgroundColor() => const Color.fromARGB(255, 185, 210, 234);

  @override
  Future<void> onLoad() async {
    // Load all images into cache
    await images.loadAllImages();
    debugColor = Colors.red;

    loadLevel('level2');

    if (showJoystick) {
      addJoystick();
    }
    return super.onLoad();
  }

  loadLevel(String levelName) async {
    if (levelLoaded) {
      unload();
    }
    player = Player(character: pmMask);
    world = Level(
      player: player,
      levelName: levelName,
    );
    await add(world);
    cam = CameraComponent.withFixedResolution(
        world: world, width: width, height: height);
    cam.follow(player, snap: false, horizontalOnly: false);
    cam.setBounds(
      Rectangle.fromLTRB(width / 2, height / 2, world.level.width - width / 2,
          world.level.height - height / 2),
    );
    fps = FpsTextComponent(position: Vector2(10, 10));

    bg = ParallaxBackground();
    addAll([bg, cam, fps]);
    levelLoaded = true;
  }

  unload() {
    if (cam.isMounted) {
      cam.removeFromParent();
    }
    if (bg.isMounted) {
      bg.removeFromParent();
    }
    if (world.isMounted) {
      world.removeFromParent();
    }
    if (fps.isMounted) {
      fps.removeFromParent();
    }
    if (player.isMounted) {
      player.removeFromParent();
    }
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
