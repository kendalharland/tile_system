import "dart:html";

import 'package:tile_system/renderer/html.dart';
import 'package:tile_system/tile_system.dart';

void main() {
  const tileRadius = 50; // px;
  const rows = 9;
  const cols = 3;

  final canvas = querySelector("#canvas");
  final renderer = new HtmlPointRenderer(canvas);
  final squareFactory = new TileFactory.square(tileRadius);
  final hexFactory = new TileFactory.hexagon(tileRadius);

  for (int row = 0; row < rows ~/ 3; row++) {
    for (int col = 0; col < cols; col++) {
      renderer.renderAll(hexFactory.tile(row + 1, col + 1).corners);
    }
  }

  for (int row = 2 * rows ~/ 3; row < rows; row++) {
    for (int col = 0; col < cols; col++) {
      renderer.renderAll(squareFactory.tile(row + 1, col + 1).corners);
    }
  }
}
