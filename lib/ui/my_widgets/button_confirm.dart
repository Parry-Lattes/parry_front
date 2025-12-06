import 'package:flutter/material.dart';
import 'package:parry_front/ui/colors_app.dart';

class ButtonConfirm extends StatefulWidget {
  final Future Function() action;

  const ButtonConfirm({super.key, required this.action});
  @override
  State<StatefulWidget> createState() => _ButtonConfirm();
}

class _ButtonConfirm extends State<ButtonConfirm> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: (){
        widget.action().then(
          (_){
            if(context.mounted) {
              Navigator.pop(context,true);
            }
          }
        );
        setState(() {
          loading = true;
        });
      },
      child: loading?
        SizedBox(
          width: 15,
          height: 15,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            color: ColorsApp.black.color,
            value: null
          ),
        ):
        const Text('Confirmar')
    );
  }
}