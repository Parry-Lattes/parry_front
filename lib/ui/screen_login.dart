import 'package:flutter/material.dart';
import 'package:parry_front/core/api_interface/api_interface.dart';
import 'package:parry_front/ui/colors_app.dart';
import 'package:parry_front/ui/my_widgets/error_dialog.dart';

class ScreenLogin extends StatelessWidget{
  ScreenLogin({super.key});

  final _edit_email = TextEditingController(text: '');
  final _edit_password = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
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
              color: const Color.fromRGBO(0, 0, 0, 0),
              shadowColor: const Color.fromRGBO(0, 0, 0, 0),
              child: Container(
                margin: const EdgeInsets.all(20),
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
                          controller: _edit_email,
                          autofocus: true,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorsApp.white.color)),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorsApp.white.color)),
                            labelText: 'e-mail',
                            
                          ),
                        ),
                        TextField(
                          controller: _edit_password,
                          obscureText: true,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorsApp.white.color)),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorsApp.white.color)),
                            labelText: 'senha',
                          ),
                        )
                      ],
                    ),
                    TextButton(
                      onPressed: () async {
                        final result = await ApiInterface.login(_edit_email.text, _edit_password.text);
                        if(result == '') {
                          Navigator.pushNamed(context, '/app');
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext c) {
                              return ErrorDialog(
                                title: 'Problema ao autenticar',
                                message: result
                              );
                            }
                          );
                        }
                      }, 
                      child: const Text('Entrar'),
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