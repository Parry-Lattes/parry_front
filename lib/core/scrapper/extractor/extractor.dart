//this is a intarface, not a class
//Dart do it
import 'package:parry_front/core/scrapper/struct_lattes/struct_lattes.dart';

abstract class Extractor {
  Future load(Object o);
  StructLattes extract_data();
}