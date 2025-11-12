import 'dart:convert';
import 'dart:io';

import 'package:parry_front/core/scrapper/extracting_structure.dart';
import 'package:parry_front/core/scrapper/extractor/pdf_extractor.dart';
import 'package:parry_front/core/scrapper/lexer/lexer.dart';
import 'package:parry_front/core/scrapper/parser_production.dart';
import 'package:parry_front/core/scrapper/scrapper.dart';

void main() {
  test_scrapping();
}

void test_scrapping() async {
  final extractor = ExtractingStructure.extracting_structure(path_pdf: './tests/pdf/lattes_marcela.pdf');
  final struct = extractor!.extract_data();

  final scrapper = Scrapper(struct);
  try {
    final (curriculo,people) = scrapper.scrapping();
    final json_curriculo = JsonEncoder.withIndent(' ').convert(curriculo.attributes);
    final json_pessoa = JsonEncoder.withIndent(' ').convert(people.attributes);
    File('./tests/json_lattes.text').writeAsStringSync('$json_curriculo, $json_pessoa');
  } catch (e) {
    print(e);
  }

  
}

void test_extract_pdf() async {
  final extractor = PDFExtractor();
  extractor.load('./assets/testes_pdf/lattes_marcela.pdf');
  final sla = extractor.extract_data();
  final file = File('./assets/lattes.text');
  String str = '';

  for(final s in sla.lines) {
    str += '${s.text}\n';
  }

  file.writeAsStringSync(str);
}

void test_pdf() {
  final extractor = PDFExtractor();
  extractor.load('./assets/testes_pdf/lattes_jc.pdf');

  final lines = extractor.extrator.extractTextLines(endPageIndex: 0,startPageIndex: 0);
  for(final line in lines) {
    final position_top_line = line.bounds.top;
    print('$position_top_line:${line.text}');
  }
}

void test_lexer() {
  const citacao = 'AMARAL, W. A. ; CASTRO, F. ; COELHO, S. T. ; GOES, M. A. ; HAMANAKA, C. O. ; I. C. S., ; J. L. E., ; MORAES, W. B. ; PEREIRA, M. D. ; PINTO, R. L. O. ; PONCHET, A. F. ; SANCHEZ, E. A. C. ; SILVA, J. C. ; SPILLER, L. H. ; XIMENES, A. R. ; YAMAMOTO, S. D. ; LIMA, R. N. ; SOBRAL, V. A. L. . A 2.4GHz transceiver for wireless sensor network. In: 2012 International Caribbean Conference on Devices, Circuits and Systems (ICCDCS), 2012, Playa del Carmen. 2012 8th International Caribbean Conference on Devices, Circuits and Systems (ICCDCS), 2012.'; //apenas para teste
  final lexico = Lexer(text: citacao);

  final tokens = lexico.tokenize();
  for(final t in tokens) {
    print('${t.type}: ${t.value}');
  }
}

void test_parser() {
  const citacao = 'ROSAS, J.; Macedo ; Camarinha-Matos . An Organization s Extended (Soft) Competencies Model. In: Camarinha-Matos, Luis; Paraskakis, Iraklis; Afsarmanesh, Hamideh. (Org.). Leveraging Knowledge for Innovation in Collaborative Networks. Boston: Springer, 2009, v. 307, p. 245-256.'; //apenas para teste
  final lexico = Lexer(text: citacao);

  final parser = ParserProduction(tokens: lexico.tokenize());
  print(parser.parse());
}