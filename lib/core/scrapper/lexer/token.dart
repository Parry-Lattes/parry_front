class Token {
  final TypeToken type;
  final dynamic value;

  const Token({required this.type,this.value});

  @override
  bool operator ==(Object other) {
    if(other is! Token) {
      return false;
    }

    return other.type == type && other.value == value;
  }
}

/*
 * Word: um conjunto qualquer de letras consecutivas
 * Pointer: pontos como , . : ;
 * Number: obviamente numeros, mas aqui nao trabalhamos
 * com numero negativos ou decimais, nao tem necessidade
 * Separator: separadores como parenteses e barras
 * Other: qualquer caractere que nao se enquadre nestas descricoes
 * End: final do texto
 */
enum TypeToken {word,pointer,colon,semicolon,number,hifen,separator,other,end}