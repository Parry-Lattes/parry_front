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

  return text_clean;
}