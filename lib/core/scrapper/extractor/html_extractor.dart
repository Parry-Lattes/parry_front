import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:parry_front/core/scrapper/extractor/extractor.dart';
import 'package:parry_front/core/scrapper/struct_lattes/struct_lattes.dart';
import 'package:parry_front/tools/text_tools.dart';

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

    _iter_nodes(element_curriculum.nodes, struct);
    
    return struct;
  }

  void _iter_nodes(NodeList nodes,StructLattes struct) {
    for(final node in nodes) {
      if(node is Element) {
        if(node.localName!.toLowerCase() == 'script') {
          continue;
        }
      }

      //primeiro, verifico o tamanho do no filho
      if(node.nodes.length == 1) {
        //se tiver o tamanho de um, pode ser que seu filho seja apenas um texto
        //para saber isso, verifico se seu filho e vazio
        if(node.nodes.first.nodes.isEmpty) {
          //se for, adiciono uma nova linha
          final text_line = node.text;
          if(!_is_empty(text_line)) {
            _add_line(struct, text_line!);
            continue;
          }
        }
      } else if(node.nodes.isEmpty) {
        final text_line = node.text;
        if(!_is_empty(text_line)) {
          _add_line(struct, text_line!);
        }
        continue;
      }

      //por fim, me resta continuar a iteracao
      _iter_nodes(node.nodes, struct);
    }
  }

  void _add_line(StructLattes struct, String line) {
    final title = is_title(line);

    if(title != '') {
      struct.add_title(title);
      return;
    }

    //nao quero tabs sujando a memoria
    struct.add_line(line.replaceAll('\t', ' ').trim());
  }

  bool _is_empty(String? text) {
    if(text == null) {return true;}
    return text.trim().isEmpty;
  }
}