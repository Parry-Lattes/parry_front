import 'package:flutter/material.dart';
import 'package:parry_front/controllers/controller_spreadsheet/controller_edit_list_text.dart';

class EditListText extends StatefulWidget {
  final ControllerEditListText controller;
  
  const EditListText({super.key,required this.controller});

  @override
  State<StatefulWidget> createState() => _EditListText();
}

class _EditListText extends State<EditListText> {

  @override
  Widget build(BuildContext context) {
    final chips = List<Widget>.empty(growable: true);
    for(final abbr in widget.controller.list_text) {
      chips.add(
        Chip(
          label: Text(abbr),
          onDeleted: () {
            setState(() {
              widget.controller.list_text.remove(abbr);
            });
          },
        )
      );
    }

    chips.add(
      ElevatedButton(
        child:  const Text('Adicionar'),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              final new_text = TextEditingController();
              return Dialog(
                constraints: const BoxConstraints(
                  maxHeight: 150,
                  maxWidth: 300
                ),
                child: Padding(
                  padding: EdgeInsetsGeometry.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10,
                    children: [
                      TextField(
                        controller: new_text,
                        decoration: const InputDecoration(
                          labelText: 'Digite aqui...',
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 10,
                        children: [
                          TextButton(
                            onPressed: (){Navigator.pop(context);},
                            child: const Text('Cancel')
                          ),
                          FilledButton(
                            onPressed: (){
                              setState(() {
                                if(new_text.text.trim() != ''){
                                  widget.controller.list_text.add(new_text.text.trim());
                                }
                                Navigator.pop(context);
                              });
                            },
                            child: const Text('OK')
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            });
        },
      ),
    );
    return Wrap(
      spacing: 2,
      runSpacing: 2,
      children: chips
    );
  }
}