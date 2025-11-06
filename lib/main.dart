import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parry_front/ui/app.dart';

void main(List<String> args) {
  Intl.defaultLocale = 'pt_BR';
  runApp(App());
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