class CurriculumNotFound implements Exception {
  @override
  String toString() {
    return 'Nenhum currículo correspondente ao ID Lattes fornecido foi encontrado';
  }
}