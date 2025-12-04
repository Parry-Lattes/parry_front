/*
 Objeto que representa os dados que serão usados pelo dashboard
 Por hora está guardando valores prontos
 */
class StructData {
  late int number_of_people;
  late int number_of_productions;
  late int qtd_updated;
  late Map<int,Map<String,int>> details;

  StructData(
    [
      int _number_of_people = 0,
      _number_of_productions = 0,
      _qtd_updated = 0,
      Map<int,Map<String,int>>? _details
    ]
  ) {
    number_of_people = _number_of_people;
    number_of_productions = _number_of_productions;
    qtd_updated = _qtd_updated;

    if(_details == null) {
      details = {};
    } else {
      details = _details;
    }
  }
}