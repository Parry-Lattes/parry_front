import 'package:flutter/material.dart';
import 'package:parry_front/core/lattes_entitys/production.dart';

class SelectType extends StatefulWidget {
  final void Function(TypeProduction) on_changed;
  final TypeProduction initial_value;

  const SelectType({super.key, required this.initial_value, required this.on_changed});

  @override
  State<StatefulWidget> createState() => _SelectType();
}

class _SelectType extends State<SelectType> {
  TypeProduction value = TypeProduction.other;

  @override
  void initState() {
    super.initState();

    value = widget.initial_value;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<TypeProduction>(
      items: TypeProduction.values.map<DropdownMenuItem<TypeProduction>>((TypeProduction value) {
        return DropdownMenuItem<TypeProduction>(value: value, child: Text(value.text_type));
      }).toList(),
      value: value,
      onChanged: (v) {
        if (v != null) {
          widget.on_changed(v);

          setState(() {
            value = v;
          });
        }
      }
    );
  }
}