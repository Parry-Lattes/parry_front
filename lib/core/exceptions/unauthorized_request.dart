class UnauthorizedRequest implements Exception {
  @override
  String toString() {
    return 'Sessão expirada, faça login novamente!!';
  }
}