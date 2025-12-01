import 'package:parry_front/controllers/controller_dashboard/productions_by_year.dart';
import 'package:parry_front/controllers/controller_dashboard/struct_data.dart';

class ControllerDashboard {
  StructData data = StructData();

  (int,int) get numbers_totais => (data.number_of_people,data.number_of_productions);
  
  /*
   
   */
  ProductionsByYear? _get_productions_by_year(int year) {
    final productions_year = data.details[year];
    if (productions_year == null) {return null;}

    final total_productions = productions_year["total_producoes"];
    final qtd_collaborators = productions_year["qtd_contribuintes"];
    final qtd_bibliographic = productions_year["Bibliográficas"];
    final qtd_technique = productions_year["Técnica"];
    final qtd_patent = productions_year["Patente"];
    final qtd_other = productions_year["Outro"];

    if (total_productions == null) {return null;}
    if (qtd_collaborators == null) {return null;}
    if (qtd_bibliographic == null) {return null;}
    if (qtd_technique == null) {return null;}
    if (qtd_patent == null) {return null;}
    if (qtd_other == null) {return null;}

    return ProductionsByYear(
      year: year,
      total_productions: total_productions,
      qtd_collaborators: qtd_collaborators,
      qtd_bibliographic: qtd_bibliographic,
      qtd_technique: qtd_technique,
      qtd_patent: qtd_patent,
      qtd_other: qtd_other
    );
  }

  List<ProductionsByYear> get productions_by_year {
    final list_data = List<ProductionsByYear>.empty(growable: true);
    
    for(final year in data.details.keys) {
      final data_production_year = _get_productions_by_year(year);
      if (data_production_year != null) {
        list_data.add(data_production_year);
      } else {
        print('vaaoinfviaern');
      }
    }

    return list_data;
  }

  Future<bool> get loading_data async {
    await Future.delayed(Duration(seconds: 3)); //um pequeno delay
    
    return true;
  }
}