import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:parry_front/core/scrapper/extracting_structure.dart';
import 'package:parry_front/core/scrapper/extractor/extractor.dart';
import 'package:parry_front/ui/collector/check_pdf_files.dart';
import 'package:parry_front/ui/colors_app.dart';

class SelectCollector extends StatelessWidget {
  final Function(List<Extractor>) send_structs;
  const SelectCollector({super.key,required this.send_structs});

  void _select_pdf_files(BuildContext context) {
    FilePicker.platform.pickFiles( //esperamos que o usuario selecione os arquivos
      dialogTitle: 'Selecione o(s) PDF(s) de currículo(s)',
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: true
    ).then((results) { //quando ele selecionar, os arquivos vao para a viariavel result
      if(results != null) {
        if(results.count == 1) { //se houver um unico resultado, vamos para a rota de confirmar o pdf
          final path = results.files[0].path;
          if(context.mounted) {
            Navigator.pushNamed<bool>(context, '/pdf_view',arguments: {'pdf_path': path}).then(
              (confirm) {
                if(confirm == true && path != null) {
                  //como e apenas uma estrutura, apenas extraimos as linhas e mandamos uma lista com um unico elemento
                  final extrator = ExtractingStructure.extracting_structure(path_pdf: path);
                  if(extrator != null) {
                    send_structs([extrator]);
                  }
                }
              }
            );
          }
        } else { //se for mais de um resultado, vamos precisar que o usuario possa remover algum resultado que ele adicionou por engano
          if(context.mounted) {
            showDialog<List<String>>(
              context: context,
              builder: (BuildContext c) {
                return Dialog(
                  constraints: BoxConstraints(
                    maxHeight: 400,
                    maxWidth: 500
                  ),
                  backgroundColor: ColorsApp.grey2.color,
                  child: CheckPdfFiles(files: results.files),
                );
              }
            ).then(
              (list) {
                if(list != null) {
                  if(list.isNotEmpty) {
                    //vamos criar uma lista de estruturas, e preencher elas com o extrator
                    List<Extractor> structs = List.empty(growable: true);
                    for(final l in list) {
                      structs.add(ExtractingStructure.extracting_structure(path_pdf: l)!);
                    }

                    send_structs(structs);
                  }
                }
              }
            );
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 700,
      height: 400,
      child: Card(
        color: Color.fromRGBO(0, 0, 0, 0),
        shadowColor: Color.fromRGBO(0, 0, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 50,
          children: [
            Text(
              'Selecione a fonte da coleta de currículo',
              style: TextStyle(color: ColorsApp.grey2.color),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _select_pdf_files(context);
                  },
                  child: Text('PDF')
                ),
                ElevatedButton(
                  onPressed: (){},
                  child: Text('Web')
                ),
                ElevatedButton(
                  onPressed: (){},
                  child: Text('XML')
                )
              ],
            )
          ],
        ),
      )
    );
  }
}