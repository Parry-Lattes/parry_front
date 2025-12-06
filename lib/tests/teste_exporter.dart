import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:parry_front/core/exporter/exporter_all_productions.dart';
import 'package:parry_front/core/exporter/exporter_peoples.dart';
import 'package:parry_front/core/exporter/exporter_productions_of_people.dart';

void main() {
  teste_exporter_all_productions();
}

void teste_exporter_peoples() async {
  await dotenv.load(fileName: 'assets/env.env');
  ExporterPeoples().export('./testes/tabela.csv');
}

void teste_exporter_productions_of_people() async {
  await dotenv.load(fileName: 'assets/env.env');
  ExporterProductionsOfPeople(id_lattes: 2728505343212613).export('./testes/tabela.csv');
}

void teste_exporter_all_productions() async {
  await dotenv.load(fileName: 'assets/env.env');
  ExporterAllProductions().export('./testes/tabela.csv');
}