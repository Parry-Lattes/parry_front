import 'dart:io';

import 'package:parry_front/core/scrapper/parsers/parser.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class ParserPdf implements Parser{
  PdfDocument? document;

  @override
  Future load(Object path) async {
    document = PdfDocument(inputBytes: File(path.toString()).readAsBytesSync());
  }
}