import 'package:flutter/material.dart';
import 'package:parry_front/controllers/controller_dashboard/controller_dashboard.dart';
import 'package:parry_front/controllers/controller_dashboard/productions_by_year.dart';
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

    return Center(
      child: loading
        ?SizedBox(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(
            color: ColorsApp.black.color,
          ),
        )
        :Column(
          spacing: 2,
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: SfCartesianChart(
                      tooltipBehavior: TooltipBehavior(enable: true,color: ColorsApp.black.color),
                      legend: Legend(isVisible: true,textStyle: TextStyle(color: ColorsApp.black.color)),

                      primaryXAxis: CategoryAxis(),
                      series: <LineSeries<ProductionsByYear,int>>[
                        LineSeries<ProductionsByYear,int>(
                          dataSource: widget.controller.productions_by_year,
                          xValueMapper: (ProductionsByYear p, _) => p.year,
                          yValueMapper: (ProductionsByYear p, _) => p.total_productions,
                          dataLabelSettings: DataLabelSettings(isVisible: true,color: ColorsApp.black.color),
                        )
                      ],
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