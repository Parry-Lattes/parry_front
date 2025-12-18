import 'package:parry_front/core/exceptions/id_not_found.dart';
import 'package:parry_front/core/exceptions/last_update_not_found.dart';
import 'package:parry_front/core/exceptions/name_not_found.dart';
import 'package:parry_front/core/lattes_entitys/curriculum.dart';
import 'package:parry_front/core/lattes_entitys/people.dart';
import 'package:xml/xml.dart';

class XmlExtractor {
  late XmlElement _xml_element;

  XmlExtractor(String text_xml) {
    this._xml_element = XmlDocument.parse(text_xml).rootElement;
  }

  String _transform_data(String attrib_date) {
    final day = attrib_date.substring(0,2);
    final month = attrib_date.substring(2,4);
    final year = attrib_date.substring(4);

    return '$year-$month-$day';
  }

  List<String> _search_abbreviations(XmlElement _general_data) {
    final attr_abbr = _general_data.getAttribute('NOME-EM-CITACOES-BIBLIOGRAFICAS');
    if(attr_abbr == null) {
      return [];
    }

    return attr_abbr.split(';');
  }

  (Curriculum, People) extract_data() {    
    final attr_date = _xml_element.getAttribute('DATA-ATUALIZACAO');
    if(attr_date == null) {
      throw LastUpdateNotFound();
    }

    final attr_lattes = _xml_element.getAttribute('NUMERO-IDENTIFICADOR');
    if(attr_lattes == null) {
      throw IDNotFound();
    }

    final _general_data = _xml_element.getElement('DADOS-GERAIS');
    if(_general_data == null) {
      throw NameNotFound();
    }

    final name = _general_data.getAttribute('NOME-COMPLETO');
    if(name == null) {
      throw NameNotFound();
    }

    String? nationality = _general_data.getAttribute('PAIS-DE-NASCIMENTO');
    if(nationality == null) {nationality = 'Brasil';}

    final last_update = _transform_data(attr_date);
    final id_lattes = int.tryParse(attr_lattes)!;
    final abbreviations = _search_abbreviations(_general_data);

    return (
      Curriculum(
        id_lattes,
        last_update,
        []
      ),
      People(
        name,
        id_lattes,
        abbreviations,
        nationality
      )
    );
  }
}