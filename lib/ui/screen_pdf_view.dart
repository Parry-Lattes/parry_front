import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';

class ScreenPdfView extends StatelessWidget {
  final String pdf_path;
  const ScreenPdfView({super.key,required this.pdf_path});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirme o arquivo'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context,false);
            },
            icon: const Icon(Icons.close),
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context,true);
            },
            icon: const Icon(Icons.check)
          ),
        ],
      ),
      body: PdfViewer.asset(
              pdf_path,
              params: const PdfViewerParams(),
            ),
    );
  }
}