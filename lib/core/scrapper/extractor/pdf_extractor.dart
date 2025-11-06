import 'dart:io';

import 'package:parry_front/core/scrapper/extractor/extractor.dart';
import 'package:parry_front/core/scrapper/struct_lattes/struct_lattes.dart';
import 'package:parry_front/tools/text_tools.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PDFExtractor implements Extractor{
  PdfDocument? document;
  PdfTextExtractor? extrator;
  List<String> titles = List.empty();

  PDFExtractor() {
    _load_titles();
  }

  void _load_titles() {
    final lines_titles = File('assets/texts/titles_lattes.txt').readAsStringSync().toLowerCase();
    titles = lines_titles.split('\n');
  }

  @override
  Future load(Object path) async {
    document = PdfDocument(inputBytes: File(path.toString()).readAsBytesSync());
    extrator = PdfTextExtractor(document!);
  }

  @override
  StructLattes extract_data() {
    StructLattes struct = StructLattes();

    for(int i = 0; i<document!.pages.count; i++) {
      //percorro cada pagina, e organizo as linhas
      //pagina por pagina
      final page_lines = _organize_line(i);

      for(var line in page_lines) {
        if(line.contains('  ')) {
          line = clean_spaces(line);
        }

        final title = _is_title(line);
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
    final page_lines = extrator!.extractTextLines(startPageIndex: page_index,endPageIndex: page_index);
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

  String _is_title(final String text) {
    //para saber se o texto e um titulo, crio uma versao dele sem espacos em branco
    final text_clean = clean_spaces(text);

    //crio tambem uma versao em lower case
    final text_lower = text.toLowerCase();
    //e outra sem espacos e lower case
    final text_lower_clean = text_clean.toLowerCase();

    //agora, comparo ambas as versoes com cada um dos titulos possiveis
    for(final title in titles) {
      if(title == text_lower) {
        return text_lower;
      }

      if(title== text_lower_clean) {
        return text_lower_clean;
      }
    }

    return '';
  }
}