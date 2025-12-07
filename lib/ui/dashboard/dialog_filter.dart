import 'package:flutter/material.dart';
import 'package:parry_front/controllers/controller_dashboard/controller_dashboard.dart';
import 'package:parry_front/controllers/controller_select_option.dart';
import 'package:parry_front/core/lattes_entitys/production.dart';
import 'package:parry_front/ui/my_widgets/select_option.dart';

enum TypeFilter {year,type}

/*
  Uma janela de dialogo. Caso seja confirma algum filtro, da pop com o valor do filtro
  Caso o usuário dispense a janela sem nenhum filtro, retorna null.
  Caso seja para limpar os filtro, da pop com valor false.
 */
class DialogFilter extends StatefulWidget {
  final ControllerDashboard controller;

  DialogFilter({required this.controller});

  @override
  State<StatefulWidget> createState() => _DialogFilter();
}

class _DialogFilter extends State<DialogFilter> {
  ControllerSelectOption _select_year = ControllerSelectOption();
  ControllerSelectOption _select_type = ControllerSelectOption();
  TypeFilter? _filter;

  Map<String,int> _list_years() {
    final productions_by_year = widget.controller.productions_by_year;

    final years = <int>[];
    final items = <String,int>{};

    for(final p in productions_by_year) {
      if(!years.contains(p.year)) {
        years.add(p.year);
        items['${p.year}'] = p.year;
      }
    }
    
    return items;
  }

  Map<String,TypeProduction> _list_types() {
    return {
      'Bibliográfica': TypeProduction.bibliographic,
      'Patente': TypeProduction.patent,
      'Técnica': TypeProduction.technique,
      'Outra': TypeProduction.other
    };
  }

  @override
  void initState() {
    super.initState();

    _select_year = ControllerSelectOption(value: widget.controller.productions_by_year[0].year,items: _list_years());
    _select_type = ControllerSelectOption(value: TypeProduction.other, items: _list_types());
  }

  void _confirm_filter() {
    switch(_filter) {
      case TypeFilter.year:
        final productions_by_year = widget.controller.productions_by_year;
        for(final p in productions_by_year) {
          if(p.year == _select_year.value) {
            Navigator.pop(context,p);
            return;
          }
        }

        Navigator.pop(context,null);
        return;
      case TypeFilter.type:
        final productions_by_type = widget.controller.productions_by_type;
        for(final p in productions_by_type) {
          if(p.type == _select_type.value) {
            Navigator.pop(context,p);
            return;
          }
        }

        Navigator.pop(context,null);
        return;

      case null:
        Navigator.pop(context,false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 20,
          child: Text('Selecione um filtro'),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsetsGeometry.all(20),
            child: RadioGroup<TypeFilter>(
              groupValue: _filter,
              onChanged: (v) {
                setState(() {
                  _filter = v;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 5,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 3,
                    children: [
                      const Row(
                        children: [
                          Radio<TypeFilter>(value: TypeFilter.year),
                          Text('Ano')
                        ]
                      ),
                      SelectOption(
                        on_changed: (_){
                          setState(() {
                            _filter = TypeFilter.year;
                          });
                        }, 
                        controller: _select_year,
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 3,
                    children: [
                      const Row(
                        children: [
                          Radio<TypeFilter>(value: TypeFilter.type),
                          Text('Tipo de produção')
                        ]
                      ),
                      SelectOption(
                        on_changed: (_){
                          setState(() {
                            _filter = TypeFilter.type;
                          });
                        }, 
                        controller: _select_type
                      )
                    ],
                  )
                ],
              )
            ),
          )
        ),
        SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  _filter = null;
                  _confirm_filter();
                },
                child: const Text('Limpar filtros')
              ),
              ElevatedButton(
                onPressed: () {_confirm_filter();},
                child: const Text('Confirmar')
              )
            ]
          )
        )
      ],
    );
  }
}