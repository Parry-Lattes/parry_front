import 'package:parry_front/core/lattes_entitys/curriculum.dart';
import 'package:parry_front/core/lattes_entitys/production.dart';

void main(List<String> args) {
  experimentar_entidades();
}

void experimentar_entidades() {
  List<Production> producoes = [
    Production('autor1',[], 'title1', 'date_pub1', TypeProduction.other, 'hash1'),
    Production('autor2',[], 'title2', 'date_pub2', TypeProduction.other, 'hash2'),
    Production('autor3',[], 'title3', 'date_pub3', TypeProduction.other, 'hash3'),
  ];

  Curriculum c = Curriculum(784334736, 'last_update', producoes);

  print(c.json);
}