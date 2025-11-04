import 'package:flutter/material.dart';
import 'package:parry_front/ui/colors_app.dart';

class Login extends StatelessWidget{
  const Login({super.key});

  @override
  Widget build(BuildContext contexto) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Image.asset('assets/imagens/fundo_login.jpeg').image,
          fit: BoxFit.cover
        )
      ),
      child: Row(
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
              color: Color.fromRGBO(0, 0, 0, 0),
              shadowColor: Color.fromRGBO(0, 0, 0, 0),
              child: Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  spacing: 30,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'PARRY LATTES',
                      style: TextStyle(
                        color: ColorsApp.black.color,
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Column(
                      spacing: 10,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          autofocus: true,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorsApp.white.color)),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorsApp.white.color)),
                            labelText: 'e-mail',
                            
                          ),
                        ),
                        TextField(
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorsApp.white.color)),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorsApp.white.color)),
                            labelText: 'senha',
                          ),
                        )
                      ],
                    ),
                    TextButton(
                      onPressed: (){Navigator.pushNamed(contexto, '/app');}, 
                      child: Text('Entrar'),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}