import 'package:flutter/material.dart';
import 'package:parry_front/ui/my_widgets/error_dialog.dart';

void reautentication(BuildContext c,dynamic e) {
  showDialog(
    barrierDismissible: false,
    context: c,
    builder: (BuildContext c) {
      return ErrorDialog(title: 'Temos um problema', message: e.toString());
    }
  ).then((_){
    Navigator.pushNamed(c, '/login');
  });
}