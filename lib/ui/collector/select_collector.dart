import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:parry_front/core/scrapper/extractor/extractor.dart';
import 'package:parry_front/core/scrapper/extractor/getting_extractor.dart';
import 'package:parry_front/tools/web_navigator.dart';
import 'package:parry_front/ui/collector/check_html_pages.dart';
import 'package:parry_front/ui/collector/check_pdf_files.dart';
import 'package:parry_front/ui/colors_app.dart';
import 'package:parry_front/ui/my_widgets/button_confirm.dart';

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
                  final extrator = getting_extractor(path_pdf: path);
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
                      structs.add(getting_extractor(path_pdf: l)!);
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

  void _select_pages_html(BuildContext context) async {
    //faco o navegador
    try {
      await WebNavigator.init_navigator('https://buscatextual.cnpq.br/buscatextual/busca.do?metodo=apresentar');
    } catch (e) {
      if(context.mounted) {
        showDialog(
          context: context,
          builder: (BuildContext buider) {
            return AlertDialog(
              backgroundColor: ColorsApp.grey2.color,
              constraints: BoxConstraints(
                maxHeight: 250
              ),
              title: Text('Erro ao executar o navegador', style: TextStyle(color: ColorsApp.red.color,fontWeight: FontWeight.bold),),
              content: Column(
                children: [
                  SizedBox(
                    height: 100,
                    width: 300,
                    child: Text(e.toString())
                  ),
                  ButtonConfirm(
                    action: () async {}
                  )
                ],
              ),
            );
          }
        );
      }

      return;
    }

    Map<String,String> pages_html = {};

    if(context.mounted) {
      showDialog(
        context: context,
        builder: (BuildContext builder) {
          return AlertDialog(
            constraints: BoxConstraints(
              maxHeight: 250
            ),
            title: Text('Abra os currículos'),
            content: Column(
              children: [
                SizedBox(
                  height: 100,
                  width: 300,
                  child: Text('Abrimos um navegador para você, abra os currículos que você deseja coletar neles, e depois clique em confirmar')
                ),
                ButtonConfirm(
                  action: () async {
                    pages_html = await WebNavigator.load_pages('Currículo do Sistema de Currículos Lattes');
                    //await Future.delayed(Duration(seconds: 2));
                    WebNavigator.close_navigator();
                  }
                )
              ],
            ),
          );
        }
      ).then((value) {
        if(value == true && context.mounted) {
          showDialog<List<String>>(
            context: context,
            builder: (BuildContext c) {
              return Dialog(
                constraints: BoxConstraints(
                  maxHeight: 400,
                  maxWidth: 500
                ),
                backgroundColor: ColorsApp.grey2.color,
                child: CheckHtmlPages(pages: pages_html),
              );
            }
          ).then(
            (list) {
              if(list != null) {
                if(list.isNotEmpty) {
                  //vamos criar uma lista de estruturas, e preencher elas com o extrator
                  List<Extractor> structs = List.empty(growable: true);
                  for(final l in list) {
                    structs.add(getting_extractor(text_html: l)!);
                  }

                  send_structs(structs);
                }
              }
            }
          );
        } else {
          WebNavigator.close_navigator();
        }
      });
    }
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
                  onPressed: (){
                    _select_pages_html(context);
                  },
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