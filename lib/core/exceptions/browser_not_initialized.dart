class BrowserNotInitialized implements Exception {
  
  @override
  String toString() {
    return 'Não foi possível inicializar o navegador. Verifique se ele está instalado e se o ParryLattes possui permissão para executa-lo.';
  }
}