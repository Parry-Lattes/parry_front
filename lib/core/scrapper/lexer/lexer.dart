import 'package:parry_front/core/scrapper/lexer/token.dart';

class Lexer {
  int counter = 0;
  
  bool _is_number(String letter) {return RegExp(r'^\d$').hasMatch(letter);}
  bool _is_letter(String letter) {return RegExp(r'^[a-zA-Z]$').hasMatch(letter);}
  bool _is_pointer(String letter) {return ['.',',',';',':'].contains(letter);}

  List<Token> tokenize(String text) {
    final List<Token> list_tokens = List.empty(growable: true);
    String word = '';

    for(counter = 0; counter < text.length; counter++) {
      final letter = text[counter];
      if(letter == '') {
        continue;
      }

      if(_is_number(letter)) {
        word += letter;
      } else if(_is_letter(letter)) {

      } else {

      }
    }

    

    return list_tokens;
  }
}