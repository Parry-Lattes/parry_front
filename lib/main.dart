import 'package:flutter/material.dart';
import 'package:parry_front/ui/screen_login.dart';

void main(List<String> args) {
  print("aaaaaabbbbav");
  runApp(MaterialApp(
    theme: ThemeData.dark(),
    home: Login(),
    routes: <String, WidgetBuilder> {
      '/sla_porra': (BuildContext c) => Scaffold(
        appBar: AppBar(
            
        ),
      )
    }
  )
  );
}