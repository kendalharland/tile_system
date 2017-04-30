import 'dart:html';
import 'dart:math';
import 'dart:svg' hide Point;

import 'package:tile_system/src/point_renderer.dart';

class HtmlPointRenderer implements PointRenderer {
  final Element _canvas;

  HtmlPointRenderer(this._canvas);

  @override
  void render(Point<int> point) {
    throw new UnimplementedError();
  }

  @override
  void renderAll(List<Point<int>> corners) {
    _canvas.append(new GElement()..append(_gCorners(corners)));
  }

  PathElement _gCorners(List<Point> corners) {
    var c = corners,
        d = c.fold("M${c.last.x} ${c.last.y}",
            (prev, next) => prev + " L${next.x} ${next.y}"),
        p = new PathElement()
          ..setAttribute("class", "tileoutline")
          ..setAttribute("d", d)
          ..setAttribute("fill", "LightGray")
          ..setAttribute("stroke", "Gray");
    return p;
  }
}
