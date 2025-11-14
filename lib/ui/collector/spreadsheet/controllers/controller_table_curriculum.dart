

import 'package:parry_front/core/lattes_entitys/curriculum.dart';
import 'package:parry_front/ui/collector/spreadsheet/controllers/controller_table_production.dart';

class ControllerTableCurriculum {
  int id_lattes = 0;
  String last_update = '';
  List<ControllerTableProduction> productions = List.empty(growable: true);

  ControllerTableCurriculum([Curriculum? c]) {
    if(c == null) {
      return;
    }

    curriculum = c;
  }

  set curriculum(Curriculum c) {
    id_lattes = c.id_lattes;
    last_update = c.last_update;

    for(final product in c.productions) {
      productions.add(ControllerTableProduction(product));
    }
  }
}