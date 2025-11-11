import 'package:flutter/material.dart';
import 'package:parry_front/core/scrapper/extractor/extractor.dart';
import 'package:parry_front/ui/collector/review_data.dart';
import 'package:parry_front/ui/collector/select_collector.dart';

class Collector extends StatefulWidget {
  const Collector({super.key});

  @override
  State<StatefulWidget> createState() => _Collector();
}

class _Collector extends State<Collector> with AutomaticKeepAliveClientMixin<Collector>{
  late Widget _child = SelectCollector(send_structs: _receiv_structs);
  int teste = 0;

  @override
  bool get wantKeepAlive => true;

  void _receiv_structs(List<Extractor> a) {
    setState(() {
      _child = ReviewData(structs: a);
      teste ++;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _child;
  }
}