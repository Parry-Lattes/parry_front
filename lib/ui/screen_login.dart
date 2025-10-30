import 'package:flutter/material.dart';

class Login extends StatelessWidget{
  const Login({super.key});

  @override
  Widget build(BuildContext contexto) {
    return Row(
      spacing: 5,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Center(
          child: Image.asset('assets/imagens/logo.png'),
        ),
        SizedBox(
          height: 500,
          width: 400,
          child: Card(
            child: Container(
              margin: EdgeInsets.all(20),
              child: Column(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'e-mail'
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'senha'
                    ),
                  ),
                  TextButton(
                    onPressed: (){Navigator.pushNamed(contexto, '/sla_porra');}, 
                    child: Text('Entrar'),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}