import 'dart:io';

import 'package:bluecc_srv/model_disp.dart';
import 'package:hubs_data/messages.dart';

Future<void> main(List<String> arguments) async {
  await callAsObject();
  exit(0);
}

Future<void> callAsObject() async {
  var disp = ModelDelegator().entity(name: "NoteData")
    ..mapObject([
      'name',
      'combine',
      r''' fields { value { name type pk } } ''']);
  // print(disp.render());
  ModelEntity? ent = await disp.call((rs) => ModelEntity.fromJson(rs));
  printEntity(ent!);
}

Future<void> runAsObject() async {
  var disp = ModelDelegator().entity(name: "NoteData")
    ..mapObject([
      'name',
      'combine',
      r''' fields { value { name type pk } } ''']);
  // print(disp.render());
  var rs = await disp.execute<Map<String, dynamic>>();
  // printRawInfo(rs);

  // with json-wrapper
  var ent = ModelEntity.fromJson(rs!);
  printEntity(ent);
}

void printEntity(ModelEntity ent) {
  print("entity name: ${ent.name}");
  ent.fields?.forEach((element) {
    print(element.toJson());
  });
}

void printRawInfo(Map<String, dynamic>? rs) {
  print(rs?.keys); // (__typename, name, combine, fields)
  // print(rs?['fields']?[0]);
  for (final f in (rs?['fields'] as List)) {
    // print(f);
    print("${f['value']['name']} - ${f['value']['type']}");
  }
}
