import 'package:flutter/material.dart';
import 'package:parry_front/controllers/controller_dashboard/controller_dashboard.dart';
import 'package:parry_front/ui/colors_app.dart';

class ViewNumbersTotais extends StatefulWidget {
  final ControllerDashboard controller;
  final List<Future Function()> reloads;
  const ViewNumbersTotais({super.key, required this.controller, required this.reloads});

  @override
  State<StatefulWidget> createState() => _ViewNumbersTotais();
}

class _ViewNumbersTotais extends State<ViewNumbersTotais> with AutomaticKeepAliveClientMixin {
  bool _loading = true;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    widget.reloads.add(() async {
      setState(() {
        _loading = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if(_loading) {
      widget.controller.loading_data.then(
        (result){
          if(result == true) {
            setState(() {
              _loading = false;
            });
          }
        }
      );
    }

    return _loading
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
            spacing: 20,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsGeometry.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10,
                    children: [
                      Text(
                        'Total de currículos cadastrados:',
                        style: TextStyle(
                          fontSize: 18,
                          color: ColorsApp.grey1.color,
                        ),
                      ),
                      Text(
                        '${widget.controller.numbers_totais.$1}',
                        style: TextStyle(
                          fontSize: 50,
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
                  padding: const EdgeInsetsGeometry.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10,
                    children: [
                      Text(
                        'Total de produções cadastradas:',
                        style: TextStyle(
                          fontSize: 18,
                          color: ColorsApp.grey1.color
                        ),
                      ),
                      Text(
                        '${widget.controller.numbers_totais.$2}',
                        style: TextStyle(
                          fontSize: 50,
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