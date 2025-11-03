import 'package:flutter/material.dart';
import 'package:parry_front/ui/screen_login.dart';
import 'package:parry_front/ui/screen_pdf_scrapper.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    theme: ThemeData(
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: Color.fromRGBO(245, 245, 245, 1),
        secondary: Color.fromRGBO(39,29,44,1),
        error: Color.fromRGBO(224,31,63,1),
        surface: Color.fromRGBO(123,105,96,1),
        onError: Color.fromRGBO(255,255,255,1),
        onPrimary: Color.fromRGBO(245, 245, 245, 1),
        onSecondary: Color.fromRGBO(39,29,44,1),
        onSurface: Color.fromRGBO(245, 245, 245, 1)
      ),
    ),
    home: Login(),
    routes: <String, WidgetBuilder> {
      '/sla_porra': (BuildContext c) => PDFScrapperUI(),
    }
  )
  );
}

// import 'package:flutter/material.dart';
// import 'package:pdfrx/pdfrx.dart';

// void main() {
//   runApp(MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Pdfrx example'),
//         ),
//         body: PdfViewer.asset('assets/hello.pdf'),
//       ),
//     ));
// }