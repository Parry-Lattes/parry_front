DateTime? string_to_date(String string_date) {

  //para desencargo de consciencia: isso e codigo de IA
  try {
    if (string_date.contains('/')) {
      List<String> parts = string_date.split('/');
      if (parts[0].length == 4) {
        // Formato AAAA/MM/DD
        return DateTime(int.parse(parts[0]), int.parse(parts[1]), int.parse(parts[2]));
      } else {
        // Formato DD/MM/AAAA
        return DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
      }
    } else if (string_date.contains('-')) {
      List<String> parts = string_date.split('-');
      if (parts[0].length == 4) {
        // Formato AAAA-MM-DD
        return DateTime(int.parse(parts[0]), int.parse(parts[1]), int.parse(parts[2]));
      } else {
        // Formato DD-MM-AAAA
        return DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
      }
    } else if (string_date.contains('.')) {
      List<String> parts = string_date.split('.');
      if (parts[0].length == 4) {
        // Formato AAAA.MM.DD
        return DateTime(int.parse(parts[0]), int.parse(parts[1]), int.parse(parts[2]));
      } else {
        // Formato DD.MM.AAAA
        return DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
      }
    }
  } catch (e) {
    //apenas retorna nulo
  }
  return null;
}

String date_to_string(DateTime date) {
  var day = '${date.day}';
  var month = '${date.month}';

  if (date.day < 10) {
    day = '0$day';
  }

  if(date.month < 10) {
    month = '0$month';
  }

  return '${date.year}-$month-$day';
}