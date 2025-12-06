import 'package:flutter/material.dart';
import 'package:parry_front/ui/colors_app.dart';
import 'package:parry_front/ui/my_widgets/button_confirm.dart';

class ErrorDialog extends StatelessWidget {
  final String title;
  final String message;

  const ErrorDialog({required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorsApp.grey2.color,
      constraints: const BoxConstraints(
        maxHeight: 250
      ),
      title: Text(title, style: TextStyle(color: ColorsApp.red.color,fontWeight: FontWeight.bold),),
      content: Column(
        children: [
          SizedBox(
            height: 100,
            width: 300,
            child: Text(message)
          ),
          ButtonConfirm(
            action: () async {}
          )
        ],
      ),
    );
  }
}