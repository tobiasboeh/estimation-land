import 'package:estimation_land_online_flutter/estimation_land.dart';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();
  EstimationLand game = EstimationLand();

  runApp(
    GameWidget(
      game: kDebugMode ? EstimationLand() : game,
    ),
  );
}
