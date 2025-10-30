import 'package:parry_front/core/scrapper/parsers/parser_pdf.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

void main() {
  test_parser();
}

void test_parser() async {
  final parser = ParserPdf();
  parser.load('./assets/hello.pdf');
  print(PdfTextExtractor(parser.document!).extractText());
}