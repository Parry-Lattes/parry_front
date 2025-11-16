import 'package:puppeteer/puppeteer.dart';

abstract class WebNavigator {
  /*
   * O objetivo desta classe e fornecer uma forma de acessar as paginas da internet
   * O Parry Lattes necessita de uma forma rapida de conseguir os curriculos.
   * A forma mais rapida e acessivel seria por meio do site de busca textual do Curriculo Lattes
   * Portanto, e necessario uma WebView ou um browser para esta tarefa.
   * O grande problema e nao haver uma forma compativel com todas as plataformas desktop que sejam mais leves e nativas
   * do que literalmente iniciar um navegador novo e controlar ele.
   * Entao, recorremos a opcao que temos, um automatizador de navegador
   * com essa alternativa, temos um navegador inteiro dentro do programa,
   * controlado por uma ferramenta de programacao semelhante ao Sellenium.
   * 
   * Nao e a melhor das alternativas, mas e o que temos
   */

  static Browser? _browser; //essa variavel vai ser o controlador do navegador

  //inicia o navegador, que e um executavel local
  static Future init_navigator([String? init_url]) async {
    _browser = await puppeteer.launch(
      headless: false,
      executablePath: 'assets/executable/chrome-linux/chrome',
    );

    //ao iniciar, ele procura saber se foi fornecida uma url, se sim, ele vai para a url fornecida
    if(init_url == null) {return;}

    final home_page = (await _browser!.pages)[0];
    home_page.goto(init_url);
  }

  /*
   * O principal objetivo desse navegador e permitir a passagem pelo Captcha,
   * tornando assim possivel extrair as paginas html dos curriculos.
   * O que essa funcao faz e verificar se o titulo da pagina contem o texto fornecido
   * para a busca. Se sim, ela extrai o conteudo html da pagina e o adiciona a lista de htmls
   * Se o navegador ainda nao foi iniciado, a funcao retorna uma lista vazia
   */
  static Future<Map<String,String>> load_pages(String by_text) async {
    if(_browser == null) {return {};}

    final pages = await _browser!.pages;
    final result = <String,String>{};
    for(final p in pages) {
      final title = await p.title;
      final content = await p.content;

      if(title != null && content != null) {
        if(title.toLowerCase().contains(by_text.toLowerCase())) {
          result[title] = content;
        }
      }
    }

    return result;
  }

  static void close_navigator() async {
    if(_browser != null) {_browser!.close();}
  }
}