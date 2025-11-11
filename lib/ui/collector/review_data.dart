
import 'package:flutter/material.dart';
import 'package:parry_front/core/scrapper/extractor/extractor.dart';
import 'package:parry_front/ui/collector/spreadsheet/spreadsheet.dart';

class ReviewData extends StatelessWidget {
  final List<Extractor> structs;
  const ReviewData({super.key,required this.structs});

  @override
  Widget build(BuildContext context) {
    final List<Spreadsheet> spreads = List.empty(growable: true);
    for(final s in structs) {
      spreads.add(Spreadsheet(extractor: s));
    }

    return ListView(
      children: spreads,
    );
  }

}

// import 'package:flutter/material.dart';

// class ReviewData extends StatefulWidget {
//   final String text;
//   const ReviewData({super.key,required this.text});

//   @override
//   State<StatefulWidget> createState() => _ReviewData();
// }

// class _ReviewData extends State<ReviewData> {



//   @override
//   Widget build(BuildContext context) {
//     throw Text(widget.text);
//   }
// }