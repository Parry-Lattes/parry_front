import 'package:flutter/material.dart';
import 'package:parry_front/tools/convert_data.dart';
import 'package:parry_front/ui/collector/spreadsheet/select_type.dart';
import 'package:parry_front/ui/my_widgets/button_data_picker.dart';
import 'package:parry_front/controllers/controller_spreadsheet/controller_table_production.dart';
import 'package:parry_front/ui/my_widgets/edit_list_text.dart';
import 'package:parry_front/ui/colors_app.dart';

class TableProduction extends StatelessWidget {
  final ControllerTableProduction controller;
  TableProduction({super.key,required this.controller});

  final _label_style = TextStyle(
    color: ColorsApp.black.color,
    fontWeight: FontWeight.bold
  );

  final _edit_text_style = TextStyle(color: ColorsApp.black.color);
  final _scroll_controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 30,
          decoration: BoxDecoration(
            color: ColorsApp.black.color,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10)
            ),
          ),
          child: Text(
            'Produção',
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
                  child: Text('Título',style: _label_style)
                ),
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Padding(
                    padding: const EdgeInsetsGeometry.all(5),
                    child: TextField(
                      controller: controller.title,
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
                  child: Text('Autor',style: _label_style)
                ),
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Padding(
                    padding: const EdgeInsetsGeometry.all(5),
                    child: TextField(
                      controller: controller.autor,
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
                  child: Text('Coautores',style: _label_style,)
                ),
                SizedBox(
                  height: 80,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsetsGeometry.all(5),
                    child: Scrollbar(
                      controller: _scroll_controller,
                      thumbVisibility: true,
                      child: ListView(
                        controller: _scroll_controller,
                        children: [
                          EditListText(controller: controller.controller_coautores),
                        ]
                      )
                    )
                  )
                )
              ]
            ),
            TableRow(
              children: [
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Text('Data de publicação',style: _label_style)
                ),
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Padding(
                    padding: const EdgeInsetsGeometry.all(5),
                    child: ButtonDataPicker(
                      on_changed: (value) {
                        if(value != null) {controller.date_pub = date_to_string(value);}
                      },
                      initial_date: DateTime(int.tryParse(controller.date_pub)!)
                    ),
                  )
                )
              ]
            ),
            TableRow(
              children: [
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Text('Tipo de produção',style: _label_style)
                ),
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Padding(
                    padding: const EdgeInsetsGeometry.all(5),
                    child: SelectType(initial_value: controller.type, on_changed: (value){
                      controller.type = value;
                    }),
                  ),
                )
              ]
            ),
          ]
        )
      ]
    );
  }
}