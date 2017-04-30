import 'package:meta/meta.dart';

class Cube {
  final int x;
  final int y;
  final int z;

  @literal
  const Cube(this.x, this.y, this.z);

  double distance(Cube other) =>
      ((x - other.x).abs() + (y - other.y).abs() + (z - other.z).abs()) / 2;

  Hex toHex() => new Hex(x, z);

  Cube round() {
    var rx = x.floor();
    var ry = y.floor();
    var rz = z.floor();

    var xDiff = (rx - x).abs();
    var yDiff = (ry - y).abs();
    var zDiff = (rz - z).abs();

    if (xDiff > yDiff && xDiff > zDiff) {
      rx = -ry - rz;
    } else if (yDiff > zDiff) {
      ry = -rx - rz;
    } else {
      rz = -rx - ry;
    }

    return new Cube(rx, ry, rz);
  }
}

class Hex {
  final int q;
  final int r;

  @literal
  const Hex(this.q, this.r);

  double distance(Hex other) => toCube().distance(other.toCube());

  Cube toCube() => new Cube(q, q + r, r);

  Hex round() => toCube().round().toHex();
}
