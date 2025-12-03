import 'package:parry_front/core/lattes_entitys/lattes_entity.dart';

class People extends LattesEntity{
  List<String> _abbreviations = List.empty();
  People(
    String name,
    int id_lattes,
    List<String> abbreviations,
    String nationality
  ) {
    _abbreviations = abbreviations;

    final map_abbreviations = <Map<String,String>>[];
    for(final a in abbreviations) {
      map_abbreviations.add({'abreviatura': a});
    }

    attributes = {
      'nome': name,
      'id_lattes': '$id_lattes',
      'abreviaturas': map_abbreviations,
      'nacionalidade': nationality
    };
  }

  String get id_lattes => attributes['id_lattes'];
  String get name => attributes['nome'];
  List<String> get abbreviations => _abbreviations;
  String get nacionality => attributes['nacionalidade'];
}