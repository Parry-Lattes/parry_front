import 'package:flutter/material.dart';
import 'package:parry_front/core/api_interface/api_interface.dart';
import 'package:parry_front/core/scrapper/extractor/extractor.dart';
import 'package:parry_front/controllers/controller_spreadsheet/controller_spreadsheet.dart';
import 'package:parry_front/ui/collector/spreadsheet/spreadsheet.dart';
import 'package:parry_front/ui/colors_app.dart';

class ReviewData extends StatelessWidget {
  final List<Extractor> extrators;
  ReviewData({super.key,required this.extrators});
  final controllers_spreads = List<ControllerSpreadsheet>.empty(growable: true);
  final upload_people = ApiInterface.upload_people;

  @override
  Widget build(BuildContext context) {
    final List<Widget> spreads = List.empty(growable: true);
    for(final e in extrators) {
      final controller = ControllerSpreadsheet(extractor: e);
      spreads.add(Spreadsheet(controller: controller));
      controllers_spreads.add(controller);
    }

    //por fim, adiciona o botão de upload
    spreads.add(
      Padding(
        padding: EdgeInsetsGeometry.only(left: 20,right: 20,bottom: 10),
        child: ElevatedButton.icon(
          onPressed: () {
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
          },
          label: Text('Upload'),
          icon: Icon(Icons.cloud_upload),
        ),
      )
    );

    final controller_scroll = ScrollController();

    return RawScrollbar(
      controller: controller_scroll,
      thumbColor: ColorsApp.grey1.color,
      thumbVisibility: true, // Força a visibilidade
      trackVisibility: true, // Mostra a trilha também,
      thickness: 8.0, // Espessura da barra
      radius: Radius.circular(10),

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