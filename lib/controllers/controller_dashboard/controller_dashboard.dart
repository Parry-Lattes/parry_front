import 'package:parry_front/controllers/controller_dashboard/productions_by_type.dart';
import 'package:parry_front/controllers/controller_dashboard/productions_by_year.dart';
import 'package:parry_front/controllers/controller_dashboard/struct_data.dart';
import 'package:parry_front/core/lattes_entitys/production.dart';

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
    final qtd_bibliographic = productions_year["Bibliográfica"];
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

  ProductionsByType _get_productions_by_type(TypeProduction type) {
    int total_productions = 0;
    Map<int,int> qtd_by_year = {};

    for (final entrie in data.details.entries) {
      final data_year = entrie.value;
      int? qtd_type_in_year = data_year[type.text_type];
      if(qtd_type_in_year == null) {continue;}

      total_productions += qtd_type_in_year;
      qtd_by_year[entrie.key] = qtd_type_in_year;
    }

    return ProductionsByType(
      type: type,
      total_productions: total_productions,
      qtd_by_year: qtd_by_year,
    );
  }

  List<ProductionsByType> get productions_by_type {
    final list_data = List<ProductionsByType>.empty(growable: true);

    list_data.add(_get_productions_by_type(TypeProduction.bibliographic));
    list_data.add(_get_productions_by_type(TypeProduction.technique));
    list_data.add(_get_productions_by_type(TypeProduction.patent));
    list_data.add(_get_productions_by_type(TypeProduction.other));

    return list_data;
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

  int get year_highest_production {
    int highest_value = 0;
    int year_highest_production = 0;
    for (final entrie in data.details.entries) {
      final year = entrie.key;
      final value = entrie.value['total_producoes'];
      if(value == null) {
        continue;
      }
      if(value > highest_value) {
        year_highest_production = year;
        highest_value = value;
      }
    }

    return year_highest_production;
  }

  Future<bool> get loading_data async {
    await Future.delayed(Duration(seconds: 3)); //um pequeno delay
    
    return true;
  }
}