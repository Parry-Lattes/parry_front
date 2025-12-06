import 'package:flutter/widgets.dart';

class ControllerRapporteurFromId {
  final List<TextEditingController> text_controllers = List.empty(growable: true);

  List<(String,int)> get ids_lattes {
    final ids = <(String,int)>[];
    for(final i in text_controllers) {
      if(i.text.trim().length != 16) {
        ids.add((i.text,0));
        continue;
      }
      ids.add((i.text,int.tryParse(i.text)!));
    }

    return ids;
  }
}