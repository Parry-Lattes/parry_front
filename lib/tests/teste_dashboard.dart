import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:parry_front/core/api_interface/api_interface.dart';
import 'package:parry_front/core/scrapper/extractor/getting_extractor.dart';
import 'package:parry_front/core/scrapper/scrapper.dart';

void main() async {
  await dotenv.load(fileName: 'assets/env.env');
  await ApiInterface.login('root', '1234');

  final e1 = getting_extractor(path_pdf: './testes/pdf/lattes_aline.pdf');
  final e2 = getting_extractor(path_pdf: './testes/pdf/lattes_jc.pdf');
  final e3 = getting_extractor(path_pdf: './testes/pdf/lattes_kazuo.pdf');

  await Future.delayed(const Duration(seconds: 2));
  if(e1 == null || e2 == null || e3 == null) {
    return;
  }

  final s = [Scrapper(e1.extract_data()).scrapping(),Scrapper(e2.extract_data()).scrapping(),Scrapper(e3.extract_data()).scrapping()];
  final upload_people = ApiInterface.upload_people;

  for(final con in s) {
    final (curriculum,people) = con;

    //primeiro, tentamos deletar o que já tem no banco de dados
    await ApiInterface.delete_data(curriculum.id_lattes);

    //depois de tentar deletar, tentamos enviar a pessoa
    if(await upload_people.send_data(people.json)) {
      //se tudo der certo, fazemos o upload do curriculo
      print('enviando curriculo');
      final result = ApiInterface.upload_curriculum(curriculum.id_lattes);
      result.send_data(curriculum.json);
    }
  }

  final (reponse,code) = await ApiInterface.request_in('dashboard');
  print(reponse);
  print(code);

  final peoples = await ApiInterface.request_all_people();
  for(final p in peoples) {
    print(p.name);
    print('producoes:');

    final curriculum = await ApiInterface.request_curriculum(int.tryParse(p.id_lattes)!);
    if(curriculum == null) {
      print('Curriculo vazio');
      continue;
    }

    for(final a in curriculum.productions) {
      print(a.title);
    }
  }
}