import "dart:math";

import 'package:tile_system/src/tile/coordinates.dart';
import 'package:tile_system/tile_system.dart';

/// A Hexagon [TileFactory].
class HexTileFactory implements TileFactory {
  final Point<int> _origin;
  final num _tileRadius;
  final _Orientation _orientation;

  /// Creates a factory for [HexTile] oriented flat-side-up.
  HexTileFactory.flat(this._tileRadius, [this._origin = const Point(0, 0)])
      : _orientation = new _Orientation.flat();

  /// Creates a factory for [HexTile] oriented pointy-side-up.
  HexTileFactory.pointy(this._tileRadius, [this._origin = const Point(0, 0)])
      : _orientation = new _Orientation.pointy();

  @override
  HexTile tile(int offsetX, int offsetY) => new HexTile(
      _tileRadius, _origin, _orientation, new Point<int>(offsetX, offsetY));
}

/// A hexagon shaped [Tile].
class HexTile implements Tile {
  final int _radius;
  final Point<int> _origin;
  final Point<int> _offset;
  final _Orientation _orientation;

  HexTile(this._radius, this._origin, this._orientation, this._offset);

  @override
  Point<int> get center =>
      _origin + _orientation.hexToPixel(_offset.x, _offset.y, _radius);

  @override
  List<Point> get corners => new List.generate(
      6, (corner) => _origin + _orientation.corner(center, _radius, corner));

  @override
  Point<int> get offset {
    var hex = _orientation.pixelToHex(_offset.x, _offset.y, _radius);
    return _origin + new Point(hex.q, hex.r);
  }
}

/// A hexagonal orientation.
class _Orientation {
  final bool _pointy;

  /// Orients hexagons "pointy-side-up"
  _Orientation.pointy() : _pointy = true;

  /// Orients hexagons "flat-side-up"
  _Orientation.flat() : _pointy = false;

  /// Returns corner [i] of the hexagon with [center] and [radius].
  Point corner(Point center, num radius, int i) {
    var degrees = 60 * i + (_pointy ? 30 : 0);
    var radians = PI / 180 * degrees;
    return new Point(
      center.x + radius * cos(radians),
      center.y + radius * sin(radians),
    );
  }

  /// Converts the axial coordinates ([q], [r]) to pixel coordinates.
  Point hexToPixel(int q, int r, num radius) => _pointy
      ? new Point(
          radius * sqrt(3) * (q + r / 2),
          radius * 3 / 2 * r,
        )
      : new Point(
          radius * 3 / 2 * q,
          radius * sqrt(3) * (r + q / 2),
        );

  /// Converts the pixel coordinates ([x], [y]) to axial coordinates.
  Hex pixelToHex(int x, int y, num radius) => _pointy
      ? new Hex(
          ((x * sqrt(3) / 3 - y / 3) / radius).floor(),
          (y * 2 / 3 / radius).floor(),
        )
          .round()
      : new Hex(
          (x * 2 / 3 / radius).floor(),
          ((-x / 3 + sqrt(3) / 3 * y) / radius).floor(),
        )
          .round();
}
