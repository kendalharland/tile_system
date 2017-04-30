import 'dart:math';

abstract class PointRenderer {
  /// Renders [point].
  void render(Point<int> point);

  /// Successively renders each point in [points]
  void renderAll(List<Point<int>> points);
}
