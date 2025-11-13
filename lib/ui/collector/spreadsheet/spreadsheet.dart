import 'package:flutter/material.dart';
import 'package:parry_front/core/lattes_entitys/curriculum.dart';
import 'package:parry_front/core/lattes_entitys/people.dart';
import 'package:parry_front/core/scrapper/extractor/extractor.dart';
import 'package:parry_front/core/scrapper/scrapper.dart';
import 'package:parry_front/ui/collector/spreadsheet/controllers/controller_table_pessoa.dart';
import 'package:parry_front/ui/collector/spreadsheet/table_people.dart';
import 'package:parry_front/ui/colors_app.dart';

class Spreadsheet extends StatefulWidget {
  final Extractor extractor;
  
  const Spreadsheet({super.key,required this.extractor});

  @override
  State<StatefulWidget> createState() => _Spreadsheet();
}

class _Spreadsheet extends State<Spreadsheet> with AutomaticKeepAliveClientMixin {
  Status _status = Status.loading;
  String? _msg_error;
  double _height = 500;

  //late Curriculum _curriculum;
  final _controller_people = ControllerTablePessoa();
  late Widget _child;

  Future<(Curriculum,People)> _load_data() async {
    await Future.delayed(Duration(seconds: 2));
    final struct = widget.extractor.extract_data();

    final scrapper = Scrapper(struct);
    return scrapper.scrapping();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    switch(_status) {
      case Status.loading:
        _child = SizedBox(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(value: null,color: ColorsApp.black.color,)
        );
        _load_data().then(
          (result) {
            setState(() {
              _status = Status.sucess;
              //_curriculum = result.$1;
              _controller_people.people = result.$2;
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
        _child = TablePeople(controller: _controller_people,);
        break;
      case Status.failed:
        _child = Text(
          _msg_error!,
          style: TextStyle(
            color: ColorsApp.red.color,
            fontSize: 30,
            fontWeight: FontWeight.bold
          )
        );
    }

    return SizedBox(
      width: double.infinity,
      height: _height,
      child: Padding(
        padding: EdgeInsetsGeometry.all(20),
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
      ),
    );
  }
}

enum Status {loading,sucess,failed}