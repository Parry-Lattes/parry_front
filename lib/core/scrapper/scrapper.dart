import 'package:parry_front/core/exceptions/id_not_found.dart';
import 'package:parry_front/core/lattes_entitys/curriculum.dart';
import 'package:parry_front/core/scrapper/struct_lattes/struct_lattes.dart';
import 'package:parry_front/tools/text_tools.dart';

class Scrapper {

  int _search_id_lattes(final StructLattes struct) {
    //para obter o endereço lattes, que geralmente esta no começo do texto,
    //buscamos pela sequencia de palavras 'id lattes'
    final lines = struct.search_lines('id lattes');

    //agora trataremos de cada um dos resultados obtidos
    for (var l in lines) {
      //para facilitar tudo, vamos lidar apenas com letrar minusculas
      l = l.toLowerCase();
      //agora, removemos o texto que buscamos
      l = l.replaceAll('id lattes', '');
      //e removemos espacos em branco
      l = clean_spaces(l);
      // tambem e preciso remover pontos
      l = remove_points_chars(l);
      
      //se tudo der certo, devem haver apenas 16 caracteres
      if(l.length == 16) {
        try {
          //agora, tentamos converter em um valor inteiro
          return int.parse(l);
        } on FormatException {
          //se der errado, tentamos em outra linha
          continue;
        }
      }
    }

    //se tudo der errado, apenas retorna-mos -1, o resultado padrao para gerar erro
    return -1;
  }

  Curriculum scrapping(StructLattes struct) {

    //primeiro, tentamos obter o id lattes
    final id_lattes = _search_id_lattes(struct);
    if (id_lattes < 0) {
      //se o id lattes for negativo, lancamos um erro
      throw IDNotFound();
    }

    

    return Curriculum(
      _search_id_lattes(struct),
      'last_update',
      []
    );
  }
}