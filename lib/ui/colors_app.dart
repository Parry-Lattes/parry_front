import 'dart:ui';

enum ColorsApp {

  red(r: 240, g: 41, b: 88, o: 1),
  white(r: 245, g: 245,b: 245, o: 1),
  black(r: 39, g: 29, b: 44, o: 1),
  black_transparent(r: 39, g: 29, b: 44, o: 0.5),
  grey1(r: 49, g: 53, b: 56, o: 1),
  grey2(r: 58, g: 59, b: 63, o: 1),
  brown1(r: 123,g: 105,b: 96,o: 1),
  brown2(r: 181, g: 169, b: 162, o: 1);

  const ColorsApp(
    {
      required this.r,
      required this.g,
      required this.b,
      required this.o
    }
  );

  final int r;
  final int g;
  final int b;
  final double o;

  Color get color {
    return Color.fromRGBO(r,g,b,o);
  }

}