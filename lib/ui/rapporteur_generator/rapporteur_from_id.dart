import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parry_front/controllers/controller_dashboard/controller_rapporteur_from_id.dart';
import 'package:parry_front/ui/colors_app.dart';

class RapporteurFromId extends StatefulWidget {
  final ControllerRapporteurFromId controller;

  const RapporteurFromId({required this.controller});

  @override
  State<StatefulWidget> createState() => _RapporteurFromId();
}

class _RapporteurFromId extends State<RapporteurFromId> {
  final List<TextField> _field_id_lattes = List.empty(growable: true);

  void create_text_field() {
    final controller = TextEditingController(text: '');
    final text_field = TextField(
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      controller: controller,
      style: TextStyle(color: ColorsApp.black.color),
      cursorColor: ColorsApp.black.color,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorsApp.black.color)),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorsApp.black.color)),
      ),
    );

    widget.controller.text_controllers.add(controller);

    setState(() {
      _field_id_lattes.add(text_field);
    });
  }

  @override
  void initState() {
    super.initState();

    create_text_field();
  }

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    
    for(final f in _field_id_lattes) {
      children.add(
        Padding(
          padding: const EdgeInsetsGeometry.only(left: 40,right: 40,bottom: 5),
          child: Row(
            spacing: 5,
            children: [
              Expanded(child: f),
              SizedBox(
                width: 50,
                child: IconButton(
                  onPressed: () {
                    widget.controller.text_controllers.remove(f.controller);
                    setState(() {
                      _field_id_lattes.remove(f);
                    });
                  },
                  icon: Icon(Icons.close,color: ColorsApp.black.color,)
                ),
              )
            ],
          ),
        )
      );
    }

    children.add(
      Center(
        child: ElevatedButton(
          onPressed: () { create_text_field(); },
          child: const Text(
            'Adicionar ID Lattes',
          )
        ),
      )
    );

    return ListView(
      children: children,
    );
  }
}