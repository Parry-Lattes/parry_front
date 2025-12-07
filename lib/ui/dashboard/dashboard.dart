import 'package:flutter/material.dart';
import 'package:parry_front/controllers/controller_dashboard/controller_dashboard.dart';
import 'package:parry_front/ui/colors_app.dart';
import 'package:parry_front/ui/dashboard/view_graphics.dart';
import 'package:parry_front/ui/dashboard/view_numbers_totais.dart';
import 'package:parry_front/ui/my_widgets/action_button.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});
  final ControllerDashboard controller = ControllerDashboard();
  final _controller_page = PageController(initialPage: 0, keepPage: true);

  List<Widget> get actions {
    return [ActionButton(controller: controller.controller_action_button, icon: Icons.filter_list_outlined)];
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 80,
          child: Center(
            child: IconButton(
              color: ColorsApp.black.color,
              onPressed: () {
                if(_controller_page.page == 0) {
                  _controller_page.jumpToPage(1);
                  return;
                }
                _controller_page.previousPage(duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
              },
              icon: const Icon(Icons.arrow_back_ios_sharp)
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsetsGeometry.all(30),
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
                    controller: _controller_page,
                    physics: const ScrollPhysics(),
                    children: [
                      ViewNumbersTotais(controller: controller),
                      ViewGraphics(controller: controller)
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
              onPressed: (){
                if(_controller_page.page == 1) {
                  _controller_page.jumpToPage(0);
                  return;
                }
                _controller_page.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
              },
              icon: const Icon(Icons.arrow_forward_ios_sharp)
            ),
          ),
        )
      ],
    );
  }
}