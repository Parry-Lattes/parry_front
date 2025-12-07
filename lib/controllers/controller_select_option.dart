import 'package:flutter/material.dart';

class ControllerSelectOption<T> {
  T? value;
  late Map<String,T> _items;

  ControllerSelectOption({this.value,Map<String,T>? items = null}) {
    if(items == null) {
      _items = {};
      return;
    }

    _items = items;
  }

  List<DropdownMenuItem<T>> get drop_down_itens {
    List<DropdownMenuItem<T>> list = [];

    for(final i in _items.entries) {
      list.add(DropdownMenuItem(child: Text(i.key),value: i.value,));
    }

    return list;
  }
}