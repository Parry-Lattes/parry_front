import 'package:flutter/material.dart';
import 'package:parry_front/controllers/controller_dashboard/controller_dashboard.dart';
import 'package:parry_front/ui/colors_app.dart';

class ViewNumbersTotais extends StatefulWidget {
  final ControllerDashboard controller;
  const ViewNumbersTotais({super.key, required this.controller});

  @override
  State<StatefulWidget> createState() => _ViewNumbersTotais();
}

class _ViewNumbersTotais extends State<ViewNumbersTotais> with AutomaticKeepAliveClientMixin {
  bool loading = true;
  var number_of_people = 0;
  var number_of_productions = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    widget.controller.data.then(
      (data){
        setState(() {
          number_of_people = data.number_of_people;
          number_of_productions = data.number_of_productions;
          loading = false;
        });
      }
    );

    return loading
      ?Center(
        child: SizedBox(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(
            color: ColorsApp.black.color,
            value: null,
          ),
        ),
      )
      :Center(
        child: SizedBox(
          width: 400,
          height: 200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsetsGeometry.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10,
                    children: [
                      Text(
                        'Total de currículos cadastrados:',
                        style: TextStyle(
                          fontSize: 15,
                          color: ColorsApp.grey1.color,
                        ),
                      ),
                      Text(
                        '$number_of_people',
                        style: TextStyle(
                          fontSize: 40,
                          color: ColorsApp.grey1.color,
                          fontWeight: FontWeight.bold
                        )
                      )
                    ],
                  )
                )
              ),
              VerticalDivider(
                color: ColorsApp.grey1.color,
                width: 2,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsGeometry.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10,
                    children: [
                      Text(
                        'Total de produções cadastradas:',
                        style: TextStyle(
                          fontSize: 15,
                          color: ColorsApp.grey1.color
                        ),
                      ),
                      Text(
                        '$number_of_productions',
                        style: TextStyle(
                          fontSize: 40,
                          color: ColorsApp.grey1.color,
                          fontWeight: FontWeight.bold
                        )
                      )
                    ],
                  )
                )
              )
            ]
          ),
        )
      );
  }
}