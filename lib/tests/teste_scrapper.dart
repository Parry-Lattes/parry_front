import 'package:parry_front/core/scrapper/extracting_structure.dart';
import 'package:parry_front/core/scrapper/extractor/pdf_extractor.dart';
import 'package:parry_front/core/scrapper/scrapper.dart';

void main() {
  test_scrapping();
}

void test_scrapping() {
  final struct = ExtractingStructure.extracting_structure(path_pdf: './assets/testes_pdf/lattes_marcela.pdf');

  final scrapper = Scrapper();
  try {
   final curriculo = scrapper.scrapping(struct);
   print(curriculo.json);
  } catch (e) {
    print(e);
  }

  
}

void test_parser() async {
  final extractor = PDFExtractor();
  extractor.load('./assets/testes_pdf/lattes_jc.pdf');
  final sla = extractor.extract_data();

  for(final s in sla.lines) {
    print(s);
  }
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