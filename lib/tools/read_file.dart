import 'dart:io';

String read_file(String path) {
  final file = File(path);

  return file.readAsStringSync();
}