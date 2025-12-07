import 'package:flutter/material.dart';
import 'package:parry_front/controllers/controller_action_button.dart';
import 'package:parry_front/core/scrapper/extractor/extractor.dart';
import 'package:parry_front/ui/collector/review_data.dart';
import 'package:parry_front/ui/collector/select_collector.dart';
import 'package:parry_front/ui/my_widgets/action_button.dart';

class Collector extends StatefulWidget {
  Collector({super.key});

  final controller_upload_button = ControllerActionButton();

  List<Widget> get actions {
    return [ActionButton(controller: controller_upload_button,icon: Icons.cloud_upload,)];
  }

  @override
  State<StatefulWidget> createState() => _Collector();
}

class _Collector extends State<Collector> with AutomaticKeepAliveClientMixin<Collector>{
  late Widget _child = SelectCollector(send_structs: _receiv_structs);

  @override
  bool get wantKeepAlive => true;

  void _done_review_data() {
    setState(() {
      _child = SelectCollector(send_structs: _receiv_structs);
    });
  }

  void _receiv_structs(List<Extractor> a) {
    setState(() {
      _child = ReviewData(extrators: a,controller_upload_button: widget.controller_upload_button,done_review: _done_review_data);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _child;
  }
}