import 'dart:io';

import 'package:parry_front/core/scrapper/extractor/extractor.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PDFExtractor implements Extractor{
  PdfDocument? document;
  PdfTextExtractor? extrator;

  @override
  Future load(Object path) async {
    document = PdfDocument(inputBytes: File(path.toString()).readAsBytesSync());
    extrator = PdfTextExtractor(document!);
  }

  @override
  Map<String, List<String>>? extract_data() {
    final data = extrator!.findText(['Projetos de ensino']);
    //print(extrator!.extractText());
    final d = data[0];
    print('${d.text} ${d.pageIndex}');
    print(extrator!.extractText(startPageIndex: d.pageIndex,endPageIndex: d.pageIndex,layoutText: false));
    
    return null;
  }
}