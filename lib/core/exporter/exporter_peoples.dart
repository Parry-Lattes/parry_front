import 'dart:io';

import 'package:csv/csv.dart';
import 'package:parry_front/core/api_interface/api_interface.dart';
import 'package:parry_front/core/exporter/exporter.dart';

class ExporterPeoples extends Exporter {
  @override
  Future export(String path) async{
    final peoples = await ApiInterface.request_all_people();

    final List<List<String>> tuples = [];
    tuples.add(['Pessoas registradas no sistema']);
    tuples.add((['Nome','ID Lattes', 'Nacionalidade', 'Possíveis abreviações']));

    for (final people in peoples) {
      tuples.add([
        people.name,
        people.id_lattes,
        people.nacionality,
        people.abbreviations.join(',')
      ]);
    }

    final text_cvs = const ListToCsvConverter().convert(tuples);

    await File(path).writeAsString(text_cvs);
  }
}