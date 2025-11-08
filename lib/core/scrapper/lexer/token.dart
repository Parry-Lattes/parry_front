class Token{
  final TypeToken type;
  final dynamic value;

  const Token({required this.type,this.value});
}

enum TypeToken {word,pointer,number}