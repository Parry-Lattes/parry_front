import 'package:flutter/material.dart';
import 'package:parry_front/controllers/controller_upload_button.dart';

class UploadButton extends StatelessWidget {
  final ControllerUploadButton controller;

  const UploadButton({required this.controller});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: (){
        controller.action();
      },
      icon: const Icon(Icons.cloud_upload)
    );
  }
}