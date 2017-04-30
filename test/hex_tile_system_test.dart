import 'dart:math';

import 'package:test/test.dart';
import 'package:tile_system/src/tile/coordinates.dart';
import 'package:tile_system/tile_system.dart';

void main() {
  [1, 2, 3, 17, 100, 100].forEach(testHexTile);
}

void testHexTile(int tileRadius) {
  group('$HexTile with radius $tileRadius', () {
    const tileRadius = 13;
    TileFactory tileFactory;

    /// Computes the adjacent side of the 30-60-90 right triangle with
    /// [hypotenuse].
    double adjacentSide(int hypotenuse) => hypotenuse / 2 * sqrt(3);

    /// Computes the opposite side of the 30-60-90 right triangle with
    /// [hypotenuse].
    double oppositeSide(int hypotenuse) => hypotenuse / 2;

    group('center should return the pixel center', () {
      test('for flat orientation', () {
        tileFactory = new TileFactory.hexagon(tileRadius, flat: true);
        final adjacent = adjacentSide(tileRadius);

        // Top neighbor
        expect(tileFactory.tile(0, -1).center,
            new Point<double>(0.0, round(-2 * adjacent)));
        // Top right neighbor
        expect(tileFactory.tile(1, -1).center,
            new Point<double>(round(1.5 * tileRadius), round(-adjacent)));
        // Bottom right neighbor
        expect(tileFactory.tile(1, 0).center,
            new Point<double>(round(1.5 * tileRadius), round(adjacent)));
        // Bottom neighbor
        expect(tileFactory.tile(0, 1).center,
            new Point<double>(0.0, round(2 * adjacent)));
        // Bottom left neighbor
        expect(tileFactory.tile(-1, 1).center,
            new Point<double>(round(-1.5 * tileRadius), round(adjacent)));
        // Top left neighbor
        expect(tileFactory.tile(-1, 0).center,
            new Point<double>(round(-1.5 * tileRadius), round(-adjacent)));
      });
      test('for pointy orientation', () {
        tileFactory = new TileFactory.hexagon(tileRadius, flat: false);
        final adjacent = adjacentSide(tileRadius);

        // Right neighbor
        expect(tileFactory.tile(1, 0).center,
            new Point<double>(round(2 * adjacent), 0.0));
        // Bottom right neighbor
        expect(tileFactory.tile(0, 1).center,
            new Point<double>(round(adjacent), round(1.5 * tileRadius)));
        // Bottom left neighbor
        expect(tileFactory.tile(-1, 1).center,
            new Point<double>(round(-adjacent), round(1.5 * tileRadius)));
        // Left neighbor
        expect(tileFactory.tile(-1, 0).center,
            new Point<double>(round(-2 * adjacent), 0.0));
        // Top left neighbor
        expect(tileFactory.tile(0, -1).center,
            new Point<double>(round(-adjacent), round(-1.5 * tileRadius)));
        // Top right neighbor
        expect(tileFactory.tile(1, -1).center,
            new Point<double>(round(adjacent), round(-1.5 * tileRadius)));
      });
    });

    group('corners should return the pixel corners', () {
      test('for pointy orientation', () {
        tileFactory = new TileFactory.hexagon(tileRadius, flat: false);
        final dx = round(adjacentSide(tileRadius));
        final dy = round(oppositeSide(tileRadius));
        expect(
            tileFactory.tile(0, 0).corners,
            orderedEquals([
              new Point(dx, dy), // Bottom right
              new Point(0, tileRadius), // Bottom
              new Point(-dx, dy), // Bottom Left
              new Point(-dx, -dy), // Top left
              new Point(0, -tileRadius), // Top
              new Point(dx, -dy), // Top Right
            ]));
      });
      test('for flat orientation', () {
        tileFactory = new TileFactory.hexagon(tileRadius, flat: true);
        final dx = round(oppositeSide(tileRadius));
        final dy = round(adjacentSide(tileRadius));
        expect(
            tileFactory.tile(0, 0).corners,
            orderedEquals([
              new Point(tileRadius, 0), // Right
              new Point(dx, dy), // Bottom right
              new Point(-dx, dy), // Bottom left
              new Point(-tileRadius, 0), // Left
              new Point(-dx, -dy), // Top left
              new Point(dx, -dy), // Top right
            ]));
      });
    });

    group('offset should return the relative position', () {
      [true, false].forEach((isFlat) {
        final orientation = isFlat ? 'flat' : 'pointy';
        test('when $orientation', () {
          tileFactory = new TileFactory.hexagon(tileRadius, flat: isFlat);
          expect(tileFactory.tile(0, -1).offset, new Point<int>(0, -1));
          expect(tileFactory.tile(-1, 0).offset, new Point<int>(-1, 0));
          expect(tileFactory.tile(-1, 1).offset, new Point<int>(-1, 1));
          expect(tileFactory.tile(0, 1).offset, new Point<int>(0, 1));
          expect(tileFactory.tile(1, 0).offset, new Point<int>(1, 0));
          expect(tileFactory.tile(1, -1).offset, new Point<int>(1, -1));
        });
      });
    });
  });
}
