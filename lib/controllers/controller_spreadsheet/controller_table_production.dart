import 'package:flutter/material.dart';
import 'package:parry_front/core/lattes_entitys/production.dart';
import 'package:parry_front/controllers/controller_spreadsheet/controller_edit_list_text.dart';

class ControllerTableProduction {
  TextEditingController autor = TextEditingController(text: '');
  ControllerEditListText _edit_coautores = ControllerEditListText(list_text: List.empty(growable: true));
  TextEditingController title = TextEditingController(text: '');
  String date_pub = '2006'; //valor padrao aqui pra nao gerar problemas de valor nulo
  TypeProduction type = TypeProduction.other;
  String hash = '';

  ControllerTableProduction([Production? p]) {
    if(p == null) {return;}

    production = p;
  }

  Production get production {
    return Production(autor.text, _edit_coautores.list_text, title.text, date_pub, type, hash);
  }

  set production(Production p) {
    autor = TextEditingController(text: p.autor);
    _edit_coautores = ControllerEditListText(list_text: p.coautores);
    title = TextEditingController(text: p.title);
    date_pub = p.date_pub;
    type = p.type;
    hash = p.hash;
  }

  ControllerEditListText get controller_coautores => _edit_coautores;
}