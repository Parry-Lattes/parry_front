import 'package:parry_front/core/lattes_entitys/lattes_entity.dart';

class People extends LattesEntity{
  People(
    String name,
    int id_lattes,
    List<String> abbreviations,
    String nationality
  ) {
    attributes = {
      'nome': name,
      'id_lattes': id_lattes,
      'abreviaturas': abbreviations,
      'nacionalidade': nationality
    };
  }
}