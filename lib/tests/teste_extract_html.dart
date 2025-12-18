import 'dart:io';

import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:parry_front/core/scrapper/extractor/html_extractor.dart';
import 'package:parry_front/tools/web_navigator.dart';

void main() async {
  test_pick_lines();
}

void test() {
  const text_html = '<p>textinho1<b>elemento1</b><i>elemento2</i>textinho2<i>elemento3</i>textinho3</p>';

  final document = parse(text_html);

  iter_element(document.nodes);
}

void iter_element(NodeList elemets) {
  for(final e in elemets) {
    if(e.nodes.length == 1) {
      if(e.nodes.first.nodes.isEmpty) {
        print(e.text);
        continue;
      }
    } else if(e.nodes.isEmpty) {
      print(e.text);
      continue;
    }
    iter_element(e.nodes);
  }
}

void test_pick_page() async {
  await WebNavigator.init_navigator('https://buscatextual.cnpq.br/buscatextual/busca.do?metodo=apresentar');

  //dar um tempo pra eu poder abrir a pagina
  await Future.delayed(const Duration(seconds: 20));
  print('Carregando dados..');

  final pages = await WebNavigator.load_pages('Currículo do Sistema de Currículos Lattes');
  print(pages.length);

  for(final p in pages.entries) {
    final extractor = HTMLExtractor();
    await extractor.load(p.value);
    extractor.extract_data();
  }
}

void test_pick_lines() async {
  await WebNavigator.init_navigator('https://buscatextual.cnpq.br/buscatextual/busca.do?metodo=apresentar');

  //dar um tempo pra eu poder abrir a pagina
  await Future.delayed(const Duration(seconds: 30));
  print('Carregando dados..');

  final pages = await WebNavigator.load_pages('Currículo do Sistema de Currículos Lattes');
  print(pages.length);

  for(final p in pages.entries) {
    final extractor = HTMLExtractor();
    await extractor.load(p.value);
    final struct = extractor.extract_data();

    final file = File('./testes/lattes.text');
    String str = '';

    for(final s in struct.lines) {
      str += '${s.text}\n';
    }

    file.writeAsStringSync(str);
  }
}