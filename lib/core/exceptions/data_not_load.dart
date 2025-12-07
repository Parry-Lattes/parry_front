class DataNotLoad implements Exception {
  @override
  String toString() {
    return 'Espere os dados das tabelas carregarem. Verifique todas as planilhas!';
  }
}