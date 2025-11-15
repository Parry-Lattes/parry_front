import 'package:parry_front/core/lattes_entitys/production.dart';
import 'package:parry_front/controllers/controller_edit_list_text.dart';

class ControllerTableProduction {
  String autor = '';
  ControllerEditListText _edit_coautores = ControllerEditListText(list_text: List.empty());
  String title = '';
  String date_pub = '2006'; //valor padrao aqui pra nao gerar problemas de valor nulo
  TypeProduction type = TypeProduction.other;

  ControllerTableProduction([Production? p]) {
    if(p == null) {return;}

    production = p;
  }

  set production(Production p) {
    autor = p.autor;
    _edit_coautores = ControllerEditListText(list_text: p.coautores);
    title = p.title;
    date_pub = p.date_pub;
    type = p.type;
  }

  ControllerEditListText get controller_coautores => _edit_coautores;
}