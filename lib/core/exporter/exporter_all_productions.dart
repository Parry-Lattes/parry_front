import 'dart:io';

import 'package:csv/csv.dart';
import 'package:parry_front/core/api_interface/api_interface.dart';
import 'package:parry_front/core/exceptions/curriculum_not_found.dart';
import 'package:parry_front/core/exporter/exporter.dart';

class ExporterAllProductions extends Exporter {
  @override
  Future export(String path) async {
    final peoples = await ApiInterface.request_all_people();

    final List<List<String>> tuples = [];
    tuples.add(['Todas as produções registradas']);
    tuples.add(['Título','Autor','Ano de publicação','Coautores','Tipo de produção','Discente associado','ID Lattes do discente associado']);

    for(final people in peoples) {
      final curriculum = await ApiInterface.request_curriculum(int.tryParse(people.id_lattes)!);

      if(curriculum == null) {
        throw CurriculumNotFound();
      }

      for(final production in curriculum.productions) {
        tuples.add([
          production.title,
          production.autor,
          production.date_pub,
          production.coautores.join(','),
          production.type.text_type,
          people.name,
          people.id_lattes,
        ]);
      }
    }

    final text_cvs = ListToCsvConverter().convert(tuples);
    await File(path).writeAsString(text_cvs);
  }
}