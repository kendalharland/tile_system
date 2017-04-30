import "dart:html";

import 'package:tile_system/renderer/html.dart';
import 'package:tile_system/tile_system.dart';

void main() {
  const tileRadius = 10; // px;
  const rows = 9;
  const cols = 3;

  final canvas = querySelector("#canvas");
  final renderer = new HtmlPointRenderer(canvas);
  final squareFactory = new TileFactory.square(tileRadius);
  final hexFactory = new TileFactory.hex(tileRadius);

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

  querySelectorAll(".tileoutline")
    ..onMouseOver.listen((MouseEvent e) {
      var t = e.target as Element;
      t.setAttribute("fill", "Orange");
    })
    ..onMouseOut.listen((MouseEvent e) {
      var t = e.target as Element;
      t.setAttribute("fill", "LightGray");
    });
}
