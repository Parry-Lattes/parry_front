import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;

abstract class ApiInterface {
  static final address = dotenv.env['ADDRESS_BACK'];

  static Future<String> request_in(String path) async {
    print(address);
    final response = await http.get(_get_url(path));
    
    return response.body;
  }

  static Uri _get_url(String path) {return Uri.http('$address',path);}
}