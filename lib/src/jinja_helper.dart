import 'dart:io';

import 'package:jinja/jinja.dart';
import 'package:jinja/loaders.dart';

var templatePath = Directory.current.uri.resolve('templates').toFilePath();

var templateEnv = Environment(
  globals: <String, Object?>{
    'now': () {
      var dt = DateTime.now().toLocal();
      var hour = dt.hour.toString().padLeft(2, '0');
      var minute = dt.minute.toString().padLeft(2, '0');
      return '$hour:$minute';
    },
  },
  autoReload: true,
  loader: FileSystemLoader(path: templatePath),
  leftStripBlocks: true,
  trimBlocks: true,
);

String renderTemplate(String templateFile, Map<String, dynamic> ctx){
  return templateEnv.getTemplate(templateFile).render(ctx);
}

var rawEnv = Environment();
String build(String source, Map<String, dynamic> ctx){
  return rawEnv.fromString(source).render(ctx);
}

