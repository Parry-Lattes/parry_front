import 'package:flutter/material.dart';
import 'package:parry_front/tools/convert_data.dart';
import 'package:parry_front/ui/colors_app.dart';

class ButtonDataPicker extends StatefulWidget {
  final Function(DateTime?) on_changed;
  final DateTime initial_date;

  const ButtonDataPicker({super.key,required this.on_changed,required this.initial_date});
  @override
  State<StatefulWidget> createState() => _ButtonDataPicker();
}

class _ButtonDataPicker extends State<ButtonDataPicker> {
  String _date = '';

  @override
  void initState() {
    super.initState();
    _date = date_to_string(widget.initial_date);
  }

  @override
  Widget build(BuildContext context) {
    
    return TextButton.icon(
      onPressed: (){
        showDatePicker(
          context: context,
          initialDate: widget.initial_date,
          firstDate: DateTime(1900),
          lastDate: DateTime.now()
        ).then((value) {
          if(value == null) {
            return;
          }

          widget.on_changed(value);
          setState(() {
            _date = date_to_string(value);
          });
        });
      },
      icon: const Icon(
        Icons.calendar_month_outlined,
        color: Color.fromRGBO(39, 29,44, 1), //esse fresco nao me permite so colocar o black aqui direto
      ),
      label: Text(_date,style: TextStyle(color: ColorsApp.black.color)),
      
    );
  }
}