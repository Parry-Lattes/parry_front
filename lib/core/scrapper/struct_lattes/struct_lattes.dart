import 'package:parry_front/core/scrapper/struct_lattes/line.dart';
import 'package:parry_front/core/scrapper/struct_lattes/title.dart';

class StructLattes {
  final List<Line> _lines = List.empty(growable: true);

  void add_line(String text,{int? position}) {
    final line = Line(text);
    if(position != null) {
      _lines.insert(position, line);
      return;
    }

    _lines.add(line);
  }

  void add_title(String text,{int? position}) {
    final title = Title(text);
    if(position != null) {
      _lines.insert(position, title);
      return;
    }

    _lines.add(title);
  }

  //funcao essencial para o scrapper
  List<String> search_lines(final String by_text,{bool only_title = false}) {
    final List<String> result = List.empty(growable: true);

    for(final l in _lines) {
      //verifica se a linha contem o texto buscado
      if(l.text.toLowerCase().contains(by_text)) {
        //se contiver, verifica ha filtro de titulos
        if(only_title && l is! Title) {
          continue;
        }

        result.add(l.text);
      }
    }

    return result;
  }

  List<Line> get lines {
    return _lines.sublist(0);
  }
}