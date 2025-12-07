import 'package:parry_front/core/lattes_entitys/curriculum.dart';
import 'package:parry_front/core/lattes_entitys/people.dart';
import 'package:parry_front/core/scrapper/extractor/extractor.dart';
import 'package:parry_front/core/scrapper/scrapper.dart';
import 'package:parry_front/controllers/controller_spreadsheet/controller_table_curriculum.dart';
import 'package:parry_front/controllers/controller_spreadsheet/controller_table_people.dart';

/*
 Controller para a planilha de dados que serão editados
 Possui, internamente, dois controllers, um para a tabela de Pessoa
 e outro para a tabela de Curriculo.
 É obrigatório informar o extrator que será utilizado na sua construção
 */
class ControllerSpreadsheet {
  final Extractor extractor;
  final controller_people = ControllerTablePeople();
  final controller_curriculum = ControllerTableCurriculum();

  ControllerSpreadsheet({required this.extractor});

  /*
   Retorna os dados depois de editados, ou seja, retorna os dados que estão no estado atual da planilha.
   Será utilizado na hora de fazer upload dos dados.
   Caso os dados ainda não tenham sido corretamente carregados, lança um erro
   */
  (Curriculum,People) get data {
    final curriculum = controller_curriculum.curriculum;

    final p = controller_people.people;

    final people = People(p.name, curriculum.id_lattes, p.abbreviations, p.nacionality);

    return (curriculum,people);
  }

  //carrega os dados do extrator e retorna eles. Será utilizado pelo widget
  Future<(Curriculum,People)> load_data() async {
    await Future.delayed(const Duration(seconds: 2)); //esse delay é necessário para que o widget seja corretamente construído
    final struct = extractor.extract_data();

    final scrapper = Scrapper(struct);
    return scrapper.scrapping();
  }
}