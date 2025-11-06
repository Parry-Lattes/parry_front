import 'dart:io';

import 'package:parry_front/core/scrapper/struct_lattes/line.dart';
import 'package:parry_front/core/scrapper/struct_lattes/title.dart';

class StructLattes {
  List<Line> lines = List.empty(growable: true);

  void add_line(String text,{int? position}) {
    final line = Line(text);
    if(position != null) {
      lines.insert(position, line);
      return;
    }

    lines.add(line);
  }

  void add_title(String text,{int? position}) {
    final title = Title(text);
    if(position != null) {
      lines.insert(position, title);
      return;
    }

    lines.add(title);
  }

  //isso aqui e so para testar, espero que nao esteja no codigo final
  void sprint() {
    String text = '';
    final file = File('./assets/text.txt');
    for (final line in lines) {
      text += '${line.text}\n';
    }

    file.writeAsString(text);
  }
}