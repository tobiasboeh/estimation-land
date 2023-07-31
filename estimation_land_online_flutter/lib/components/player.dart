import 'dart:async';

import 'package:estimation_land_online_flutter/components/collision_block.dart';
import 'package:estimation_land_online_flutter/components/util.dart';
import 'package:estimation_land_online_flutter/components/custom_hitbox.dart';
import 'package:estimation_land_online_flutter/estimation_land.dart';
import 'package:flame/collisions.dart';

import 'package:flame/components.dart';
import 'package:flutter/services.dart';

enum PlayerState { idle, running, jumping }

class Player extends SpriteAnimationGroupComponent
    with HasGameRef, KeyboardHandler {
  final String character;

  Player({postion, required this.character})
      : super(position: postion, scale: Vector2.all(1.0));

  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runningAnimation;
  late final SpriteAnimation jumpingAnimation;

  final double _gravity = 9.8;
  final double _jumpForce = 350;
  final double _terminalVelocity = 300;
  double horizontalMovement = 0;
  double moveSpeed = 200;
  Vector2 velocity = Vector2.zero();
  bool isOnGround = false;
  bool hasJumped = false;
  List<CollisionBlock> collisionBlocks = [];
  CustomHitbox hitbox = CustomHitbox(
    offsetX: 10,
    offsetY: 4,
    width: 14,
    height: 28,
  );

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    add(RectangleHitbox());

    return super.onLoad();
  }

  @override
  void update(double dt) {
    _updatePlayerState();
    _updatePlayerMovment(dt);
    _checkHorizontalCollisions();
    _applyGravity(dt);
    _checkVerticalCollisions();

    super.update(dt);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    horizontalMovement = 0;
    final isLeftKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyA) ||
        keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    final isRightKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyD) ||
        keysPressed.contains(LogicalKeyboardKey.arrowRight);
    final isJumpPressed = keysPressed.contains(LogicalKeyboardKey.space) ||
        keysPressed.contains(LogicalKeyboardKey.keyW) ||
        keysPressed.contains(LogicalKeyboardKey.arrowUp);

    horizontalMovement += isLeftKeyPressed ? -1 : 0;
    horizontalMovement += isRightKeyPressed ? 1 : 0;

    hasJumped = isJumpPressed;

    return false;
  }

  void _loadAllAnimations() {
    idleAnimation =
        _spriteAnimation('Idle', character.startsWith('TH_') ? 4 : 11);
    runningAnimation = _spriteAnimation('Run', 12);
    jumpingAnimation = _spriteAnimation('Jump', 1);

    // List of all animations
    animations = {
      PlayerState.idle: idleAnimation,
      PlayerState.running: runningAnimation,
      PlayerState.jumping: jumpingAnimation,
    };

    // Set current animation
    current = PlayerState.idle;
  }

  SpriteAnimation _spriteAnimation(String state, int amount) {
    final double stepTime = character.startsWith('TH_') ? 0.13 : 0.05;

    return SpriteAnimation.fromFrameData(
      game.images.fromCache('characters/$character/$state (32x32).png'),
      SpriteAnimationData.sequenced(
        amount: amount,
        stepTime: stepTime,
        textureSize: Vector2.all(32),
      ),
    );
  }

  void _updatePlayerMovment(double dt) {
    if (hasJumped && isOnGround) _playerJump(dt);

    velocity.x = horizontalMovement * moveSpeed;
    position.x += velocity.x * dt;
  }

  void _playerJump(double dt) {
    velocity.y = -_jumpForce;
    position.y += velocity.y * dt;
    isOnGround = false;
    hasJumped = false;
  }

  void _updatePlayerState() {
    PlayerState playerState = PlayerState.idle;

    if (velocity.x < 0 && scale.x > 0) {
      flipHorizontallyAroundCenter();
    } else if (velocity.x > 0 && scale.x < 0) {
      flipHorizontallyAroundCenter();
    }

    // Check if moving, set running
    if (velocity.x > 0 || velocity.x < 0) playerState = PlayerState.running;

    // Checks if jumping, set to jumping
    if (velocity.y < 0) playerState = PlayerState.jumping;

    current = playerState;
  }

  void _checkHorizontalCollisions() async {
    for (final block in collisionBlocks) {
      if (block.collisionType != CollisionBlockType.platform) {
        if (checkCollision(this, block)) {
          if (block.collisionType == CollisionBlockType.levelEnd) {
            (gameRef as EstimationLand).loadLevel('result');
          }
          if (velocity.x > 0) {
            velocity.x = 0;
            position.x = block.x - hitbox.offsetX - hitbox.width;
            break;
          }
          if (velocity.x < 0) {
            velocity.x = 0;
            position.x = block.x + block.width + hitbox.width + hitbox.offsetX;
            break;
          }
        }
      }
    }
  }

  void _applyGravity(double dt) {
    velocity.y += _gravity;
    velocity.y = velocity.y.clamp(-_jumpForce, _terminalVelocity);
    position.y += velocity.y * dt;
  }

  void _checkVerticalCollisions() {
    for (final block in collisionBlocks) {
      if (block.collisionType == CollisionBlockType.platform) {
        if (checkCollision(this, block)) {
          if (velocity.y > 0) {
            velocity.y = 0;
            position.y = block.y - hitbox.height - hitbox.offsetY;
            isOnGround = true;
            break;
          }
        }
      } else {
        if (checkCollision(this, block)) {
          if (velocity.y > 0) {
            velocity.y = 0;
            position.y = block.y - hitbox.height - hitbox.offsetY;
            isOnGround = true;
            break;
          }
          if (velocity.y < 0) {
            velocity.y = 0;
            position.y = block.y + block.height - hitbox.offsetY;
          }
        }
      }
    }
  }
}
