import 'package:parry_front/core/scrapper/lexer/token.dart';
import 'package:parry_front/tools/text_tools.dart';

/*
 * Precisarei de um analisador lexico para
 * o scrapper de producoes. Isso vai facilitar o trabalho, alem
 * de estender as possibilidades futuras
 */
class Lexer {
  int _counter = -1;
  int _next = 0;
  final String text;

  Lexer({required this.text});
  
  String _next_char() {
    _counter++;
    _next++;


    if(_counter >= text.length) {return '';}
    return text[_counter];
  }

  String _current_char() {
    if(_counter >= text.length) {return '';}
    return text[_counter];
  }

  String _spy_char() {
    if(_next >= text.length) {return '';}
    return text[_next];
  }

  //assemble word
  Token ass_word() {
    String value = _current_char(); //inicializo a string de resultado
    while(is_letter(_spy_char())) {
      value += _next_char();
    }

    return Token(type: TypeToken.word, value: value);
  }

  //assemble number
  Token ass_number() {
    String text_number = _current_char();
    int value = 0; //inicializo a string de resultado
    while (is_algarism(_spy_char())) {
      text_number += _next_char(); //pego a proxima string
    }

    //isso e um caso muiiiito especial
    if(_spy_char() == '.') {
      try {
        if(is_algarism(text[_next+1])) {
          text_number += _next_char();

          //vou continuar o processo de catar os algarismos
          while (is_algarism(_spy_char())) {
            text_number += _next_char();
          }

          //entao, eu vou retonar um token de palavra,
          //pois para o scrapper, um numero decimal com ponto no meio do texto
          //e mais um problema do que qualquer coisa
          return Token(type: TypeToken.word,value: text_number);
        }
      } on RangeError {
        //bom, nesse caso, nao fazemos nada
      }
    }

    try {
      value = int.parse(text_number);
    } on FormatException {
      value = 0; //pelo nosso codigo, isso nunca deve acontecer
    }

    return Token(type: TypeToken.number, value: value);
  }

  List<Token> tokenize() {
    final List<Token> list_tokens = List.empty(growable: true);

    while(true) {
      final char = _next_char();
      if(char == '') {
        list_tokens.add(Token(type: TypeToken.end));
        break;
      }

      if(char == ' '){continue;}

      if(is_letter(char)) {
        list_tokens.add(ass_word());

        continue;
      }

      if(is_algarism(char)) {
        list_tokens.add(ass_number());

        continue;
      }

      if(char == '.') {
        list_tokens.add(Token(type: TypeToken.pointer,value: char));

        continue;
      }

      if(char == ',') {
        list_tokens.add(Token(type: TypeToken.colon,value: char));

        continue;
      }

      if(char == ';') {
        list_tokens.add(Token(type: TypeToken.semicolon,value: char));

        continue;
      }

      if(char == '-') {
        list_tokens.add(Token(type: TypeToken.hifen,value: char));

        continue;
      }

      if(RegExp(r'^[\(\)\/\\\[\]\{\}\-]$').hasMatch(char)) {
        list_tokens.add(Token(type: TypeToken.separator,value: char));

        continue;
      }

      list_tokens.add(Token(type: TypeToken.other, value: char));
    }

    return list_tokens;
  }
}