import 'package:flutter/material.dart';
import 'package:parry_front/controllers/controller_dashboard/controller_dashboard.dart';
import 'package:parry_front/ui/colors_app.dart';
import 'package:parry_front/ui/dashboard/view_numbers_totais.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});
  final ControllerDashboard controller = ControllerDashboard();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 80,
          child: Center(
            child: IconButton(
              color: ColorsApp.black.color,
              onPressed: (){},
              icon: Icon(Icons.arrow_back_ios_sharp)
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsetsGeometry.all(30),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, // Cor do container
                boxShadow: [
                  BoxShadow(
                    color: ColorsApp.black_transparent.color, // Cor da sombra e opacidade
                    blurRadius: 7, // Raio de desfoque
                    spreadRadius: 1, // Expansão da sombra
                     // Posição da sombra (x, y)
                  ),
                ],
                borderRadius: BorderRadius.circular(12), // Bordas arredondadas
              ),
              child: Card(
                color: ColorsApp.white.color,
                child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: PageView(
                    children: [
                      ViewNumbersTotais(controller: controller)
                    ],
                  ),
                ),
              ),
            ),
          )
        ),
        SizedBox(
          width: 80,
          child: Center(
            child: IconButton(
              color: ColorsApp.black.color,
              onPressed: (){},
              icon: Icon(Icons.arrow_forward_ios_sharp)
            ),
          ),
        )
      ],
    );
  }
}