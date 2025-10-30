import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';

class PDFScrapperUI extends StatelessWidget {
  const PDFScrapperUI({super.key});

  @override
  Widget build(BuildContext contexto) {
    return PdfViewer.asset(
            'assets/hello.pdf',
            params: PdfViewerParams(
             
            ),
          );
  }
}