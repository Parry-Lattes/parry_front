import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:parry_front/ui/colors_app.dart';

class SelectCollector extends StatelessWidget {
  const SelectCollector({super.key});

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
                  onPressed: () async {
                    FilePickerResult? result = await FilePicker.platform.pickFiles(
                      dialogTitle: 'Selecione o ou os PDFs de currículos',
                      type: FileType.custom,
                      allowedExtensions: ['pdf'],
                      allowMultiple: true
                    );

                    if(result != null) {
                      for(final file in result.files) {
                        print(file.name);
                      }
                    }
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