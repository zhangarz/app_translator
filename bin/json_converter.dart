import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:translator/translator.dart';

void main(List<String> arguments) async {
  print('\n');
  var t = GoogleTranslator();

  var map = await readJsonFile('./lib/translation.json');

  // map.forEach((key, value) {
  //    t.translate(value, from: 'en', to: 'pl').then((v) => map[key] = v);
  //  });

  final ku = {}, ar = {}, tr = {};

  mapToJson(map);

  print('\nKurdish Translation:');
  for (var entry in map.entries) {
    var translation = await t.translate(entry.value, from: 'en', to: 'ckb');
    stdout.write("${translation.source}: ${translation.text}\n");
    ku[entry.key] = translation.text;
  }
  mapToJson(ku);

  print('\nArabic Translation:');
  for (var entry in map.entries) {
    var translation = await t.translate(entry.value, from: 'en', to: 'ar');
    stdout.write("${translation.source}: ${translation.text}\n");
    ar[entry.key] = translation.text;
  }

  mapToJson(ar);

  print('Turkish Translation:');
  for (var entry in map.entries) {
    var translation = await t.translate(entry.value, from: 'en', to: 'tr');
    stdout.write("${translation.source}: ${translation.text}\n");
    tr[entry.key] = translation.text;
  }

  mapToJson(tr);
}

void mapToJson(dynamic m) {
  print('${JsonEncoder().convert(m)}\n');
}

Future<Map<String, dynamic>> readJsonFile(String filePath) async {
  var input = await File(filePath).readAsString();
  return jsonDecode(input);
}
