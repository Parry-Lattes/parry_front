
/*
 * O objetivo e ter os dados de uma forma organzida nas classes
 * Esta em especifico organiza os dados relativos a um unico ano,
 * e contem informacoes quanto ao numero de producoes para cada tipo,
 * o numero de colaboratores e o total de producoes para aquele ano
 */
class ProductionsByYear {
  final int year;
  final int total_productions;
  final int qtd_collaborators;
  final int qtd_patent;
  final int qtd_bibliographic;
  final int qtd_technique;
  final int qtd_other;

  const ProductionsByYear(
    {
      required this.year,
      required this.total_productions,
      required this.qtd_collaborators,
      required this.qtd_bibliographic,
      required this.qtd_technique,
      required this.qtd_patent,
      required this.qtd_other
    }
  );
}