import 'package:flutter/material.dart';
import 'package:parry_front/controllers/controller_dashboard/controller_dashboard.dart';
import 'package:parry_front/ui/colors_app.dart';
import 'package:parry_front/ui/my_widgets/reautentication_dialog.dart';

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
          width: 600,
          height: 300,
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
                          fontSize: 15,
                          color: ColorsApp.grey1.color,
                        ),
                      ),
                      widget.controller.numbers_totais.$1 >= 1
                      ?Text(
                        '${widget.controller.numbers_totais.$1}',
                        style: TextStyle(
                          fontSize: 60,
                          color: ColorsApp.grey1.color,
                          fontWeight: FontWeight.bold
                        )
                      )
                      :Text(
                        'Não há dados para mostrar',
                        style: TextStyle(
                          fontSize: 20,
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
                          fontSize: 15,
                          color: ColorsApp.grey1.color
                        ),
                      ),
                      widget.controller.numbers_totais.$2 >= 1
                      ?Text(
                        '${widget.controller.numbers_totais.$2}',
                        style: TextStyle(
                          fontSize: 60,
                          color: ColorsApp.grey1.color,
                          fontWeight: FontWeight.bold
                        )
                      )
                      :Text(
                        'Não há dados para mostrar',
                        style: TextStyle(
                          fontSize: 20,
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