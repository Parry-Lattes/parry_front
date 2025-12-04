import 'dart:convert';

import 'package:http/http.dart' as http;


/*
 Uma classe para facilitar o processo de envio de dados
 Ela recebe, ainda na criação, a url a ser utilizada durante seu tempo de vida.
 Depois de criar o objeto de upload, você pode usar o método send_data para enviar os dados
 vez por vez 
 */
class UploadData {
  final Uri uri;

  const UploadData({required this.uri});

  /* 
   Recebe como argumento um objeto data, que deve ser um JSON com os dados a serem enviados.
   Por hora, retorna apenas um true para caso de sucesso e um false para caso de erro, mas
   pretende-se retornar o erro gerado em questão futuramente
   */
  Future<bool> send_data(String data) async {
    final response = await http.post(uri, headers: {'Content-Type': 'application/json; charset=UTF-8'}, body: data, encoding: utf8);

    if(response.body == 'null') {
      return true;
    }

    return false;
  }
}