import 'package:flutter/material.dart';
import 'package:parry_front/controllers/controller_action_button.dart';
import 'package:parry_front/core/api_interface/api_interface.dart';
import 'package:parry_front/core/exceptions/unauthorized_request.dart';
import 'package:parry_front/core/scrapper/extractor/extractor.dart';
import 'package:parry_front/controllers/controller_spreadsheet/controller_spreadsheet.dart';
import 'package:parry_front/ui/collector/spreadsheet/spreadsheet.dart';
import 'package:parry_front/ui/colors_app.dart';
import 'package:parry_front/ui/my_widgets/error_dialog.dart';
import 'package:parry_front/ui/my_widgets/reautentication_dialog.dart';
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
        barrierDismissible: false,
        builder: (BuildContext c) {
          return WaitDialog(action: () async {
            await Future.delayed(const Duration(seconds: 1));
            for(final con in controllers_spreads) {
              final (curriculum,people) = con.data;

              //primeiro, tentamos deletar o que já tem no banco de dados
              await ApiInterface.delete_data(curriculum.id_lattes);

              //depois de tentar deletar, tentamos enviar a pessoa
              if(await upload_people.send_data(people.json)) {
                //se tudo der certo, fazemos o upload do curriculo
                ApiInterface.upload_curriculum(curriculum.id_lattes).send_data(curriculum.json);
              }
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
          if(result is UnauthorizedRequest) {
            reautentication(context, result);

            return;
          }

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