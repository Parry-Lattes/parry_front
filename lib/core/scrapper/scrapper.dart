import 'package:parry_front/core/exceptions/id_not_found.dart';
import 'package:parry_front/core/exceptions/last_update_not_found.dart';
import 'package:parry_front/core/exceptions/name_not_found.dart';
import 'package:parry_front/core/lattes_entitys/curriculum.dart';
import 'package:parry_front/core/lattes_entitys/people.dart';
import 'package:parry_front/core/lattes_entitys/production.dart';
import 'package:parry_front/core/scrapper/lexer/lexer.dart';
import 'package:parry_front/core/scrapper/parser_production.dart';
import 'package:parry_front/core/scrapper/struct_lattes/struct_lattes.dart';
import 'package:parry_front/core/scrapper/struct_lattes/title.dart';
import 'package:parry_front/tools/convert_data.dart';
import 'package:parry_front/tools/text_tools.dart';

class Scrapper {
  final StructLattes struct;
  const Scrapper(this.struct);

  int _search_id_lattes() {
    //para obter o endereço lattes, que geralmente esta no começo do texto,
    //buscamos pela sequencia de palavras 'id lattes'
    //agora trataremos de cada um dos resultados obtidos
    for (var (i,l) in struct.search_lines(['id lattes'])) {
      //para facilitar tudo, vamos lidar apenas com letras minusculas
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
      } else {
        //se nao for o caso de estar na mesma linha, entao deve estar na proxima
        final next_line = struct.lines[i+1];
        final text_line = clean_spaces(next_line.text);

        if(text_line.length != 16) { //vericamos se o texto se encaixa no padrao
          return -1;
        }

        try {
          return int.parse(text_line); //tentamos retornar ele
        } on FormatException {
          continue;
        }
      }
    }

