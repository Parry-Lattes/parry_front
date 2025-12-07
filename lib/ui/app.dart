import 'package:flutter/material.dart';
import 'package:parry_front/ui/colors_app.dart';
import 'package:parry_front/ui/screen_login.dart';
import 'package:parry_front/ui/screen_pdf_view.dart';

import 'rail_app.dart';

class App extends StatelessWidget{
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: ColorsApp.white.color,
          secondary: ColorsApp.black.color,
          error: ColorsApp.red.color,
          surface: ColorsApp.brown1.color,
          onError: ColorsApp.white.color,
          onPrimary: ColorsApp.brown1.color,
          onSecondary: ColorsApp.white.color,
          onSurface: ColorsApp.white.color
        ),
      ),
      home: ScreenLogin(),
      routes: <String, WidgetBuilder> {
        '/login': (BuildContext c) => ScreenLogin(),
        '/app': (BuildContext c) => const RailApp(),
      },
      onGenerateRoute: (settings) {
        final arguments = settings.arguments as Map<String,dynamic>;
        switch(settings.name) {
          case '/pdf_view':
            return MaterialPageRoute<bool>(
              builder: (context) {
                return ScreenPdfView(pdf_path: arguments['pdf_path']);
              }
            );
        }

        return null;
      },
    );
  }
}