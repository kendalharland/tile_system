import 'dart:math';

import 'package:tile_system/src/tile/coordinates.dart';
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
  final Point<double> _origin;
  final Point<int> _offset;

  SquareTile(this._radius, Point<int> origin, this._offset)
      : _origin = new Point<double>(origin.x.toDouble(), origin.y.toDouble());

  @override
  Point<double> get center {
    var radiusProduct = _radius * sqrt(2);
    return _origin +
        new Point<double>(
          round(radiusProduct * _offset.x),
          round(radiusProduct * _offset.y),
        );
  }

  @override
  List<Point<double>> get corners {
    var _center = center;
    var radiusQuotient = _radius / sqrt(2);
    return <Point<double>>[
      new Point<double>(
        round(_center.x + radiusQuotient),
        round(_center.y - radiusQuotient),
      ),
      new Point<double>(
        round(_center.x + radiusQuotient),
        round(_center.y + radiusQuotient),
      ),
      new Point<double>(
        round(_center.x - radiusQuotient),
        round(_center.y + radiusQuotient),
      ),
      new Point<double>(
        round(_center.x - radiusQuotient),
        round(_center.y - radiusQuotient),
      ),
    ].toList();
  }

  @override
  Point<int> get offset => new Point<int>(
      ((_offset.x - _origin.x) / _radius).round(),
      ((_offset.y - _origin.y) / _radius).round());
}
