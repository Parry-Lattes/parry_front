import 'dart:io';

import 'package:parry_front/core/scrapper/extractor/getting_extractor.dart';
import 'package:parry_front/core/scrapper/scrapper.dart';

void main() async {
  final e1 = getting_extractor(path_pdf: './testes/pdf/lattes_aline.pdf');
  final e2 = getting_extractor(path_pdf: './testes/pdf/lattes_jc.pdf');
  final e3 = getting_extractor(path_pdf: './testes/pdf/lattes_kazuo.pdf');

  await Future.delayed(const Duration(seconds: 2));
  if(e1 == null || e2 == null || e3 == null) {
    return;
  }

  final s1 = Scrapper(e1.extract_data());
  final s2 = Scrapper(e2.extract_data());
  final s3 = Scrapper(e3.extract_data());

  final (c1,p1) = s1.scrapping();
  final (c2,p2) = s2.scrapping();
  final (c3,p3) = s3.scrapping();

  File('./testes/curriculo1').writeAsStringSync(c1.json);
  File('./testes/curriculo2').writeAsStringSync(c2.json);
  File('./testes/curriculo3').writeAsStringSync(c3.json);

  File('./testes/pessoa1').writeAsStringSync(p1.json);
  File('./testes/pessoa2').writeAsStringSync(p2.json);
  File('./testes/pessoa3').writeAsStringSync(p3.json);
}