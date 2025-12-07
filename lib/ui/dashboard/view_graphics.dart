import 'package:flutter/material.dart';
import 'package:parry_front/controllers/controller_dashboard/controller_dashboard.dart';
import 'package:parry_front/controllers/controller_dashboard/productions_by_type.dart';
import 'package:parry_front/controllers/controller_dashboard/productions_by_year.dart';
import 'package:parry_front/core/lattes_entitys/production.dart';
import 'package:parry_front/ui/colors_app.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ViewGraphics extends StatefulWidget {
  final ControllerDashboard controller;

  const ViewGraphics({super.key, required this.controller});

  @override
  State<StatefulWidget> createState() => _ViewGraphics();
}

class _ViewGraphics extends State<ViewGraphics> with AutomaticKeepAliveClientMixin {
  bool _loading = true;
  int? _year_filter;
  TypeProduction? _type_filter;

  @override
  bool get wantKeepAlive => true;

  Widget make_graphics() {
    if(_year_filter != null) {
      return const Text('oanerovre');
    }

    if(_type_filter != null) {
      return const Text('uonaovn');
    }

    return Column(
      spacing: 2,
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: SfCartesianChart(
                  title: ChartTitle(text: 'Produções a cada ano',textStyle: TextStyle(color: ColorsApp.grey1.color,fontWeight: FontWeight.bold)),
                  tooltipBehavior: TooltipBehavior(
                    enable: true,
                    textStyle: TextStyle(color: ColorsApp.grey1.color)
                  ),
                  //legend: Legend(isVisible: true,textStyle: TextStyle(color: ColorsApp.grey1.color)),

                  primaryXAxis: CategoryAxis(labelStyle: TextStyle(color: ColorsApp.grey1.color),),
                  primaryYAxis: CategoryAxis(labelStyle: TextStyle(color: ColorsApp.grey1.color),),
                  series: <LineSeries<ProductionsByYear,int>>[
                    LineSeries<ProductionsByYear,int>(
                      dataSource: widget.controller.productions_by_year,
                      xValueMapper: (ProductionsByYear p, _) => p.year,
                      yValueMapper: (ProductionsByYear p, _) => p.total_productions,
                      dataLabelSettings: DataLabelSettings(isVisible: true,color: ColorsApp.grey1.color),
                    )
                  ],
                )
              ),
              Expanded(
                child: SfCircularChart(
                  title: ChartTitle(text: 'Produções por tipo', textStyle: TextStyle(color: ColorsApp.grey1.color,fontWeight: FontWeight.bold)),
                  legend: Legend(isVisible: true,textStyle: TextStyle(color: ColorsApp.grey1.color)),
                  series: <PieSeries<ProductionsByType,String>>[
                    PieSeries(
                      explode: true,
                      explodeIndex: 0,
                      dataSource: widget.controller.productions_by_type,
                      xValueMapper: (ProductionsByType data,_) => data.type.text_type,
                      yValueMapper: (ProductionsByType data,_) => data.total_productions,
                      dataLabelSettings: DataLabelSettings(
                        isVisible: true,
                        textStyle: TextStyle(color: ColorsApp.grey1.color)
                      ),
                    )
                  ],
                )
              )
            ],
          )
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    Text(
                      'Media de produções por pessoa:',
                      style: TextStyle(
                        fontSize: 18,
                        color: ColorsApp.grey1.color,
                      ),
                    ),
                    Text(
                      '${widget.controller.numbers_totais.$2/widget.controller.numbers_totais.$1}',
                      style: TextStyle(
                        fontSize: 50,
                        color: ColorsApp.grey1.color,
                        fontWeight: FontWeight.bold
                      )
                    )
                  ],
                )
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    Text(
                      'Currículos atualizados nos últimos 3 meses:',
                      style: TextStyle(
                        fontSize: 18,
                        color: ColorsApp.grey1.color,
                      ),
                    ),
                    Text(
                      '${widget.controller.qtd_curriculums_updated}',
                      style: TextStyle(
                        fontSize: 50,
                        color: ColorsApp.grey1.color,
                        fontWeight: FontWeight.bold
                      )
                    )
                  ],
                )
              )
            ],
          )
        )
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if(_loading) {
       widget.controller.loading_data.then(
        (result) {
          if(result == true) {
            setState(() {
              _loading = false;
            });
          }
        }
      );
    }

    return Center(
      child: _loading
        ?SizedBox(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(
            color: ColorsApp.grey1.color,
          ),
        )
        :make_graphics()
    );
  }
}