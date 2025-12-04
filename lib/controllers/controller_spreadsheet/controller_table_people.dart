import 'package:flutter/material.dart';
import 'package:parry_front/core/lattes_entitys/people.dart';
import 'package:parry_front/controllers/controller_spreadsheet/controller_edit_list_text.dart';

/*
 Controller da tabela de pessoa. Possui o controller da lista de abreviaturas
 possíveis para a pessoa.
 Possui também um controller para o campo de texto do nome, e um controller pro campo de texto da
 nacionalidade.
 */
class ControllerTablePeople {
  //este controller possui outro controller, porque a edicao da lista de abreviacoes vem de outro widget
  //e, durante a criacao do widget EditListText, o controller de TablePessoa vai pedir ao proprio controller pelo
  //controller de EditListText, dessa forma, tudas as informacoes ficam concentradas em um mesmo lugar
  ControllerEditListText _edit_abbreviations = ControllerEditListText(list_text: List.empty());
  TextEditingController name = TextEditingController(text: '');
  TextEditingController nationality = TextEditingController(text: '');

  ControllerTablePeople([People? p]) {
    if(p == null) {
      return;
    }
    people = p;
  }

  /*
   Retorna o objeto que resepresenta a entidade de pessoa. observe que o id_lattes aqui será sempre 0,
   o que significa que quem for obter a pessoa, terá que alterar seu id_lattes,
   no caso isso é feito pelo spreadsheet
   */
  People get people => People(name.text, 0, _edit_abbreviations.list_text, nationality.text);

  set people (People p) {
    name = TextEditingController(text: p.name);
    _edit_abbreviations = ControllerEditListText(list_text: p.abbreviations);
    nationality = TextEditingController(text: p.nacionality);
  }

  ControllerEditListText get controller_abbreviations => _edit_abbreviations;
}