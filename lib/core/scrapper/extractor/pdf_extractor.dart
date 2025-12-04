import 'dart:io';

import 'package:parry_front/core/scrapper/extractor/extractor.dart';
import 'package:parry_front/core/scrapper/struct_lattes/struct_lattes.dart';
import 'package:parry_front/tools/text_tools.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PDFExtractor extends Extractor{
  late PdfDocument _document;
  late PdfTextExtractor _extrator;

  PDFExtractor():super() {
    _document = PdfDocument();
    _extrator = PdfTextExtractor(_document);
  }

  @override
  Future load(Object path) async {
    _document = PdfDocument(inputBytes: File(path.toString()).readAsBytesSync());
    _extrator = PdfTextExtractor(_document);
  }

  @override
  StructLattes extract_data() {
    StructLattes struct = StructLattes();

    for(int i = 0; i<_document.pages.count; i++) {
      //percorro cada pagina, e organizo as linhas
      //pagina por pagina
      final page_lines = _organize_line(i);

      for(var line in page_lines) {
        if(line.contains('  ')) {
          line = clean_spaces(line);
        }

        final title = is_title(line);
        if(title != '') {
          struct.add_title(title);
        } else {
          struct.add_line(line);
        }
      }
    }

    return struct;
  }

  List<String> _organize_line(final int page_index) {
    final page_lines = _extrator.extractTextLines(startPageIndex: page_index,endPageIndex: page_index);
    List<String> lines_text = List.empty(growable: true);
    List<double> lines_positions = List.empty(growable: true);

    for(final line in page_lines) {
      final position_top_line = line.bounds.top;

      if (lines_positions.isEmpty) {
        lines_text.add(line.text);
        lines_positions.add(line.bounds.top);
        continue;
      }

      //preciso saber se o topo da linha esta mais abaixo da ultima linha adicionada
      if (position_top_line > lines_positions.last) {
        //se sim, eu apenas adiciono como uma linha regular e continuo a busca
        lines_text.add(line.text);
        lines_positions.add(line.bounds.top);
        continue;
      }

      //se nao, entao vamos precisar saber exatamente
      //em qual posicao essa linha deveria estar
      final index = _search_position(position_top_line, lines_positions);

      lines_text.insert(index, line.text);
      lines_positions.insert(index, line.bounds.top);
    }

    return lines_text;
  }

  int _search_position(double position_line, List<double> positions) {

    //vamos percorrer as posicoes das linhas
    for(int i = positions.length-1;i>=0;i--) {
      //vamos procurar, ate chegar no ponto em que a linha esta
      //abaixo da outra
      if(position_line > positions[i]) {
        //se esta abaixo, a posicao da linha entao deve ser a proxima
        //lembrando que estamos decrescendo as posicoes
        return i+1;
      }
    }

    //se ele percorreu toda a lista de posicoes, e nenhuma posicao
    //esta abaixo desta linha, entao a posicao deve ser 0, a primeira
    return 0;
  }
}