import 'dart:math';

import 'package:tile_system/src/tile/hex_tile.dart';
import 'package:tile_system/src/tile/square_tile.dart';

/// A factory that partitions a 2D space into a set of polygons called tiles.
abstract class TileFactory {
  /// Creates a [TileFactory] for [SquareTile].
  factory TileFactory.square(num tileRadius) = SquareTileFactory;

  /// Creates a [TileFactory] for [HexTile].
  factory TileFactory.hexagon(num tileRadius, {bool flat: false}) => flat
      ? new HexagonTileFactory.flat(tileRadius)
      : new HexagonTileFactory.pointy(tileRadius);

  /// Returns the [Tile] at the relative position [offsetX], [offsetY].
  Tile tile(int offsetX, int offsetY);
}

/// A 2D polygon.
///
/// A tile has both an offset and a pixel position. A tile's offset refers to
/// its position relative to other tiles. A tile's pixel position refers to the
/// position of any of the pixels that intersect the tile.
abstract class Tile {
  /// The pixel center of this [Tile].
  Point<double> get center;

  /// The pixel corner points of this [Tile].
  List<Point<double>> get corners;

  /// The relative position of this [Tile].
  Point<int> get offset;
}
