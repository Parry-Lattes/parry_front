import 'package:puppeteer/puppeteer.dart';

abstract class Navigator {
  static late Browser _browser;
  static Future init_navigator([String? init_url]) async {
    _browser = await puppeteer.launch(
      headless: false,
      executablePath: 'assets/executable/chrome-linux/chrome',
    );

    if(init_url == null) {return;}

    final home_page = await _browser.newPage();
    home_page.goto(init_url);
  }

  static Future<List<Page>> get pages async {
    return _browser.pages;
  }
}