import 'dart:html';
import 'dart:math';
import 'dart:svg' hide Point;

import 'package:tile_system/src/point_renderer.dart';

class HtmlPointRenderer implements PointRenderer {
  final Element _canvas;

  HtmlPointRenderer(this._canvas);

  @override
  void render(Point point) {
    throw new UnimplementedError();
  }

  @override
  void renderAll(List<Point> corners) {
    _canvas.append(new GElement()..append(_gCorners(corners)));
  }

  PathElement _gCorners(List<Point> corners) {
    var outline = corners.fold("M${corners.last.x} ${corners.last.y}",
            (prev, next) => prev + " L${next.x} ${next.y}"),
        p = new PathElement()
          ..setAttribute("class", "tileoutline")
          ..setAttribute("d", outline)
          ..setAttribute("fill", "LightGray")
          ..setAttribute("stroke", "Gray")
          ..setAttribute("stroke-width ", "1")
          ..setAttribute("stroke-linecap", "round");
    return p;
  }
}
