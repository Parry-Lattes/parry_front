import 'package:parry_front/core/scrapper/extractor/extractor.dart';
import 'package:parry_front/core/scrapper/extractor/pdf_extractor.dart';

Extractor? getting_extractor({final String path_pdf = '', final String text_html = ''}) {
    if (path_pdf != '') {
       final extractor = PDFExtractor();
       extractor.load(path_pdf);

        return extractor;
    }

    if (text_html != '') {
      return PDFExtractor();
    }

    return null;
  }