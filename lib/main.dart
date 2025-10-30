import 'package:flutter/material.dart';
import 'package:parry_front/ui/screen_login.dart';
import 'package:parry_front/ui/screen_pdf_scrapper.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    theme: ThemeData.dark(),
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