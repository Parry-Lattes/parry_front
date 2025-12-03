import 'package:parry_front/core/lattes_entitys/lattes_entity.dart';

class Production extends LattesEntity {
  List<String> _coautors = List.empty();
  String _date_pub = '';

  Production(
    String autor,
    List<String> coautores,
    String title,
    String date_pub,
    TypeProduction type
  ) {
    final map_coautors = <Map<String,Map<String,String>>> [];
    _coautors = coautores;

    for(final c in coautores) {
      map_coautors.add({'abreviatura': {'abreviatura': c}});
    }

    _date_pub = date_pub;

    attributes = {
      'autor': autor,
      'coautores': map_coautors,
      'titulo': title,
      'data_de_publicacao': date_pub.substring(0,4),
      'tipo_s': type.text_type
    };

    print(attributes['data_de_publicacao']);
  }

  String get autor => attributes['autor'];
  List<String> get coautores => _coautors;
  String get title => attributes['titulo'];
  String get date_pub => _date_pub;
  TypeProduction get type {
    switch (attributes['tipo_s']) {
      case 'Bibliográfica':
        return TypeProduction.bibliographic;
      case 'Técnica':
        return TypeProduction.technique;
      case 'Patente':
        return TypeProduction.patent;
    }

    return TypeProduction.other;
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