import 'package:parry_front/core/lattes_entitys/production.dart';

class ProductionsByType {
  final TypeProduction type;
  final int total_productions;
  final Map<int,int> qtd_by_year;
  final int qtd_collaborators;

  const ProductionsByType(
    {
      required this.type,
      required this.total_productions,
      required this.qtd_by_year,
      required this.qtd_collaborators
    }
  );
}