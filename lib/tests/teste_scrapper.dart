import 'package:parry_front/core/scrapper/extractor/pdf_extractor.dart';

void main() {
  test_parser();
}

void test_parser() async {
  final extractor = PDFExtractor();
  extractor.load('./assets/testes_pdf/lattes_jc.pdf');
  final text = extractor.extract_data();

  text.sprint();
}

void test_pdf() {
  final extractor = PDFExtractor();
  extractor.load('./assets/testes_pdf/lattes_jc.pdf');

  final lines = extractor.extrator!.extractTextLines(endPageIndex: 0,startPageIndex: 0);
  for(final line in lines) {
    final position_top_line = line.bounds.top;
    print('$position_top_line:${line.text}');
  }
}