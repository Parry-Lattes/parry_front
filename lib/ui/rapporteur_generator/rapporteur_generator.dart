import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:parry_front/controllers/controller_rapporteur_from_id.dart';
import 'package:parry_front/core/exceptions/unauthorized_request.dart';
import 'package:parry_front/core/exporter/exporter_all_productions.dart';
import 'package:parry_front/core/exporter/exporter_peoples.dart';
import 'package:parry_front/core/exporter/exporter_productions_of_people.dart';
import 'package:parry_front/ui/colors_app.dart';
import 'package:parry_front/ui/my_widgets/error_dialog.dart';
import 'package:parry_front/ui/my_widgets/reautentication_dialog.dart';
import 'package:parry_front/ui/my_widgets/wait_dialog.dart';
import 'package:parry_front/ui/rapporteur_generator/rapporteur_from_id.dart';

class RapporteurGenerator extends StatelessWidget{
  const RapporteurGenerator({super.key});

  List<Widget> get actions {
    return [];
  }

  @override
  Widget build(BuildContext context) {
    final controller_ids_lattes = ControllerRapporteurFromId();

    return Column(
      children: [
        SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 20,),
              Expanded(
                child: Text(
                  'Relatório de todos os discentes coletados pelo ParryLattes',
                  style: TextStyle(
                    color: ColorsApp.black.color,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                )
              ),
              SizedBox(
                width: 80,
                child: IconButton(
                  onPressed: (){
                    FilePicker.platform.getDirectoryPath(dialogTitle: 'Onde deseja salvar o relatório?')
                      .then((result) {
                        if(result != null) {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext c) {
                              return WaitDialog(action: () async {
                                await ExporterPeoples().export('$result/Tabela de discentes.csv').then(
                                  (_){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: ColorsApp.brown1.color,
                                        content: Text('Arquivo exportado com sucesso', style: TextStyle(color: ColorsApp.white.color),),
                                        duration: const Duration(seconds: 5),
                                      ),
                                    );
                                  },
                                  onError: (e) {
                                    if(e is UnauthorizedRequest) {
                                      reautentication(c, e);

                                      return;
                                    }

                                    showDialog(
                                      context: context,
                                      builder: (BuildContext c) {
                                        return ErrorDialog(
                                          title: 'Erro ao exportar arquivo',
                                          message: e.toString()
                                        );
                                      }
                                    );
                                  }
                                );
                              });
                            }
                          );
                        }
                      });
                  },
                  icon: Icon(Icons.ios_share,color: ColorsApp.grey1.color,)
                ),
              )
            ]
          ),
        ),
        Divider(
          height: 1,
          thickness: 1,
          color: ColorsApp.black_transparent.color,
        ),
        SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 20,),
              Expanded(
                child: Text(
                  'Relatório de todas as produções coletadas pelo ParryLattes',
                  style: TextStyle(
                    color: ColorsApp.black.color,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                )
              ),
              SizedBox(
                width: 80,
                child: IconButton(
                  onPressed: (){
                    FilePicker.platform.getDirectoryPath(dialogTitle: 'Onde deseja salvar o relatório?')
                      .then((result) {
                        if(result != null) {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext c) {
                              return WaitDialog(action: () async {
                                await ExporterAllProductions().export('$result/Tabela de todas as produções.csv').then(
                                  (_){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: ColorsApp.brown1.color,
                                        content: Text('Arquivo exportado com sucesso', style: TextStyle(color: ColorsApp.white.color),),
                                        duration: const Duration(seconds: 5),
                                      ),
                                    );
                                  },
                                  onError: (e) {
                                    if(e is UnauthorizedRequest) {
                                      reautentication(c, e);
                                      return;
                                    }

                                    showDialog(
                                      context: context,
                                      builder: (BuildContext c) {
                                        return ErrorDialog(
                                          title: 'Erro ao exportar arquivo',
                                          message: e.toString()
                                        );
                                      }
                                    );
                                  }
                                );
                              });
                            }
                          );
                        }
                      });
                  },
                  icon: Icon(Icons.ios_share,color: ColorsApp.grey1.color,)
                ),
              )
            ]
          ),
        ),
        Divider(
          height: 1,
          thickness: 1,
          color: ColorsApp.black_transparent.color,
        ),
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 20,),
                  Expanded(
                    child: Text(
                      'Relatório de produções de discentes específicos',
                      style: TextStyle(
                        color: ColorsApp.black.color,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ),
                  SizedBox(
                    width: 80,
                    child: IconButton(
                      onPressed: (){
                        final ids_lattes = controller_ids_lattes.ids_lattes;

                        for(final (text_id,id) in ids_lattes) {
                          if(id == 0) {
                            showDialog(
                              context: context,
                              builder: (BuildContext b) {
                                return ErrorDialog(
                                  title: 'ID Lattes inválido',
                                  message: 'O ID Lattes $text_id é inválido. Por favor, informe IDs Lattes válidos em todos os campos de texto.'
                                );
                              }
                            );
                            return;
                          }
                        }

                        FilePicker.platform.getDirectoryPath().then(
                          (result){
                            if(result != null) {
                              showDialog(
                                context: context,
                                builder: (BuildContext c) {
                                  return WaitDialog(
                                    action: () async {
                                      for(final (_,id) in ids_lattes) {
                                        await ExporterProductionsOfPeople(id_lattes: id).export('$result/Tabela de produções de $id.csv');
                                      }
                                    }
                                  );
                                }
                              ).then(
                                (result) {
                                  if(result == true) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: ColorsApp.brown1.color,
                                        content: Text('Arquivos exportados com sucesso', style: TextStyle(color: ColorsApp.white.color),),
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
                                        return ErrorDialog(
                                          title: 'Erro ao exportar arquivo',
                                          message: result.toString()
                                        );
                                      }
                                    );
                                  }
                                }
                              );
                            }
                          }
                        );
                      },
                      icon: Icon(Icons.ios_share,color: ColorsApp.grey1.color,)
                    ),
                  )
                ]
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: Padding(
                padding: const EdgeInsetsGeometry.only(left: 20, bottom: 5, top: 5),
                  child: Text(
                    'Especifique a seguir os IDs Lattes dos Discentes desejados',
                    textAlign: TextAlign.left,
                    style: TextStyle(color: ColorsApp.grey1.color),
                  ),
                ),
              ),
              Expanded(child: RapporteurFromId(controller: controller_ids_lattes))
            ],
          )
        )
      ]
    );
  }
}