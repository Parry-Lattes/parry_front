import 'package:parry_front/core/scrapper/extractor/extractor.dart';
import 'package:parry_front/core/scrapper/extractor/pdf_extractor.dart';


//um pequeno agilizador do processo que carregar o extrator de linhas
abstract class ExtractingStructure {

  static Extractor? extracting_structure({final String path_pdf = '', final String text_html = ''}) {
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
}