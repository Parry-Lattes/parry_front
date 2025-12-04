import 'package:parry_front/core/scrapper/lexer/token.dart';

class ParserProduction {
  final List<Token> tokens;
  int _counter = -1;


  ParserProduction({required this.tokens});

  Token _current_token() {
    return tokens[_counter];
  }

  Token _next_token() {
    _counter++;
    return tokens[_counter];
  }

  Token _spy_token() {
    return tokens[_counter+1];
  }

  bool _expect_token(TypeToken t) {
    return _spy_token().type == t;
  }

  String _parse_abbreviation(String word) {

    //se o proximo token for um ponto e virgula, sabemos que nem precisamos verificar nada
    //apenas retornar
    if(_expect_token(TypeToken.semicolon)) {
      return word;
    }

    //se for uma virgula, um pouto e virgula ou um hifen, sabemos que pode fazer parte do nome
    if(_expect_token(TypeToken.colon) || _expect_token(TypeToken.word) || _expect_token(TypeToken.hifen)) {
      //se for, nos adicionamos ele ao conteudo da palavra
      //mas, a posicao do espaco em branco depende de ser uma palavra ou a virgula
      if(_expect_token(TypeToken.colon)) {
        word += _parse_abbreviation('${_next_token().value} ');
      } else if(_expect_token(TypeToken.word)){
        word += _parse_abbreviation(' ${_next_token().value}');
      } else {
        word += _parse_abbreviation('${_next_token().value}');
      }
    }

    //mas, se o proximo token for um ponto, e este for uma palavra
    if(_expect_token(TypeToken.pointer) && _current_token().type == TypeToken.word) {
      //testamos se a palavra do token atual tem apenas uma letra
      if(_current_token().value.length == 1) {
        word += _parse_abbreviation('${_next_token().value} ');
      }
    }

    return word;
  }

  List<String> _parse_coautores() {
    List<String> coautores = List.empty(growable: true); //crio a lista de autores de autemao

    while(_spy_token().type == TypeToken.word) { //se o proximo token for uma palava, e um novo nome de autor
      coautores.add(_parse_abbreviation(_next_token().value));

      //se apos a analise, verificarmos que o proximo token e um ponto e virgula
      if(_expect_token(TypeToken.semicolon)) {
        //entao, nos pulamos para o proximo token
        _next_token();
      }
    }

    return coautores;
  }

  String _parse_title() {
    String title = '';

    //se o pessoal do lattes fizesse um bom trabalho, e o titulo fosse delimitado por
    //aspas como no padrao abnt bonitinho, essa tarefa seria menos complexa
    //e menos propensa a erros
    while(!_expect_token(TypeToken.pointer) && !_expect_token(TypeToken.end)) {
      title += ' ${_next_token().value}';
    }

    return title.trim();
  }

  String _parse_date() {
    while(!_expect_token(TypeToken.number) && !_expect_token(TypeToken.end)) {
      _next_token();
    }

    if(_expect_token(TypeToken.number)) {
      int number = _next_token().value;

      if(number > 1900 && number <= DateTime.now().year) {
        return '$number';
      }

      return _parse_date();
    }

    return '';
  }

  ({String autor,List<String> coautores, String title, String date_pub}) parse() {
    //como comeca pelos autores, vamos chamar o parser deles
    final coautores = _parse_coautores();
    final autor = coautores.removeAt(0);

    if(_expect_token(TypeToken.pointer)) {
      _next_token();
    }

    final title = _parse_title();
    final date = _parse_date();

    return (
      autor: autor,
      coautores: coautores,
      title: title,
      date_pub: date
    );
  }
}