class UnauthorizedRequest implements Exception {
  UnauthorizedRequest() {
    print('aoinvoiarno');
  }
  @override
  String toString() {
    return 'Sessão expirada, faça login novamente!!';
  }
}