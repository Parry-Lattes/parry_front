import 'package:parry_front/tools/web_navigator.dart';

void main() async {
  await WebNavigator.init_navigator('https://buscatextual.cnpq.br/buscatextual/busca.do?metodo=apresentar');

  await Future.delayed(Duration(seconds: 60));
  print('Carregando paginas...');

  final pages = await WebNavigator.load_pages('Currículo do Sistema de Currículos Lattes');
  print(pages.length);
  for(final p in pages.entries) {
    print('${p.key}:\n${p.value}');
  }
}