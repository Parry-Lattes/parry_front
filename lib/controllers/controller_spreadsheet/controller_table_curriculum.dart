import 'package:flutter/material.dart';
import 'package:parry_front/core/lattes_entitys/curriculum.dart';
import 'package:parry_front/controllers/controller_spreadsheet/controller_table_production.dart';
import 'package:parry_front/core/lattes_entitys/production.dart';

class ControllerTableCurriculum {
  TextEditingController id_lattes = TextEditingController(text: '');
  String last_update = '';
  List<ControllerTableProduction> productions = List.empty(growable: true);

  ControllerTableCurriculum([Curriculum? c]) {
    if(c == null) {
      return;
    }

    curriculum = c;
  }

  Curriculum get curriculum {
    final list_productions = List<Production>.empty(growable: true);
    final int_id_lattes = int.tryParse(id_lattes.text)!;

    for(final p in productions) {
      list_productions.add(p.production);
    }

    return Curriculum(int_id_lattes, last_update, list_productions);
  }

  set curriculum(Curriculum c) {
    id_lattes = TextEditingController(text: '${c.id_lattes}');
    last_update = c.last_update;

    for(final product in c.productions) {
      productions.add(ControllerTableProduction(product));
    }
  }
}