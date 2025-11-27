import 'package:flutter/material.dart';
import 'package:parry_front/controllers/controller_dashboard/controller_dashboard.dart';
import 'package:parry_front/ui/colors_app.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ViewGraphics extends StatefulWidget {
  final ControllerDashboard controller;

  const ViewGraphics({super.key, required this.controller});

  @override
  State<StatefulWidget> createState() => _ViewGraphics();
}

class _ViewGraphics extends State<ViewGraphics> {
  bool loading = true;

  @override
  Widget build(BuildContext context) {
    widget.controller.loading_data.then(
      (result) {
        if(result == true) {
          setState(() {
            loading = false;
          });
        }
      }
    );

    return loading
      ?Center(
        child: SizedBox(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(
            color: ColorsApp.black.color,
          ),
        ),
      )
      :Center(
        child: Column(
          spacing: 2,
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: SfCartesianChart(
                      
                    )
                  ),
                  Expanded(
                    child: Text(
                      'adnvaon',
                      style: TextStyle(color: ColorsApp.black.color),
                    )
                  )
                ],
              )
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'adnvaon',
                      style: TextStyle(color: ColorsApp.black.color),
                    )
                  ),
                  Expanded(
                    child: Text(
                      'adnvaon',
                      style: TextStyle(color: ColorsApp.black.color),
                    )
                  )
                ],
              )
            )
          ]
        )
      );
  }
}