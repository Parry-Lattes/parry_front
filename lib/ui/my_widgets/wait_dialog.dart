import 'package:flutter/material.dart';

class WaitDialog extends StatelessWidget {
  final Future Function() action;

  const WaitDialog({required this.action});

  @override
  Widget build(BuildContext context) {
    action().then((_){
      Navigator.pop(context);
    });
    return const AlertDialog(
      content: SizedBox(
        width: 100,
        height: 100,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}