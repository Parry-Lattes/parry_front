import 'package:flutter/material.dart';
import 'package:parry_front/controllers/controller_spreadsheet/controller_spreadsheet.dart';
import 'package:parry_front/ui/collector/spreadsheet/table_curriculum.dart';
import 'package:parry_front/ui/collector/spreadsheet/table_people.dart';
import 'package:parry_front/ui/colors_app.dart';

class Spreadsheet extends StatefulWidget {
  final ControllerSpreadsheet controller;
  const Spreadsheet({super.key,required this.controller});

  @override
  State<StatefulWidget> createState() => _Spreadsheet();
}

class _Spreadsheet extends State<Spreadsheet> with AutomaticKeepAliveClientMixin {
  Status _status = Status.loading;
  String? _msg_error;

  //late Curriculum _curriculum;
  late Widget _child;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    switch(_status) {
      case Status.loading:
        _child = SizedBox(
          width: double.infinity,
          height: 500,
          child: Center(
            child: SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(value: null,color: ColorsApp.black.color)
            )
          )
        );

        widget.controller.load_data().then(
          (result) {
            setState(() {
              _status = Status.sucess;
              //_curriculum = result.$1;
              widget.controller.controller_people.people = result.$2;
              widget.controller.controller_curriculum.curriculum = result.$1;
            });
          },
          onError: (e) {
            setState(() {
              _status = Status.failed;
              _msg_error = e.toString();
            });
          }
        );
        break;
      case Status.sucess:
        _child = Column(
          children: [
            TablePeople(controller: widget.controller.controller_people),
            TableCurriculum(controller: widget.controller.controller_curriculum)
          ],
        );
        break;
      case Status.failed:
        _child = SizedBox(
          width: double.infinity,
          height: 500,
          child: Center(
            child: Text(
              _msg_error!,
              style: TextStyle(
                color: ColorsApp.red.color,
                fontSize: 30,
                fontWeight: FontWeight.bold
              )
            ),
          ),
        );
    }

    return IntrinsicHeight(
      child: Padding(
        padding: const EdgeInsetsGeometry.all(20),
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: ColorsApp.grey1.color,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(15)
          ),
          color: ColorsApp.brown2.color,
          child: Center(
            child: _child,
          ),
        )
      )
    );
  }
}

enum Status {loading,sucess,failed}