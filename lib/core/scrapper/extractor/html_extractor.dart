import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:parry_front/core/scrapper/extractor/extractor.dart';
import 'package:parry_front/core/scrapper/struct_lattes/struct_lattes.dart';

class HTMLExtractor extends Extractor {
  late Document _document;

  HTMLExtractor():super();

  @override
  Future load(Object text_html) async {
    _document = parse(text_html);
  }

  @override
  StructLattes extract_data() {
    final elements_main = _document.getElementsByClassName('layout-cell-pad-main'); //o elemento que tem o corpo do lattes, e dessa classe
    if(elements_main.isEmpty) { //se nao encontrar o elemento, apenas retorna uma estrutua vazia
      return StructLattes();
    }

    final element_curriculum = elements_main.first; //se tem alguma coisa, entao vamos tentar com o primeiro elemento

    final struct = StructLattes(); //criamos a estrutura de antemao

    //o restante e quase igual ao caso do pdf
    final text_root = element_curriculum.text;
    if(!_is_empyt(text_root)) {
      final text = is_title(text_root);

      if(text == '') {
        struct.add_line(text_root);
      } else {
        struct.add_title(text);
      }
    }

    final elements = element_curriculum.children;
    for (final el in elements) {
      final text_element = el.text;
      if (_is_empyt(text_element)) {continue;}

      final title = is_title(text_element);

      if(title != '') {
        struct.add_title(title);
      } else {
        struct.add_line(text_element);
      }
    }

    return struct;
  }

  bool _is_empyt(String text) {
    //if(text == null) {return true;}
    return text.isEmpty || text.trim().isEmpty;
  }
}