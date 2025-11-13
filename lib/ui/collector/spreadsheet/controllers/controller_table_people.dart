import 'package:parry_front/core/lattes_entitys/people.dart';
import 'package:parry_front/ui/collector/spreadsheet/controllers/controller_edit_list_text.dart';

class ControllerTablePeople {
  //este controller possui outro controller, porque a edicao da lista de abreviacoes vem de outro widget
  //e, durante a criacao do widget EditListText, o controller de TablePessoa vai pedir ao proprio controller pelo
  //controller de EditListText, dessa forma, tudas as informacoes ficam concentradas em um mesmo lugar
  late ControllerEditListText _edit_abbreviations;
  String name = '';
  String nationality = '';

  ControllerTablePeople([People? p]) {
    if(p == null) {
      return;
    }
    people = p;
  }

  People get people => People(name, 0, _edit_abbreviations.list_text, nationality);
  set people (People p){
    name = p.attributes['nome'];
    _edit_abbreviations = ControllerEditListText(list_text: p.attributes['abreviaturas']);
    nationality = p.attributes['nacionalidade'];
  }

  ControllerEditListText get controller_abbreviations => _edit_abbreviations;
}