import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:parry_front/core/api_interface/api_interface.dart';

void main() {
  print('testando acessar a api');
  teste_requisicao_curriculum();
}

void teste_conexao() async {
  await dotenv.load(fileName: 'assets/env.env');
  print(await ApiInterface.request_in(''));
}

void teste_requisicao_people() async {
  await dotenv.load(fileName: 'assets/env.env');
  final people = await ApiInterface.request_people(5948064802257396);

  if(people != null) {
    print(people.abbreviations);
  }

  final sla = await ApiInterface.request_all_people();
  for(final a in sla) {
    print(a.json);
  }
}

void teste_requisicao_curriculum() async {
  await dotenv.load(fileName: 'assets/env.env');
  final curriculum = await ApiInterface.request_curriculum(5948064802257396);

  if(curriculum != null) {
    for(final p in curriculum.productions) {
      print('Produção: ${p.title}');
      print('Coautores: ${p.coautores}');
    }
  }
}