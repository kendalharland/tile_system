import 'dart:math';

import 'package:tile_system/src/computer/hex_tile.dart';
import 'package:tile_system/src/computer/square_tile.dart';

/// A system that partitions a 2D space into a set of polygons.
///
/// Polygons have both an offset and a pixel position. A polygon's offset refers
/// to its position relative to other polygons. A polygon's pixel position
/// refers to the position of any of the pixels that intersect the polygon.
abstract class TileFactory {
  /// Creates a [TileFactory] made of squares.
  factory TileFactory.square(num tileRadius) = SquareTileFactory;

  /// Creates a [TileFactory] made of hexagons.
  factory TileFactory.hex(num tileRadius, {bool flat: false}) => flat
      ? new HexTileFactory.flat(tileRadius)
      : new HexTileFactory.pointy(tileRadius);

  /// Returns the [Tile] at relative the position ([offsetX], [offsetY]).
  Tile tile(int offsetX, int offsetY);
}

/// A 2D polygon.
abstract class Tile {
  /// The pixel center of this [Tile].
  Point<int> get center;

  /// The pixel corner points of this [Tile].
  List<Point> get corners;

  /// The relative position of this [Tile].
  Point<int> get offset;
}
