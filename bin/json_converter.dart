// @dart=2.9
import 'dart:convert';
import 'dart:io';

import 'package:quartet/quartet.dart' as quartet;
import 'package:translator/translator.dart';

void main(List<String> arguments) async {
  var t = GoogleTranslator();

  var map = await readJsonFile(
      'C:/development/flutter/almansour_translation/json_files/i.json');

  // map.forEach((key, value) {
  //    t.translate(value, from: 'en', to: 'pl').then((v) => map[key] = v);
  //  });

  for (var entry in map.entries) {
    var translation = await t.translate(entry.value, from: 'en', to: 'ku');
    map[entry.key] = translation.text;
  }

  mapToJson(map);
}

void mapToJson(dynamic m) {
  print(JsonEncoder().convert(m));
}

Future<Map<String, dynamic>> readJsonFile(String filePath) async {
  var input = await File(filePath).readAsString();
  return jsonDecode(input);
}
