import 'package:flutter/material.dart';
import 'package:parry_front/core/lattes_entitys/curriculum.dart';
import 'package:parry_front/core/lattes_entitys/people.dart';
import 'package:parry_front/core/scrapper/extractor/extractor.dart';
import 'package:parry_front/core/scrapper/scrapper.dart';
import 'package:parry_front/ui/collector/spreadsheet/nada.dart';
import 'package:parry_front/ui/colors_app.dart';

class Spreadsheet extends StatefulWidget {
  final Extractor extractor;
  
  const Spreadsheet({super.key,required this.extractor});

  @override
  State<StatefulWidget> createState() => _Spreadsheet();
}

class _Spreadsheet extends State<Spreadsheet> {
  Status _status = Status.loading;
  late Curriculum _curriculum;
  late People _people;
  late Widget _child;

  Future<(Curriculum,People)> _load_data() async {
    await Future.delayed(Duration(seconds: 2));
    final struct = widget.extractor.extract_data();

    final scrapper = Scrapper(struct);
    return scrapper.scrapping();
  }

  @override
  Widget build(BuildContext context) {
     switch(_status) {
      case Status.loading:
        _child = Center(
          child: SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(value: null,color: ColorsApp.black.color,),
          ),
        );
        _load_data().then(
          (result) {
            setState(() {
              _status = Status.sucess;
              _curriculum = result.$1;
              _people = result.$2;
            });
          },
          onError: (e) {
            _status = Status.failed;
            print(e);
          }
        );
        break;
      case Status.sucess:
        _child = Nada(text: '${_curriculum.json},${_people.json}');
        break;
      case Status.failed:
        _child = Nada(text: 'a');
    }

    return SizedBox(
      width: double.infinity,
      height: 500,
      child: _child
    );
  }
}

enum Status {loading,sucess,failed}