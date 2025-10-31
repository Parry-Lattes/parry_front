import 'package:parry_front/core/scrapper/extractor/pdf_extractor.dart';

void main() {
  test_parser();
}

void test_parser() async {
  final extractor = PDFExtractor();
  extractor.load('./assets/testes_pdf/lattes_jc.pdf');
  extractor.extract_data();
}