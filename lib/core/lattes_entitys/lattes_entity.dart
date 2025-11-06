import 'dart:convert';

class LattesEntity {
  Map<String,dynamic> attributes = {};

  String get json {
    return jsonEncode(attributes);
  }
}