import 'package:flutter/material.dart';
import 'package:parry_front/ui/collector/spreadsheet/controllers/controller_table_people.dart';
import 'package:parry_front/ui/my_widgets/edit_list_text.dart';
import 'package:parry_front/ui/colors_app.dart';

class TablePeople extends StatelessWidget {
  final ControllerTablePeople controller;
  TablePeople({super.key,required this.controller});

  final _label_style = TextStyle(
    color: ColorsApp.black.color,
    fontWeight: FontWeight.bold
  );

  final _edit_text_style = TextStyle(color: ColorsApp.black.color);
  final _scroll_controller = ScrollController();

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsetsGeometry.all(30),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 30,
            decoration: BoxDecoration(
              color: ColorsApp.black.color,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10)
              ),
            ),
            child: Text(
              'Pessoa',
              style: TextStyle(
                color: ColorsApp.white.color,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Divider(
            height: 2,
            thickness: 1,
            color: ColorsApp.grey1.color,
          ),
          Table(
            border: TableBorder(
              verticalInside: BorderSide(
                color: ColorsApp.grey1.color
              ),
              horizontalInside: BorderSide(
                color: ColorsApp.grey1.color
              ),
              bottom: BorderSide(
                color: ColorsApp.grey1.color
              )
            ),
            children: [
              TableRow(
                children: [
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Text('Nome',style: _label_style)
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: EdgeInsetsGeometry.all(5),
                      child: TextField(
                        controller: TextEditingController(text: controller.name),
                        onChanged: (value) => controller.name = value,
                        style: _edit_text_style,
                      ),
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
                    child: Padding(
                      padding: EdgeInsetsGeometry.all(5),
                      child: TextField(
                        controller: TextEditingController(text: controller.nationality),
                        onChanged: (value) => controller.nationality = value,
                        style: _edit_text_style,
                      ),
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
                    height: 80,
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsetsGeometry.all(5),
                      child: Scrollbar(
                        controller: _scroll_controller,
                        thumbVisibility: true,
                        child: ListView(
                          controller: _scroll_controller,
                          children: [
                            EditListText(controller: controller.controller_abbreviations),
                          ]
                        )
                      )
                    )
                  )
                ]
              )
            ]
          )
        ]
      )
    );
  }
}