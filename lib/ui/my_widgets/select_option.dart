import 'package:flutter/material.dart';
import 'package:parry_front/controllers/controller_select_option.dart';

class SelectOption<T> extends StatefulWidget {
  final void Function(T) on_changed;
  final ControllerSelectOption<T> controller;

  const SelectOption({super.key, required this.on_changed,required this.controller});

  @override
  State<StatefulWidget> createState() => _SelectOption<T>();
}

class _SelectOption<T> extends State<SelectOption> {
  T? _value;

  @override
  Widget build(BuildContext context) {
    if(_value == null) {
      _value = widget.controller.value;
    }

    return DropdownButton<dynamic>(
      items: widget.controller.drop_down_itens,
      value: _value,
      onChanged: (v) {
        if (v != null) {
          widget.controller.value = v;
          widget.on_changed(v);
          setState(() {
            _value = v;
          });
        }
      }
    );
  }
}