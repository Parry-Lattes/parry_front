import 'dart:io';

import 'package:csv/csv.dart';
import 'package:parry_front/core/api_interface/api_interface.dart';
import 'package:parry_front/core/exceptions/curriculum_not_found.dart';
import 'package:parry_front/core/exporter/exporter.dart';

class ExporterProductionsOfPeople extends Exporter {
  final int id_lattes;
  const ExporterProductionsOfPeople({required this.id_lattes});

  @override
  Future export(String path) async {
    final curriculum = await ApiInterface.request_curriculum(id_lattes);
    final people = await ApiInterface.request_people(id_lattes);

    if(curriculum == null || people == null) {
      throw CurriculumNotFound();
    }

    final productions = curriculum.productions;
    
    final List<List<String>> tuples = [];
    tuples.add(['Produções de ${people.name}']);
    tuples.add(['Título','Autor','Ano de publicação','Tipo de publicação','Coautores']);

    for(final production in productions) {
      tuples.add([
        production.title,
        production.autor,
        production.date_pub,
        production.type.text_type,
        production.coautores.join(',')
      ]);
    }

    final text_cvs = ListToCsvConverter().convert(tuples);
    await File(path).writeAsString(text_cvs);
  }
}