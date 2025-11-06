import 'package:parry_front/core/scrapper/extractor/extractor.dart';
import 'package:parry_front/core/scrapper/extractor/pdf_extractor.dart';
import 'package:parry_front/core/scrapper/struct_lattes/struct_lattes.dart';


//um pequeno agilizador do processo que carregar o extrator de linhas
class ExtractingStructure {
  static late Extractor _extrator;

  static StructLattes extracting_structure({final String path_pdf = '', final String text_html = ''}) {
    if (path_pdf != '') {
      _extrator = PDFExtractor();
      _extrator.load(path_pdf);
      return _extrator.extract_data();
    }

    if (text_html != '') {
      _extrator = PDFExtractor();
      _extrator.load(text_html);
      return _extrator.extract_data();
    }

    return StructLattes();
  }
}