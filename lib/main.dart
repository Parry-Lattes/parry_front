import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:parry_front/ui/app.dart';

void main(List<String> args) {
  dotenv.load(fileName: 'assets/env.env');
  runApp(const App());
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