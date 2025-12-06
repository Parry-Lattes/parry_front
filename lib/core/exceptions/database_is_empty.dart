class DatabaseIsEmpty implements Exception {
  @override
  String toString() {
    return 'Parece que o banco de dados do ParryLattes está vazio :(';
  }
}