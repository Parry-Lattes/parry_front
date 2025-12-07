import 'package:flutter/material.dart';
import 'package:parry_front/controllers/controller_action_button.dart';
import 'package:parry_front/core/api_interface/api_interface.dart';
import 'package:parry_front/core/scrapper/extractor/extractor.dart';
import 'package:parry_front/controllers/controller_spreadsheet/controller_spreadsheet.dart';
import 'package:parry_front/ui/collector/spreadsheet/spreadsheet.dart';
import 'package:parry_front/ui/colors_app.dart';
import 'package:parry_front/ui/my_widgets/error_dialog.dart';
import 'package:parry_front/ui/my_widgets/wait_dialog.dart';

class ReviewData extends StatelessWidget {
  final List<Extractor> extrators;
  final ControllerActionButton controller_upload_button;
  final controllers_spreads = List<ControllerSpreadsheet>.empty(growable: true);
  final upload_people = ApiInterface.upload_people;
  final void Function() done_review;

  /*
   Requer a lista de extrators, o controller do botão de upload e a função para fazer
   o Collector voltar para a página anterior
   */
  ReviewData({super.key,required this.extrators, required this.controller_upload_button,required this.done_review});

  @override
  Widget build(BuildContext context) {
    final List<Spreadsheet> spreads = List.empty(growable: true);
    for(final e in extrators) {
      final controller = ControllerSpreadsheet(extractor: e);
      spreads.add(Spreadsheet(controller: controller));
      controllers_spreads.add(controller);
    }

    controller_upload_button.action = () {
      showDialog<dynamic>(
        context: context,
        builder: (BuildContext c) {
          return WaitDialog(action: () async {
            await Future.delayed(const Duration(seconds: 1));
            for(final c in controllers_spreads) {
              final (curriculum,people) = c.data;

              //primeiro, tentamos deletar o que já tem no banco de dados
              ApiInterface.delete_data(curriculum.id_lattes)
                .then((_) {
                  //envio os dados, e verifico se isso foi bem sucedido
                  upload_people.send_data(people.json).then(
                    (result) {
                      if(true) {
                        //se o envio de dados foi bem sucedido, então eu tento salvar o currículo também
                        ApiInterface.upload_curriculum(curriculum.id_lattes)
                          .send_data(curriculum.json);}
                      // } else {
                      //   print('deu merda em: ${people.name}');
                      // }
                    }
                  );
                });
            }
          });
        }
      ).then((result) {
        if(result == true){
          done_review();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: ColorsApp.brown1.color,
              content: Text('Dados enviados com sucesso!', style: TextStyle(color: ColorsApp.white.color),),
              duration: const Duration(seconds: 5),
            ),
          );
        } else if(result != null) {
          showDialog(
            context: context,
            builder: (BuildContext c) {
              return ErrorDialog(title: 'Erro ao enviar os dados', message: result.toString());
            }
          );
        }
      });
    };

    final controller_scroll = ScrollController();

    return RawScrollbar(
      controller: controller_scroll,
      thumbColor: ColorsApp.grey1.color,
      thumbVisibility: true, // Força a visibilidade
      trackVisibility: true, // Mostra a trilha também,
      thickness: 8.0, // Espessura da barra
      radius: const Radius.circular(10),

      child: ListView(

        controller: controller_scroll,
        children: spreads,
      )
    );
  }

}

// import 'package:flutter/material.dart';

// class ReviewData extends StatefulWidget {
//   final String text;
//   const ReviewData({super.key,required this.text});

//   @override
//   State<StatefulWidget> createState() => _ReviewData();
// }

// class _ReviewData extends State<ReviewData> {



//   @override
//   Widget build(BuildContext context) {
//     throw Text(widget.text);
//   }
// }