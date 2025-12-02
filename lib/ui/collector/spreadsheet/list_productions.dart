import 'package:flutter/material.dart';
import 'package:parry_front/controllers/controller_spreadsheet/controller_table_production.dart';
import 'package:parry_front/ui/collector/spreadsheet/table_production.dart';

class ListProductions extends StatefulWidget {
  final List<ControllerTableProduction> controllers;

  const ListProductions({super.key, required this.controllers});

  @override
  State<StatefulWidget> createState() => _ListProductions();
}

class _ListProductions extends State<ListProductions> {
  final _tables_productions = List<TableProduction>.empty(growable: true);

  @override
  void initState() {
    super.initState();

    for(final controll in widget.controllers) {
      _tables_productions.add(TableProduction(controller: controll));
    }
  }

  void _remove_table(TableProduction table) {
    widget.controllers.remove(table.controller);

    setState(() {
      _tables_productions.remove(table);
    });
  }

  void _add_table() {
    final new_controller = ControllerTableProduction();
    widget.controllers.add(new_controller);

    setState(() {
      _tables_productions.add(TableProduction(controller: new_controller));
    });
  }

  @override
  Widget build(BuildContext context) {
    final children = List<Widget>.empty(growable: true);

    for(final table in _tables_productions) {
      children.add(
        Column(
          spacing: 2,
          children: [
            table,
            Row(
              children: [
                Expanded(child: Container()),
                TextButton.icon(
                  onPressed: (){_remove_table(table);},
                  icon: Icon(Icons.remove_circle_outline),
                  label: Text('Remover')
                )
              ],
            )
          ],
        )
      );
    }

    children.add(
      ElevatedButton.icon(
        onPressed: (){_add_table();},
        icon: Icon(Icons.add_circle_outline),
        label: Text('Adicionar')
      )
    );

    return Column(
      spacing: 15,
      children: children,
    );
  }
}