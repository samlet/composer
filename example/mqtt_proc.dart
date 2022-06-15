import 'dart:async';

import 'package:bluecc_srv/utils.dart';
import 'package:composer/noti.dart';

Future<int> main() async {
  initLogger();

  const topic = 'plain/#';

  var noti=Noti();
  await noti.establish(processor: (msg, topic){
    print(['receive from $topic', asString(msg)]);
  });
  noti.subscribe(topic);

  return 0;
}

