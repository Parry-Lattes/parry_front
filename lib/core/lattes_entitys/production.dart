import 'package:parry_front/core/lattes_entitys/lattes_entity.dart';

class Production extends LattesEntity {
  Production(
    String autor,
    List<String> coautores,
    String title,
    String date_pub,
    String type,
    String hash
  ) {
    attributes = {
      'autor': autor,
      'coautores': coautores,
      'titulo': title,
      'data_de_publicacao': date_pub,
      'tipo_s': type,
      'hash': hash
    };
  }
}