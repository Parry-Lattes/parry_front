import 'package:parry_front/core/lattes_entitys/curriculum.dart';
import 'package:parry_front/core/scrapper/extractor/extractor.dart';

class Scrapper {
  Extractor extractor = Extractor();

  Curriculum scrapping(Object path) {
    extractor.load(path);
    final struct = extractor.extract_data();

    return Curriculum(123, 'last_update', []);
  }
}