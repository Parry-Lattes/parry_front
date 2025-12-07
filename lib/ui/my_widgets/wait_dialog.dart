import 'package:flutter/material.dart';

/*
 Executa uma função enquanto abre um diálogo com uma bola girando
 Quando a função termina de executar, caso tudo tenha ocorrido bem, fecha o diálogo, retornado true para o show dialog
 Se um erro ocorrer, fecha o diálogo e retorna o erro para o showDialog
 */
class WaitDialog extends StatelessWidget {
  final Future Function() action;

  const WaitDialog({required this.action});

  @override
  Widget build(BuildContext context) {
    action().then(
      (_){
        Navigator.pop(context,true);
      },
      onError: (e) {
        Navigator.pop(context,e);
      }
    );
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