    //se tudo der errado, apenas retorna-mos -1, o resultado padrao para gerar erro
    return -1;
  }

  String _search_last_update() {
    //agora, basta usar regexp
    final regex = RegExp(r'\b\d{1,2}/\d{1,2}/\d{4}\b');
    

    for(var (_,l) in struct.search_lines(['última atualização'])) {
      //buscamos saber se a linha possui a expressao regular
      final result = regex.firstMatch(l);

      //se sim, vamos tentar retornar ela
      if(result != null) {
        try{
          var last_update = result.group(0)!.replaceAll('/', '-');
          last_update = date_to_string(string_to_date(last_update)!);
          return last_update;
        } catch (e) {
          continue;
        }
        
      }
    }

    return '';
  }

  String _search_name() {
    //buscamos pelos titulos de identificacao
    //dessa vez estamos interessados na posicao da linha, e nao em seu conteudo
    for(final (i,_) in struct.search_lines(['identificação'],only_title: true)) {
      //a partir dessa posicao, vamos buscar por nome nas linhas subsequentes
      //ate um maximo de 20 linhas
      final lines = struct.range_lines(i,i+20);
      //vamos contar quantas linhas ele vai precisar avancar
      int count = -1;
      for(final line in lines) {
        count ++;

        if(clean_spaces(line.text).toLowerCase() == 'nome') {
          return lines[count+1].text;
        }
      }
    }

    return '';
  }

  List<String> _colect_abbreviations(int start, int end) {
    final lines = struct.range_lines(start,end);
    String concat_lines = '';

    for(final l in lines) {
      concat_lines += '${l.text.replaceAll('\n', ' ')} ';
    }

    return concat_lines.trim().split(';');
  }

  List<String> _search_abbreviations() {
    //para encontrar a lista de citacoes, vamos primeiro saber onde ela comeca e onde ela termina
    int start = 0, end = 0;

    //procuramos pelo titulo que indica a identificacao
    for(final (i,_) in struct.search_lines(['identificação'],only_title: true)) {
      //nossa area de busca sera da identificacao mais 30 linhas
      final lines = struct.range_lines(i,i+30);

      //para encontrar o inicio, basta encontrar a palavra bibliograficas
      var count = -1; //vamos contar quantas linhas se passam
      for(final l in lines) {
        count++;
        if(clean_spaces(l.text).toLowerCase().contains('bibliográficas')) {
          start = i+count+1;
          break;
        }
      }

      count = 0; //resetamos a contagem

      //agora que encontramos o começo, podemos achar o fim
      //start-i vai achar a posicao em que o contador estava antes de ser resetado
      for(final l in lines.sublist(start-i)) {
        count++;
        if(l.text.toLowerCase() == 'lattes id') {
          end = start + count-1;
          break;
        }
      }
    }

    //print("start: $start, end: $end");
    return _colect_abbreviations(start, end);
  }

  String _search_nacionality() {
    final titles = struct.search_lines(['identificação'],only_title: true);

    for(var (i,_) in titles) {
      //agora vamos pegar as 10 linhas apos o titulo
      final lines = struct.range_lines(i,i+20);

      int count = -1;
      for(final line in lines) {
        count++;
        if(clean_spaces(line.text).toLowerCase().contains('nacionalidade')) {
          return lines[count+1].text;
        }
      }
    }

    return 'Brasil';
  }

  Production? _scrapping_production(String text_production, TypeProduction type_producition) {
    //print(text_production);
    final lexer = Lexer(text: text_production);
    final parser = ParserProduction(tokens: lexer.tokenize());

    final informations = parser.parse();

    final title = informations.title;
    final autor = informations.autor;
    final coautores = informations.coautores;
    final data_pub = informations.date_pub;

    //agora, umas verificacoes
    if(title == '') {return null;}
    if(autor == '') {return null;}
    if(data_pub == '') {return null;}

    coautores.sort();

    return Production(autor, coautores, title, data_pub, type_producition);
  }

  List<Production> _search_productions() {
    final List<Production> list_productions = List.empty(growable: true);
    String text_production = '';
    TypeProduction type_production = TypeProduction.other;

    int counter = 0;//essa variavel vai ser util para contar as producoes
    for(final (i,_) in struct.search_lines(['produções','patente'],only_title: true)) {
      for(final line in struct.range_lines(i)) {
        if(line is Title && !line.text.contains('produç') && !line.text.contains('patente') && !line.text.contains('produto')) {
          //caso a linha seja um titulo, verificamos se ela nao indica o tipo de producao, ou se e uma patente
          //se nao, significa que e um titulo de outra natureza, e assim, finalizamos a busca por producoes
          final production = _scrapping_production(text_production.trim(),type_production);
          if(production != null) {
            list_productions.add(production);
          }
          text_production = '';
          counter = 0;
          break;
        } else if(line is Title) {

          //aqui vamos verificar o tipo de producao
          //esse codigo e bem passivel de erros
          final text_ = clean_spaces(line.text).toLowerCase();
          if(text_.contains('bibliográfica')) {
            type_production = TypeProduction.bibliographic;
          } else if(text_.contains('técnica')) {
            type_production = TypeProduction.technique;
          } else if(text_.contains('patente')) {
            type_production = TypeProduction.patent;
          } else {
            type_production = TypeProduction.other;
          }
        }

        //em minhas observações, toda producao e precedida de uma numeracao
        try {
          //entao, eu vou focar transformas a linha em um numero, se gerar um erro, ele vai simplesmente adicionar a linha
          final number_production = int.parse(clean_spaces(remove_points_chars(line.text)));

          //entao, primeiro, eu vou testar se o numero e diferente do proximo numero da numeracao
          if(number_production != counter+1) {
            //se for, vou testar se ele e diferente de 1
            if(number_production != 1) {
              //se for diferente de 1, significa uma grande quebra no padrao, provavalmente nao esta indicando uma nova producao
              //logo, devo apenas adicionar ao texto acumulado
              text_production += line.text;
              continue;
            }
          }

          //se chegou aqui, e passou em todos esses testes, significa que provavelmente finalizou o texto da producao acumulado
          counter = number_production;

          //agora que eu encontrei um numero que indica que ha uma producao, vou pegar as proximas linhas ate o proximo numero
          //entao, eu mando o texto da producao atual para a lista de producoes, apos procesar claro
          final production = _scrapping_production(text_production.trim(),type_production);
          if(production != null) {
            list_productions.add(production);
          }

          //a partir da proxima linha, ele vai capturar os textos novamente
          text_production = '';
          continue;
        } on FormatException {
          text_production += '${line.text} ';
        }
      }
    }

    return list_productions;
  }

  (Curriculum,People) scrapping() {

    //primeiro, tentamos obter o id lattes
    final id_lattes = _search_id_lattes();
    if (id_lattes < 0) {
      //se o id lattes for negativo, lancamos um erro
      throw IDNotFound();
    }

    //buscamos a data de ultima atualizacao
    final last_update = _search_last_update();
    if(last_update == '') {
      throw LastUpdateNotFound();
    }

    //agora vamos procurar pelo nome
    final name = _search_name();
    if(name == '') {
      throw NameNotFound();
    }

    //procuramos pelas abreviacoes
    final abbreviations = _search_abbreviations();

    //buscando pela nacionalidade
    final nacionality = _search_nacionality();

    //e finalmente, coleto as producoes
    final productions = _search_productions();

    return (
      Curriculum(
        id_lattes,
        last_update,
        productions
      ),
      People(
        name, 
        id_lattes,
        abbreviations,
        nacionality
      )
    );
  }
}