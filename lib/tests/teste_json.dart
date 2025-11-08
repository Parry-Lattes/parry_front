import 'package:parry_front/core/lattes_entitys/curriculum.dart';
import 'package:parry_front/core/lattes_entitys/production.dart';

void main(List<String> args) {
  experimentar_entidades();
}

void experimentar_entidades() {
  List<Production> producoes = [
    Production('autor1',[], 'title1', 'description1', 'link1', 'date_pub1', 'type1', 'hash1'),
    Production('autor2',[], 'title2', 'description2', 'link2', 'date_pub2', 'type2', 'hash2'),
    Production('autor3',[], 'title3', 'description3', 'link3', 'date_pub3', 'type3', 'hash3'),
  ];

  Curriculum c = Curriculum(784334736, 'last_update', producoes);

  print(c.json);
}