import 'dart:math';

import 'package:tile_system/tile_system.dart';

/// A [TileFactory] for [SquareTile].
class SquareTileFactory implements TileFactory {
  final Point<int> _origin;
  final num _tileRadius;

  SquareTileFactory(this._tileRadius, [this._origin = const Point(0, 0)]);

  @override
  SquareTile tile(int offsetX, int offsetY) =>
      new SquareTile(_tileRadius, _origin, new Point<int>(offsetX, offsetY));
}

/// A square shaped [Tile].
class SquareTile implements Tile {
  final int _radius;
  final Point<int> _origin;
  final Point<int> _offset;

  SquareTile(this._radius, this._origin, this._offset);

  @override
  Point<int> get center {
    var radiusProduct = _radius * sqrt(2);
    return _origin +
        new Point<int>(
          (radiusProduct * _offset.x).ceil(),
          (radiusProduct * _offset.y).ceil(),
        );
  }

  @override
  List<Point<int>> get corners {
    var _center = center;
    var radiusQuotient = _radius / sqrt(2);
    return [
      new Point(
        (_center.x + radiusQuotient).ceil(),
        (_center.y - radiusQuotient).ceil(),
      ),
      new Point(
        (_center.x + radiusQuotient).ceil(),
        (_center.y + radiusQuotient).ceil(),
      ),
      new Point(
        (_center.x - radiusQuotient).ceil(),
        (_center.y + radiusQuotient).ceil(),
      ),
      new Point(
        (_center.x - radiusQuotient).ceil(),
        (_center.y - radiusQuotient).ceil(),
      ),
    ].toList();
  }

  @override
  Point<int> get offset => new Point<int>(
      ((_offset.x - _origin.x) / _radius).ceil(),
      ((_offset.y - _origin.y) / _radius).ceil());
}
