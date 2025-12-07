import 'package:flutter/material.dart';
import 'package:parry_front/core/exceptions/data_not_load.dart';
import 'package:parry_front/core/lattes_entitys/curriculum.dart';
import 'package:parry_front/controllers/controller_spreadsheet/controller_table_production.dart';
import 'package:parry_front/core/lattes_entitys/production.dart';

/*
 Controller da tabela de currículo
 Possui um controller para o editor de texto do id_lattes,
 seu campo last_update será diretamente utilizado pelo seletor de data da tabela
 Também possui uma lista de controllers para produções. Ou seja, ele também possui o controller
 de cada uma das tabelas de produção
 */
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

  /*
   Assim como no caso de ControllerSpreadsheet, temos uma função que retorna
   um objeto de currículo que representa o estado atual da tabela.
   */
  Curriculum get curriculum {
    try {
      final list_productions = List<Production>.empty(growable: true);
      final int_id_lattes = int.parse(id_lattes.text);

      for(final p in productions) {
        list_productions.add(p.production);
      }

      return Curriculum(int_id_lattes, last_update, list_productions);
    } on Exception {
      throw DataNotLoad();
    }
  }

  //Atualiza os dados da tabela, ou seja, do controller, com base em um outro currículo informado
  set curriculum(Curriculum c) {
    id_lattes = TextEditingController(text: '${c.id_lattes}');
    last_update = c.last_update;

    for(final product in c.productions) {
      productions.add(ControllerTableProduction(product));
    }
  }
}