import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;
import 'package:parry_front/core/api_interface/upload_data.dart';
import 'package:parry_front/core/lattes_entitys/curriculum.dart';
import 'package:parry_front/core/lattes_entitys/people.dart';
import 'package:parry_front/core/lattes_entitys/production.dart';

abstract class ApiInterface {
  static final address = dotenv.env['ADDRESS_BACK']; //o endereço base do backend
  static final client = http.Client();
  static String _csrf_cookie = 'bunda';
  static String _all_cookies = 'vagina';

  static Uri _get_url(String path) {return Uri.http('$address','v1/$path');}

  /*
   Recebe o objeto json decodado, e tenta transformar ele em um objeto People
   Caso algum problema ocorra, retorna null
   */
  static People? _json_to_people(Map<String,dynamic> json_people) {
    final String? name = json_people['nome'];
    final int? id_lattes = int.tryParse(json_people['id_lattes']);
    final List<dynamic>? json_abbreviations = json_people['abreviaturas'];
    final String? nationality = json_people['nacionalidade'];

    if(name == null) {return null;}
    if(id_lattes == null) {return null;}
    if(json_abbreviations == null) {return null;}
    if(nationality == null) {return null;}

    final List<String> abbreviations = [];

    for(final i in json_abbreviations) {
      try {
        abbreviations.add(i['abreviatura']);
      } on Exception {
        continue;
      }
    }

    return People(name, id_lattes, abbreviations, nationality);
  }

  /*
   Recebe como argumento o json que deve ser da produção, e tenta transformar
   em um objeto Production.
   Se falhar, retorna null
   */
  static Production? _json_to_production(Map<String,dynamic> json_production) {
    final String? title = json_production['titulo'];
    final String? autor = json_production['autor'];
    final String? date_pub = json_production['data_de_publicacao'];
    final String? string_type = json_production['tipo'];
    final List<dynamic>? json_coautors = json_production['coautores'];

    if(title == null) {return null;}
    if(autor == null) {return null;}
    if(date_pub == null) {return null;}
    if(json_coautors == null) {return null;}

    TypeProduction type = TypeProduction.other;
    switch(string_type) {
      case null:
        return null;
      case 'Bibliográfica':
        type = TypeProduction.bibliographic;
        break;
      case 'Técnica':
        type = TypeProduction.technique;
        break;
      case 'Patente':
        type = TypeProduction.patent;
    }

    final coautores = <String>[];

    for(final c in json_coautors) {
      try {
        dynamic b = c['abreviatura'];
        while(b is! String) {
          b = b['abreviatura'];
        }


        coautores.add(b);
      } on Exception {
        continue;
      }
    }

    return Production(autor, coautores, title, date_pub, type);
  }

  /*
   Recebe como argumento o id_lattes e o json que se supõe ser um currículo lattes.
   Tenta transformar o json em um objeto Curriculum, se falhar, retorna null
   */
  static Curriculum? _json_to_curriculum(int id_lattes,Map<String,dynamic> json_curriculum) {
    final String? last_update = json_curriculum['ultima_atualizacao'];
    final List<Production> productions = [];
    final List<dynamic>? json_productions = json_curriculum['producoes'];

    if(last_update == null) {return null;}
    if(json_productions == null) {return null;}

    for(final p in json_productions) {
      final production = _json_to_production(p);

      if(production != null) {
        productions.add(production);
      }
    }

    return Curriculum(id_lattes, last_update, productions);
  }

  static Map<String,String> get header_request => {
    'Content-Type': 'application/json; charset=UTF-8',
    'cookie': _all_cookies,
    'X-CSRF-Token': _csrf_cookie
  };

  /*
   Tenta logar no sistema. Se der algum problema, retorna o texto explicativo do problema.
   Caso contrário, retorna um texto vazio.
   */
  static Future<String> login(String email,senha) async {
    final response = await client.post(
      _get_url('login'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: '{"email": "$email","senha": "$senha"}'
    );

    if(response.statusCode == 400) {
      return 'Email ou senha inválidos';
    }

    final text_cookies = response.headers['set-cookie'];
    if(text_cookies == null) {
      return 'Resposta do servidor inválida';
    }

    final list_text_cookies = text_cookies.split(RegExp(r',(?=\s*[^;]+=)'));

    for(final text_cookie in list_text_cookies) {
      final cookie = Cookie.fromSetCookieValue(text_cookie);
      if(cookie.name == 'csrf_cookie') {
        _csrf_cookie = cookie.value;
        _all_cookies = text_cookies;
        return '';
      }
    }

    return 'Resposta do servidor inválida';
  }

  /*
   Recebe como argumento a rota do backend que receberá a requisição
   Observe que isto é apenas para rotas que não precisam de bodys,
   uma vez que a função só precisa da rota.
   Retorna uma String com o corpo do resultado
   */
  static Future<(String,int)> request_in(String path) async {
    final response = await client.get(
      _get_url(path),
      headers: header_request
    );
    
    return (response.body,response.statusCode);
  }

  
  //retorna um objeto de upload, específico para a rota de pessoas
  static UploadData get upload_people => UploadData(uri: _get_url('pessoas'));

  //retorna um objeto de upload, mas dessa vez para os currículos
  static UploadData upload_curriculum(int id_lattes) { return UploadData(uri: _get_url('pessoas/$id_lattes/curriculo')); }

  static Future delete_data(int id_lattes) async {
    await client.delete(headers: header_request,_get_url('pessoas/$id_lattes'));
  }

  /*
   Solicita ao backend todas as pessoass registradas
   Caso haja alguma falha, retorna uma lista vazia.
   Mas também pode ser que retorne uma lista vazia caso não haja nada no banco de dados :)
   */
  static Future<List<People>> request_all_people() async {
    final (result,code) = await request_in('pessoas');
    List<People> peoples = [];

    for(final i in jsonDecode(result)) {
      final people = _json_to_people(i);

      if(people != null) {
        peoples.add(people);
      }
    }

    return peoples;
  }

  /*
   Recebe como argumento um id_lattes, e solicita para o backend os dados da pessoas
   correspondente ao id_lattes.
   Caso nenhum dado seja encontrado ou haja um problema na conversão para um objeto People, retorna null
   */
  static Future<People?> request_people(int id_lattes) async {
    final (result,code) = await request_in('pessoas/$id_lattes');
    if(code != 200) {
      return null;
    }

    return _json_to_people(jsonDecode(result));
  }

  /*
   Recebe como argumento um id lattes, e solicita para o backend o curriculo correspondente ao id
   Caso nada seja encontrado, ou haja problemas na conversão, retorna null
   */
  static Future<Curriculum?> request_curriculum(int id_lattes) async {
    final (result,code) = await request_in('pessoas/$id_lattes/curriculo');

    if(code != 200) {return null;}

    return _json_to_curriculum(id_lattes, jsonDecode(result));
  }
}