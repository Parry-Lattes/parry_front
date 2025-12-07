import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:parry_front/core/api_interface/api_interface.dart';

void main() {
  print('testando acessar a api');
  teste_login();
}

void teste_login() async {
  await dotenv.load(fileName: 'assets/env.env');
  print(await ApiInterface.login('root', '1234'));
  print(await ApiInterface.request_in('dashboard'));
  // final response = await ApiInterface.login('root', '1234');
  // final text_splited = response.split(RegExp(r',(?=\s*[^;]+=)'));
  // for(final t in text_splited) {
  //   print(t);
  //   final coo = Cookie.fromSetCookieValue(t.trim());

  //   print(coo.name);
  //   print(coo.value);
  // }

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