import 'package:flutter/material.dart';
import 'package:parry_front/ui/colors_app.dart';

class Nada extends StatelessWidget {
  final String text;
  const Nada({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text(text,style: TextStyle(color: ColorsApp.black.color),);
  }
}