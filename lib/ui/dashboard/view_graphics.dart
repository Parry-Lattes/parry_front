import 'package:flutter/material.dart';
import 'package:parry_front/controllers/controller_dashboard/controller_dashboard.dart';
import 'package:parry_front/ui/colors_app.dart';

class ViewGraphics extends StatefulWidget {
  final ControllerDashboard controller;

  const ViewGraphics({super.key, required this.controller});

  @override
  State<StatefulWidget> createState() => _ViewGraphics();
}

class _ViewGraphics extends State<ViewGraphics> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'anefoianerovr',
        style: TextStyle(color: ColorsApp.grey1.color),
      ),
    );
  }
}