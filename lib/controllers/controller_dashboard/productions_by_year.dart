
/*
 Objeto que representa as estatísticas de produções em um ano específico
 O campo year informa o ano sobre o qual os dados são referentes
 O campo total_productions informa quantas produções foram publicadas naquele ano
 O campo qtd_collaborators representa quantas pessoa fizeram alguma publicação no ano
 O demais campos representam a quantidade de produções de um tipo específico no ano
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