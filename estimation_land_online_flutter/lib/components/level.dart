import 'package:estimation_land_online_flutter/components/player.dart';

import 'package:estimation_land_online_flutter/components/collision_block.dart';
import 'package:estimation_land_online_flutter/components/estimation_box.dart';
import 'package:estimation_land_online_flutter/estimation_land.dart';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Level extends World with HasGameRef<EstimationLand> {
  final String levelName;
  final Player player;
  Level({required this.levelName, required this.player});
  late TiledComponent level;
  List<CollisionBlock> collisionBlocks = [];
  List<EstimationBox> estimationBoxes = [];

  @override
  Future<void> onLoad() async {
    level = await TiledComponent.load('$levelName.tmx', Vector2.all(32));

    // _parallaxBackground();
    add(level);
    // _scrollingBackground();
    _spawningObjects();
    _addText();
    _addCollisions();
  }

  void _spawningObjects() {
    final spawnPointsLayer = level.tileMap.getLayer<ObjectGroup>('Spawnpoints');

    if (spawnPointsLayer != null) {
      for (final spawnPoint in spawnPointsLayer.objects) {
        switch (spawnPoint.class_) {
          case 'Player':
            player.position = Vector2(spawnPoint.x, spawnPoint.y);
            add(player);
            break;
          default:
        }
      }
    }
  }

  void _addText() {
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

    final estimationPointsLayer =
        level.tileMap.getLayer<ObjectGroup>('Estimations');

    if (estimationPointsLayer != null) {
      for (final spawnPoint in estimationPointsLayer.objects) {
        switch (spawnPoint.class_) {
          case 'Estimation':
            final box = EstimationBox(
                text: spawnPoint.name,
                position: Vector2(spawnPoint.x, spawnPoint.y));
            estimationBoxes.add(box);
            add(box);

            break;

          case 'Subject':
            TextBoxComponent textBox = TextBoxComponent(
                position: Vector2(
                  spawnPoint.x,
                  spawnPoint.y,
                ),
                size: Vector2(
                  spawnPoint.width,
                  spawnPoint.height,
                ),
                text: 'Estimate the effort of the story...',
                textRenderer: textPaint);
            add(textBox);
            break;
          default:
        }
      }
    }
  }

  void _addCollisions() {
    final collisionsLayer = level.tileMap.getLayer<ObjectGroup>('Collisions');

    if (collisionsLayer != null) {
      for (final collision in collisionsLayer.objects) {
        switch (collision.class_) {
          case 'Platform':
            final platform = CollisionBlock(
              position: Vector2(collision.x, collision.y),
              size: Vector2(collision.width, collision.height),
              isPlatform: true,
            );
            collisionBlocks.add(platform);
            add(platform);
            break;
          default:
            final block = CollisionBlock(
              position: Vector2(collision.x, collision.y),
              size: Vector2(collision.width, collision.height),
            );
            collisionBlocks.add(block);
            add(block);
        }
      }
    }
    player.collisionBlocks = collisionBlocks;
  }

  // void _scrollingBackground() {
  //   final backgroundLayer = level.tileMap.getLayer('Background');
  //   const tileSize = 64;

  //   final numTilesY = (game.size.y / tileSize).floor();
  //   final numTilesX = (level.width / tileSize).floor();

  //   if (backgroundLayer != null) {
  //     final backgroundColor =
  //         backgroundLayer.properties.getValue('BackgroundColor');

  //     for (double y = 0; y < game.size.x / numTilesY; y++) {
  //       for (double x = 0; x < numTilesX; x++) {
  //         final backgroundTile = BackgroundTile(
  //           color: backgroundColor ?? 'Gray',
  //           position: Vector2(x * tileSize, y * tileSize - tileSize),
  //         );

  //         add(backgroundTile);
  //       }
  //     }
  //   }
  // }
}
