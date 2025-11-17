String clean_spaces(String text) {
  final length = text.length;
  String text_clean = '';

  for(int i = 0; i<length;i++) {
    if(text[i] == ' ' && i+1 == length) {
      break;
    }

    if(text[i] == ' ' && text[i+1] == ' ') {
      text_clean += ' ';
      continue;
    }

    if(text[i] == ' ') {
      continue;
    }

    text_clean += text[i];
  }

  text_clean = text_clean.replaceAll('\t', ' ');

  return text_clean.trim();
}

String remove_points_chars(final String text) {
  const special_chars = [',','.',':',';'];
  String result = text;
  for(final c in special_chars) {
    result = result.replaceAll(c, '');
  }

  return result;
}

bool is_letter(String text) {
  return RegExp(r'^[a-zA-ZáàâãäéèêëíìîïóòôõöúùûüñçÁÀÂÃÄÉÈÊËÍÌÎÏÓÒÔÕÖÚÙÛÜÑÇ]$').hasMatch(text);
}

bool is_algarism(String text) {
  return RegExp(r'^[0-9]$').hasMatch(text);
}