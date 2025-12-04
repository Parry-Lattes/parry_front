import 'package:flutter/material.dart';
import 'package:parry_front/core/lattes_entitys/production.dart';
import 'package:parry_front/controllers/controller_spreadsheet/controller_edit_list_text.dart';

/*
 Controller da tabela de produções.
 Possui o controller para o campo de texto de autor,
 o controller para a edição de lista de coautores
 E uma string que representa a data de publicação da produção. Essa string é diretamente alterada pelo widget
 de seleção de data, referente ao campo de edição da data de publicação.
 Possui também um campo para o tipo, que é diretamente alterado pela caixa de seleção do campo de edição do tipo
 de produção
 */
class ControllerTableProduction {
  TextEditingController autor = TextEditingController(text: '');
  ControllerEditListText _edit_coautores = ControllerEditListText(list_text: List.empty(growable: true));
  TextEditingController title = TextEditingController(text: '');
  String date_pub = '2006'; //valor padrao aqui pra nao gerar problemas de valor nulo
  TypeProduction type = TypeProduction.other;

  ControllerTableProduction([Production? p]) {
    if(p == null) {return;}

    production = p;
  }

  //retorna a produção com os dados do estado atual da tabela de produção
  Production get production {
    return Production(autor.text, _edit_coautores.list_text, title.text, date_pub, type);
  }

  // modifica a produção que está sendo editada pela tabela
  set production(Production p) {
    autor = TextEditingController(text: p.autor);
    _edit_coautores = ControllerEditListText(list_text: p.coautores);
    title = TextEditingController(text: p.title);
    date_pub = p.date_pub;
    type = p.type;
  }

  ControllerEditListText get controller_coautores => _edit_coautores;
}