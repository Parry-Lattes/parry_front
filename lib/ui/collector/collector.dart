import 'package:flutter/material.dart';
import 'package:parry_front/ui/collector/select_collector.dart';

class Collector extends StatefulWidget {
  const Collector({super.key});

  @override
  State<StatefulWidget> createState() => _Collector();
}

class _Collector extends State<Collector> {

  @override
  Widget build(BuildContext context) {
    return SelectCollector();
  }
}