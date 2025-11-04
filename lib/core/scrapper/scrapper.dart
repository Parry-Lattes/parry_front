import 'package:parry_front/core/scrapper/extractor/extractor.dart';

class Scrapper {
  Extractor extractor = Extractor();

  void scrapping(Object path) {
    extractor.load(path);
  }
}