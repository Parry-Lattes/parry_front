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
  List<(int,String)> search_lines(final String by_text,{bool only_title = false,int start = 0,int? end}) {
    final List<(int,String)> result = List.empty(growable: true);
    int count = -1;
    var list = _lines;

    if(end != null) {
      list = _lines.sublist(start,end);
    } else if(start > 0) {
      list = _lines.sublist(start);
    }

    for(final l in list) {
      count++;
      // if(l is Title) {
      //   print(l.text);
      // }
      
      //se contiver, verifica ha filtro de titulos
      if(only_title && l is! Title) {
        continue;
      }
      
      if(l.text.toLowerCase().contains(by_text)) {
        result.add((count,l.text));
      }
      
    }

    return result;
  }

  List<Line> range_lines(int start, [int end = -1]) {
    if (end < 0) {
      return _lines.sublist(start);
    }

    return _lines.sublist(start,end);
  }

  List<Line> get lines {
    return _lines.sublist(0);
  }
}