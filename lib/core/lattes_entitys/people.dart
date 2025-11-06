import 'package:parry_front/core/lattes_entitys/lattes_entity.dart';

class People extends LattesEntity{
  People(
    String name,
    int id_lattes,
    bool sex,
    String nationality
  ) {
    attributes = {
      'nome': name,
      'id_lattes': id_lattes,
      'sexo': sex,
      'nacionalidade': nationality
    };
  }
}