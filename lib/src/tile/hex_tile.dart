import "dart:math";

import 'package:tile_system/src/tile/coordinates.dart';
import 'package:tile_system/tile_system.dart';

/// A Hexagon [TileFactory].
class HexagonTileFactory implements TileFactory {
  final Point<int> _origin;
  final num _tileRadius;
  final _Orientation _orientation;

  /// Creates a factory for [HexTile] oriented flat-side-up.
  HexagonTileFactory.flat(this._tileRadius,
      [this._origin = const Point<int>(0, 0)])
      : _orientation = new _Orientation.flat();

  /// Creates a factory for [HexTile] oriented pointy-side-up.
  HexagonTileFactory.pointy(this._tileRadius,
      [this._origin = const Point<int>(0, 0)])
      : _orientation = new _Orientation.pointy();

  @override
  HexTile tile(int offsetX, int offsetY) => new HexTile(
      _tileRadius, _origin, _orientation, new Point<int>(offsetX, offsetY));
}

/// A hexagon shaped [Tile].
class HexTile implements Tile {
  final int _radius;
  final Point<double> _origin;
  final Hex _axial;
  final _Orientation _orientation;

  HexTile(this._radius, Point<int> origin, this._orientation, Point<int> offset)
      : _axial = new Hex(origin.x + offset.x, origin.y + offset.y),
        _origin = new Point<double>(origin.x.toDouble(), origin.y.toDouble());

  @override
  Point<double> get center =>
      _origin + _orientation.hexToPixel(_axial.q, _axial.r, _radius);

  @override
  List<Point<double>> get corners => new List.generate(
      6, (corner) => _origin + _orientation.corner(center, _radius, corner));

  @override
  Point<int> get offset => new Point<int>(_axial.q, _axial.r);
}

/// A hexagonal orientation.
class _Orientation {
  final bool _pointy;

  /// Orients hexagons "pointy-side-up".
  _Orientation.pointy() : _pointy = true;

  /// Orients hexagons "flat-side-up".
  _Orientation.flat() : _pointy = false;

  /// Returns corner [i] of the hexagon with [center] and [radius].
  Point<double> corner(Point<double> center, num radius, int i) {
    var degrees = 60 * i + (_pointy ? 30 : 0);
    var radians = (PI / 180) * degrees;
    return new Point<double>(
      round(center.x + radius * cos(radians)),
      round(center.y + radius * sin(radians)),
    );
  }

  /// Converts the axial coordinates [q] and [r] to pixel coordinates.
  Point<double> hexToPixel(int q, int r, num radius) => _pointy
      ? new Point<double>(
          round((radius * sqrt(3) * (q + r / 2))),
          round((radius * 3 / 2 * r)),
        )
      : new Point<double>(
          round((radius * 3 / 2 * q)),
          round((radius * sqrt(3) * (r + q / 2))),
        );

  /// Converts the pixel coordinates [x] and [y] to axial coordinates.
  Hex pixelToHex(int x, int y, num radius) => _pointy
      ? new Hex(
          ((x * sqrt(3) / 3 - y / 3) / radius).round(),
          (y * 2 / 3 / radius).round(),
        )
      : new Hex(
          (x * 2 / 3 / radius).round(),
          ((-x / 3 + sqrt(3) / 3 * y) / radius).round(),
        );
}
