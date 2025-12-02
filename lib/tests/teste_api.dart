import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:parry_front/core/api_interface/api_interface.dart';

void main() async {
  await dotenv.load(fileName: 'assets/env.env');
  print(await ApiInterface.request_in(''));
}