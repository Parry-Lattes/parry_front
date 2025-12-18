import 'package:flutter/material.dart';
import 'package:parry_front/controllers/controller_dashboard/controller_dashboard.dart';
import 'package:parry_front/controllers/controller_dashboard/productions_by_type.dart';
import 'package:parry_front/controllers/controller_dashboard/productions_by_year.dart';
import 'package:parry_front/core/lattes_entitys/production.dart';
import 'package:parry_front/ui/colors_app.dart';
import 'package:parry_front/ui/dashboard/dialog_filter.dart';
import 'package:parry_front/ui/my_widgets/reautentication_dialog.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ViewGraphics extends StatefulWidget {
  final ControllerDashboard controller;
  final List<Future Function()> reloads;

  const ViewGraphics({super.key, required this.controller, required this.reloads});

  @override
  State<StatefulWidget> createState() => _ViewGraphics();
}

class _ViewGraphics extends State<ViewGraphics> with AutomaticKeepAliveClientMixin {
  bool _loading = true;
  TypeFilter? _type_filter;
  ProductionsByYear _year_filter = const ProductionsByYear(year: 0, total_productions: 0, qtd_collaborators: 0, qtd_bibliographic: 0, qtd_technique: 0, qtd_patent: 0, qtd_other: 0);
  ProductionsByType _production_filter = const ProductionsByType(type: TypeProduction.other, total_productions: 0, qtd_by_year: {});

  @override
  bool get wantKeepAlive => true;

  Widget _make_graphics() {
    switch(_type_filter) {
      case TypeFilter.type:
        List<({int year, int qtd})> points = [];

        for(final y in _production_filter.qtd_by_year.entries) {
          points.add((year: y.key,qtd: y.value));
        }

        return SfCartesianChart(
          title: ChartTitle(text: 'Produções a cada ano do tipo ${_production_filter.type.text_type}',textStyle: TextStyle(color: ColorsApp.grey1.color,fontWeight: FontWeight.bold)),
          tooltipBehavior: TooltipBehavior(
            enable: true,
            textStyle: TextStyle(color: ColorsApp.grey1.color)
          ),
          //legend: Legend(isVisible: true,textStyle: TextStyle(color: ColorsApp.grey1.color)),

          primaryXAxis: CategoryAxis(labelStyle: TextStyle(color: ColorsApp.grey1.color),),
          series: <LineSeries<({int year, int qtd}),int>>[
            LineSeries<({int year, int qtd}),int>(
              dataSource: points,
              xValueMapper: (({int year, int qtd}) p, _) => p.year,
              yValueMapper: (({int year, int qtd}) p, _) => p.qtd,
              dataLabelSettings: DataLabelSettings(isVisible: true,color: ColorsApp.grey1.color),
            )
          ],
        );
      case TypeFilter.year:
        List<({TypeProduction type, int qtd})> points = [
          (type: TypeProduction.bibliographic, qtd: _year_filter.qtd_bibliographic),
          (type: TypeProduction.technique, qtd: _year_filter.qtd_technique),
          (type: TypeProduction.patent, qtd: _year_filter.qtd_patent),
          (type: TypeProduction.other, qtd: _year_filter.qtd_other),
        ];

        return Padding(
          padding: const EdgeInsetsGeometry.all(30),
          child: Row(
            children: [
              Expanded(
                child: SfCircularChart(
                  title: ChartTitle(text: 'Produções por tipo em ${_year_filter.year}', textStyle: TextStyle(color: ColorsApp.grey1.color,fontWeight: FontWeight.bold)),
                  legend: Legend(isVisible: true,textStyle: TextStyle(color: ColorsApp.grey1.color)),
                  series: <PieSeries<({TypeProduction type, int qtd}),String>>[
                    PieSeries(
                      explode: true,
                      explodeIndex: 0,
                      dataSource: points,
                      xValueMapper: (({TypeProduction type, int qtd}) data,_) => data.type.text_type,
                      yValueMapper: (({TypeProduction type, int qtd}) data,_) => data.qtd,
                      dataLabelSettings: DataLabelSettings(
                        isVisible: true,
                        textStyle: TextStyle(color: ColorsApp.grey1.color)
                      ),
                    )
                  ],
                )
              ),
              VerticalDivider(width: 2,color: ColorsApp.grey2.color,),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10,
                    children: [
                      Text(
                        'Total de colaboradores daquele ano:',
                        style: TextStyle(
                          fontSize: 18,
                          color: ColorsApp.grey1.color,
                        ),
                      ),
                      Text(
                        '${_year_filter.qtd_collaborators}',
                        style: TextStyle(
                          fontSize: 50,
                          color: ColorsApp.grey1.color,
                          fontWeight: FontWeight.bold
                        )
                      )
                    ],
                  ),
                )
              )
            ],
          ),
        );

      case null:
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
                      legend: Legend(isVisible: true, textStyle: TextStyle(color: ColorsApp.grey1.color)),
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
  }

  void _select_filter() {
    showDialog(
      context: context,
      builder: (BuildContext c) {
        

        return Dialog(
          constraints: const BoxConstraints(
            maxHeight: 290,
            maxWidth: 290,
          ),
          backgroundColor: ColorsApp.grey2.color,
          child: DialogFilter(controller: widget.controller),
        );
      }
    ).then(
      (result) {
        if(result is ProductionsByYear) {
          _year_filter = result;
          setState(() {
            _type_filter = TypeFilter.year;
          });
          return;
        }

        if(result is ProductionsByType) {
          _production_filter = result;
          setState(() {
            _type_filter = TypeFilter.type;
          });

          return;
        }

        if(result == false) {
          setState(() {
            _type_filter = null;
          });
        }
      }
    );
  }

  @override
  void initState() {
    super.initState();
    print('a');

    widget.reloads.add(() async  {
      setState(() {
        _loading = true;
      });
    });

    widget.controller.controller_action_button.action = _select_filter;
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
        },
        onError: (e) {
          reautentication(context, e);
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
        : widget.controller.numbers_totais.$1 >= 1
          ? _make_graphics()
          : Text(
            'Não existem dados para plotar gráficos',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 70,
              color: ColorsApp.grey1.color,
              fontWeight: FontWeight.bold
            ),
          )
    );
  }
}