import 'package:http/http.dart' as http;
import 'package:parry_front/core/lattes_entitys/people.dart';

void main() async {
  const address = '10.204.22.45:1323';
  final url = Uri.http(address,'pessoa');
  final pessoa = People('joão cagão', 22200445, ['CAGÃO, J.', 'CAGÃO, João'], 'Brasil');

  final response = await http.post(url,body: pessoa.json);
  print(response.statusCode);
}