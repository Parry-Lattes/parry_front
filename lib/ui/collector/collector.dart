import 'package:flutter/material.dart';
import 'package:parry_front/ui/collector/review_data.dart';
import 'package:parry_front/ui/collector/select_collector.dart';

class Collector extends StatefulWidget {
  const Collector({super.key});

  @override
  State<StatefulWidget> createState() => _Collector();
}

class _Collector extends State<Collector> {
  final List<Widget> _panels = List.empty(growable: true);
  int _index_panel = 0;

  @override
  void initState() {
    super.initState();

    _panels.addAll([SelectCollector(set_panel: _set_panel,),ReviewData()]);
  }

  void _set_panel(int i) {
    setState(() {
      _index_panel = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _panels[_index_panel];
  }
}