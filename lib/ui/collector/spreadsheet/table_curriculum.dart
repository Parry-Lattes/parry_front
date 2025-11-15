import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parry_front/tools/convert_data.dart';
import 'package:parry_front/ui/collector/spreadsheet/list_productions.dart';
import 'package:parry_front/ui/my_widgets/button_data_picker.dart';
import 'package:parry_front/controllers/controller_table_curriculum.dart';
import 'package:parry_front/ui/colors_app.dart';

class TableCurriculum extends StatelessWidget {
  final ControllerTableCurriculum controller;
  TableCurriculum({super.key,required this.controller});

  final _label_style = TextStyle(
    color: ColorsApp.black.color,
    fontWeight: FontWeight.bold
  );

  final _edit_text_style = TextStyle(color: ColorsApp.black.color);

  @override
  Widget build(BuildContext context) {
    final last_update = controller.last_update;
    final date_update = string_to_date(last_update)!;

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
              'Currículo',
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
                    child: Text('ID Lattes',style: _label_style)
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: EdgeInsetsGeometry.all(5),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        controller: TextEditingController(text: '${controller.id_lattes}'),
                        onChanged: (value) => controller.id_lattes = int.tryParse(value)!,
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
                    child: Text('Última Atualização',style: _label_style,)
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: EdgeInsetsGeometry.all(5),
                      child: ButtonDataPicker(
                        on_changed: (value) {
                          if(value == null) {return;}
                          controller.last_update = date_to_string(value);
                        },
                        initial_date: date_update
                      ),
                    )
                  )
                ]
              )
            ]
          ),
          SizedBox(
            height: 30,
          ),
          ListProductions(controllers: controller.productions)
        ]
      )
    );
  }
}