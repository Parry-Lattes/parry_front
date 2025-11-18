import 'dart:io';

import 'package:parry_front/core/scrapper/struct_lattes/struct_lattes.dart';
import 'package:parry_front/tools/text_tools.dart';

abstract class Extractor {
  Future load(Object o);
  StructLattes extract_data();
  var titles = List<String>.empty(growable: true);

  Extractor() {
    _load_titles();
  }

  void _load_titles() {
    final lines_titles = File('assets/texts/titles_lattes.txt').readAsStringSync().toLowerCase();
    titles = lines_titles.split('\n');
  }

  String is_title(final String text) {
    //para saber se o texto e um titulo, crio uma versao dele sem espacos em branco
    final text_clean = clean_spaces(text);

    //crio tambem uma versao em lower case
    final text_lower = text.toLowerCase();
    //e outra sem espacos e lower case
    final text_lower_clean = text_clean.toLowerCase();

    //agora, comparo ambas as versoes com cada um dos titulos possiveis
    for(final title in titles) {
      if(title == text_lower) {
        return text_lower;
      }

      if(title== text_lower_clean) {
        return text_lower_clean;
      }
    }

    return '';
  }
}