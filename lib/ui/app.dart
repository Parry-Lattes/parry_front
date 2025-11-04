import 'package:flutter/material.dart';
import 'package:parry_front/ui/colors_app.dart';
import 'package:parry_front/ui/screen_login.dart';

import 'rail_app.dart';

class App extends StatelessWidget{
  App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: ColorsApp.white.color,
          secondary: ColorsApp.black.color,
          error: ColorsApp.red.color,
          surface: ColorsApp.brown.color,
          onError: ColorsApp.white.color,
          onPrimary: ColorsApp.brown.color,
          onSecondary: ColorsApp.white.color,
          onSurface: ColorsApp.white.color
        ),
      ),
      home: Login(),
      routes: <String, WidgetBuilder> {
        '/login': (BuildContext c) => Login(),
        '/app': (BuildContext c) => RailApp(),
      }
    );
  
  }
}