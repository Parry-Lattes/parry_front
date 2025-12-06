import 'package:flutter/material.dart';
import 'package:parry_front/ui/colors_app.dart';

class CheckHtmlPages extends StatefulWidget{
  final Map<String,String> pages;
  const CheckHtmlPages({super.key,required this.pages});

  @override
  State<StatefulWidget> createState() => _CheckHtmlPages();
}

class _CheckHtmlPages extends State<CheckHtmlPages> {
  final List<bool> _aproved = List.empty(growable: true);

  @override
  void initState() {
    super.initState();

    for(int i = 0; i<widget.pages.length; i++) {
      _aproved.add(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> list_check = List.empty(growable: true);

    int i = -1;
    for(final key in widget.pages.keys) {
      i++;
      final name = key.substring(
        key.indexOf('(')+1,
        key.indexOf(')')
      );
      list_check.add(
        CheckboxListTile(
          side: BorderSide(
            color: ColorsApp.grey2.color,
            width: 1,
            style: BorderStyle.solid
          ),
          value: _aproved[i],
          title: Text(name,style: TextStyle(color: ColorsApp.black.color)),
          onChanged: (value) {
            setState(() {
              _aproved[i] = value!;
            });
          }
        )
      );
    }

    return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          spacing: 15,
          children: [
            const Center(
              child: Text('Revise as páginas para extração dos dados'),
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
                  child: const Text('Cancelar')
                ),
                ElevatedButton(
                  onPressed: () {
                    final List<String> result = List.empty(growable: true);
                    int i = -1;
                    for(final value in widget.pages.values) {
                      i++;
                      if(_aproved[i]) {
                        result.add(value);
                      }
                    }
                    Navigator.pop(context,result);
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(ColorsApp.black.color)
                  ),
                  child: const Text('OK'),
                ),
              ],
            )
          ],
        ),
      );
  }
}