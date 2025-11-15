import 'package:parry_front/tools/navigator/navigator.dart';

void main() async {
  await Navigator.init_navigator('https://buscatextual.cnpq.br/buscatextual/busca.do?metodo=apresentar');

  for(final p in await Navigator.pages) {
    print(p.url);
  }
}