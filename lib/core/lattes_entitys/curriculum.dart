import 'package:parry_front/core/lattes_entitys/lattes_entity.dart';
import 'package:parry_front/core/lattes_entitys/production.dart';

class Curriculum extends LattesEntity {
  late List<Production> _productions;
  
  Curriculum(int id_lattes,String last_update, List<Production> productions) {
    List<dynamic> json_productions = List.empty(growable: true);

    for (final product in productions) {
      json_productions.add(product.attributes);
    }

    _productions = productions;

    attributes = {
      'id_lattes': id_lattes,
      'ultima_atualizacao': last_update,
      'producoes': json_productions
    };
  }

  int get id_lattes => attributes['id_lattes'];
  String get last_update => attributes['ultima_atualizacao'];
  List<Production> get productions => _productions;
}