import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;
import 'package:parry_front/core/api_interface/upload_data.dart';

abstract class ApiInterface {
  static final address = dotenv.env['ADDRESS_BACK']; //o endereço base do backend

  /*
   Recebe como argumento a rota do backend que receberá a requisição
   Observe que isto é apenas para rotas que não precisam de bodys,
   uma vez que a função só precisa da rota.
   Retorna uma String com o corpo do resultado
   */
  static Future<String> request_in(String path) async {
    final response = await http.get(_get_url(path)); 
    
    return response.body;
  }

  static Uri _get_url(String path) {return Uri.http('$address',path);}

  //retorna um objeto de upload, específico para a rota de pessoa
  static UploadData get upload_people => UploadData(uri: _get_url('pessoa'));

  //retorna um objeto de upload, mas dessa vez para os currículos
  static UploadData upload_curriculum(int id_lattes) { return UploadData(uri: _get_url('pessoa/$id_lattes/curriculo')); }
}