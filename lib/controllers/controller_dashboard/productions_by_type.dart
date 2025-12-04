import 'package:parry_front/core/lattes_entitys/production.dart';

/*
 Objeto que representa os dados referentes a um tipo específico de produção.
 O campo total_productions informa quantas produções daquele tipo existem no total
 O campo qtd_by_year é um mapa de um int que respresenta os anos para um int que representa
 a quantidade de produções do tipo referido naquele ano.
 Obviamente, type é o tipo de produção da qual estamos falando
 */
class ProductionsByType {
  final TypeProduction type;
  final int total_productions;
  final Map<int,int> qtd_by_year;

  const ProductionsByType(
    {
      required this.type,
      required this.total_productions,
      required this.qtd_by_year
    }
  );
}