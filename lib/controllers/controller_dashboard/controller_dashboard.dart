import 'dart:convert';

import 'package:parry_front/controllers/controller_dashboard/productions_by_type.dart';
import 'package:parry_front/controllers/controller_dashboard/productions_by_year.dart';
import 'package:parry_front/controllers/controller_dashboard/struct_data.dart';
import 'package:parry_front/core/api_interface/api_interface.dart';
import 'package:parry_front/core/lattes_entitys/production.dart';

/*
 De uma forma muito lógica, isto é o controller para o widget do dashboard
 este controller se faz necessário para ser uma fonte centralizada de obtenção de informações
 */
class ControllerDashboard {
  StructData data = StructData();

  /*
   Retorna os valores das estatísticas gerais do dashboard. O primeiro número é a quantidade de pessoas
   cadastradas no banco de dados. O segundo número é a quantidade de produções cadastradas no banco de dados.
   */
  (int,int) get numbers_totais => (data.number_of_people,data.number_of_productions);
  int get qtd_curriculums_updated => data.qtd_updated;
  
  /*
   Função simples, que recebe como argumento o ano desejado e retorna a estrutura de estatísticas referentes aquele ano.
   Caso não haja, nos dados vindos do backend, o ano requisitado, o retorno da função é nulo
   */
  ProductionsByYear? _get_productions_by_year(int year) {
    final productions_year = data.details[year]; //efetivamento pegando o ano requisitado do atributo detalhes
    if (productions_year == null) {return null;}

    /*
     Agora, eu tento pegar cada dado individualemente de seus campos, que eu espero que existam.
     Depois eu verifico se cada um dos dados é diferente de nulo. Caso alguma informação esteja faltando,
     eu simplesmente retorno nulo
     */
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


  /*
   Método irmão de _get_productions_by_year, só que para o tipo de produção. Recebe como argumento
   um tipo de produção específico, e retorna as estatísticas referentes ao tipo de produção.
   Se nada for encontrado, a função só retorna um ProductionsByType com todos os dados igual a 0
   */
  ProductionsByType _get_productions_by_type(TypeProduction type) {
    int total_productions = 0; //tecnicamente, produções por tipo são mais simples, e possui menos campos
    Map<int,int> qtd_by_year = {};

    //procura os dados da produção em cada ano
    //caso encontre, soma o valor a variavel total_productions, e adiciona ao mapa
    //a relação de ano para valor
    for (final entrie in data.details.entries) {
      final data_year = entrie.value;
      int? qtd_type_in_year = data_year[type.text_type];
      if(qtd_type_in_year == null) {continue;}

      total_productions += qtd_type_in_year;
      qtd_by_year[entrie.key] = qtd_type_in_year;
    }


    //por fim, retorna o objeto de produção por tipo
    return ProductionsByType(
      type: type,
      total_productions: total_productions,
      qtd_by_year: qtd_by_year,
    );
  }

  //retorna a lista de produções por tipo. Ou seja, essa lista vai possuir apenas 4 elementos
  List<ProductionsByType> get productions_by_type {
    final list_data = List<ProductionsByType>.empty(growable: true);

    //basta eu pegar cada produção por tipo e adicionar a lista
    //muito simples
    list_data.add(_get_productions_by_type(TypeProduction.bibliographic));
    list_data.add(_get_productions_by_type(TypeProduction.technique));
    list_data.add(_get_productions_by_type(TypeProduction.patent));
    list_data.add(_get_productions_by_type(TypeProduction.other));

    return list_data;
  }

  //Retorna a lista de produções por ano.
  List<ProductionsByYear> get productions_by_year {
    final list_data = List<ProductionsByYear>.empty(growable: true);
    
    //itera sobre todas as chaves de datails
    for(final year in data.details.keys) {
      final data_production_year = _get_productions_by_year(year); //depois, pega os dados de details referente a chave
      if (data_production_year != null) { //caso o dado encontrado seja nulo, ele apenas ignora e continua
        list_data.add(data_production_year);
      }
    }

    return list_data;
  }

  //retorna o ano com maior número de produções
  int get year_highest_production {
    int highest_value = 0; //variável para controlar o maior número de produções enviadas no ano até agora
    int year_highest_production = 0; //guarda o ano com maior número de produções até agora

    //agora vamos iterar sobre cada um dos anos
    for (final entrie in data.details.entries) {
      final year = entrie.key;
      final value = entrie.value['total_producoes']; // pego o número de produções referentes ao ano
      if(value == null) {
        continue;
      }

      if(value > highest_value) { //verifico se o valor encontrado é maior que o maior valor
        // e caso seja, atualizo as informações
        year_highest_production = year;
        highest_value = value;
      }
    }

    return year_highest_production;
  }

  Map<int,Map<String,int>>? _get_detail(dynamic json_detail) {

    try {
      Map<int,Map<String,int>> result = {};

      for(MapEntry<String,dynamic> entry in json_detail.entries) { //vamos começar tentando iterar sobre os filhos do json
        int? year = int.tryParse(entry.key); //pegamos pegar a chave do ano, e converter para int
        if(year == null) { continue; } //se for nula, apenas continuamos

        Map<String,int> statistics = {};
        result[year] = statistics;
        for(MapEntry<String,dynamic> values in entry.value.entries) {
          if(values.value is! int) {
            statistics[values.key] = 0;
            continue;
          }
          statistics[values.key] = values.value;
        }
      }

      return result;
    } on Exception {
      return null;
    }
  }

  //carrega os dados para o atributo data. retorna true caso tudo tenha dado certo, e false se deu algum problema
  Future<bool> get loading_data async {
    var (result,status) = await ApiInterface.request_in('dashboard');

    if(status != 200) {
      return false;
    }

    dynamic result_json = jsonDecode(result);

    int qtd_curriculums = result_json['total_curriculos'];
    int qtd_productions = result_json['total_producoes'];
    int qtd_updated = result_json['curriculos_atualizados'];

    Map<int,Map<String,int>>? details = _get_detail(result_json['detalhes']);


    data = StructData(qtd_curriculums,qtd_productions,qtd_updated,details);
    
    return true;
  }
}