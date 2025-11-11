import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:parry_front/ui/colors_app.dart';

class CheckPdfFiles extends StatefulWidget{
  final List<PlatformFile> files;
  const CheckPdfFiles({super.key,required this.files});

  @override
  State<StatefulWidget> createState() => _CheckPdfFiles();
}

class _CheckPdfFiles extends State<CheckPdfFiles> {
  final List<bool> _aproved = List.empty(growable: true);

  @override
  void initState() {
    super.initState();

    for(int i = 0; i<widget.files.length; i++) {
      _aproved.add(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> list_check = List.empty(growable: true);

    for(int i = 0; i<widget.files.length; i++) {
      final f = widget.files[i];
      list_check.add(
        CheckboxListTile(
          side: BorderSide(
            color: ColorsApp.grey2.color,
            width: 1,
            style: BorderStyle.solid
          ),
          value: _aproved[i],
          enabled: _aproved[i],
          title: TextButton( //damos a possibilidade de ele abrir o pdf para verificar a selecao
            onPressed: () {
              Navigator.pushNamed<bool>(
                context,
                '/pdf_view',
                arguments: {'pdf_path': f.path}
              ).then((confirm) {
                if(confirm != null) {
                  setState(() {
                    _aproved[i] = confirm;
                  });
                }
              });
            },
            child: Text(
              f.name,
              style: TextStyle(color: ColorsApp.black.color)
            )
          ),
          onChanged: (value) {
            setState(() {
              _aproved[i] = value!;
            });
          }
        )
      );
    }

    return Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          spacing: 15,
          children: [
            Center(
              child: Text('Revise os arquivos para extração dos dados'),
            ),
            Expanded(
              child: Container(
                color: ColorsApp.white.color,
                child: ListView(
                  children: list_check,
                ),
              )
            ),
            Row(
              spacing: 5,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context,<String>[]);
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(ColorsApp.grey1.color)
                  ),
                  child: Text('Cancelar')
                ),
                ElevatedButton(
                  onPressed: () {
                    final List<String> result = List.empty(growable: true);
                    for(int i = 0; i<_aproved.length; i++) {
                      if(_aproved[i]) {
                        if(widget.files[i].path != null) {
                          result.add(widget.files[i].path!);
                        }
                      }
                    }
                    Navigator.pop(context,result);
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(ColorsApp.black.color)
                  ),
                  child: Text('OK'),
                ),
              ],
            )
          ],
        ),
      );
  }
}