import 'package:parry_front/controllers/controller_dashboard/productions_by_year.dart';
import 'package:parry_front/controllers/controller_dashboard/struct_data.dart';

class ControllerDashboard {
  StructData data = StructData();

  (int,int) get numbers_totais => (data.number_of_people,data.number_of_productions);
  List<ProductionsByYear> get productions_by_year {
    for(final entry in data.details.entries) {
      final year = entry.key;
      final value = entry.value;
      final total_productions = value["total_producoes"];
      final qtd_
      
    }
  }

  Future<bool> get loading_data async {
    await Future.delayed(Duration(seconds: 3)); //um pequeno delay
    
    return true;
  }
}