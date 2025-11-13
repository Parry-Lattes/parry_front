import 'package:flutter/material.dart';
import 'package:parry_front/ui/collector/spreadsheet/controllers/controller_edit_list_text.dart';
import 'package:parry_front/ui/collector/spreadsheet/controllers/controller_table_pessoa.dart';
import 'package:parry_front/ui/collector/spreadsheet/edit_list_text.dart';
import 'package:parry_front/ui/colors_app.dart';

class TablePeople extends StatefulWidget {
  final ControllerTablePessoa controller;
  const TablePeople({super.key,required this.controller});

  @override
  State<StatefulWidget> createState() => _TablePeople();
}

class _TablePeople extends State<TablePeople> {
  final _label_style = TextStyle(
    color: ColorsApp.black.color,
    fontWeight: FontWeight.bold
  );

  final _edit_text_style = TextStyle(color: ColorsApp.black.color);

  late ControllerEditListText _controller_abbreviations;

  @override
  void initState() {
    super.initState();

    _controller_abbreviations = widget.controller.controller_abbreviations;
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsetsGeometry.all(30),
      child: Table(
        border: TableBorder(
          horizontalInside: BorderSide(
            color: ColorsApp.grey1.color
          )
        ),
        children: [
          TableRow(
            children: [
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Text('Nome',style: _label_style,)
              ),
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: TextField(
                  controller: TextEditingController(text: widget.controller.name),
                  onChanged: (value) => widget.controller.name = value,
                  style: _edit_text_style,
                )
              )
            ]
          ),
          TableRow(
            children: [
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Text('Nacionalidade',style: _label_style,)
              ),
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: TextField(
                  controller: TextEditingController(text: widget.controller.nationality),
                  onChanged: (value) => widget.controller.nationality = value,
                  style: _edit_text_style,
                )
              )
            ]
          ),
          TableRow(
            children: [
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Text('Abreviaturas',style: _label_style,)
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ListView(
                  children: [
                    EditListText(controller: _controller_abbreviations),
                  ],
                ),
              )
            ]
          )
        ],
      ),
    );
  }
}