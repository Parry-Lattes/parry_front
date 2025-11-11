import 'package:parry_front/core/lattes_entitys/lattes_entity.dart';

class Production extends LattesEntity {
  Production(
    String autor,
    List<String> coautores,
    String title,
    String date_pub,
    TypeProduction type,
    String hash
  ) {
    attributes = {
      'autor': autor,
      'coautores': coautores,
      'titulo': title,
      'data_de_publicacao': date_pub,
      'tipo_s': type.text_type,
      'hash': hash
    };
  }
}

enum TypeProduction {
  bibliographic(text_type: 'Bibliográfica'),
  technique(text_type: 'Técnica'),
  patent(text_type: 'Patente'),
  other(text_type: 'Outro');

  final String text_type;

  const TypeProduction({required this.text_type});
}