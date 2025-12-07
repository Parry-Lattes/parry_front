import 'package:flutter/material.dart';
import 'package:parry_front/controllers/controller_action_button.dart';

class ActionButton extends StatelessWidget {
  final ControllerActionButton controller;
  final IconData icon;

  const ActionButton({required this.controller,required this.icon});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: (){
        controller.action();
      },
      icon: Icon(icon)
    );
  }
}