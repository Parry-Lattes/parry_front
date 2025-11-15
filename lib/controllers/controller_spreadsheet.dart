import 'package:parry_front/core/lattes_entitys/curriculum.dart';
import 'package:parry_front/core/lattes_entitys/people.dart';
import 'package:parry_front/core/scrapper/extractor/extractor.dart';
import 'package:parry_front/core/scrapper/scrapper.dart';
import 'package:parry_front/controllers/controller_table_curriculum.dart';
import 'package:parry_front/controllers/controller_table_people.dart';

class ControllerSpreadsheet {
  late Extractor _extractor;
  final controller_people = ControllerTablePeople();
  final controller_curriculum = ControllerTableCurriculum();

  ControllerSpreadsheet(Extractor extractor) {
    _extractor = extractor;
  }

  Future<(Curriculum,People)> load_data() async {
    await Future.delayed(Duration(seconds: 2));
    final struct = _extractor.extract_data();

    final scrapper = Scrapper(struct);
    return scrapper.scrapping();
  }
}