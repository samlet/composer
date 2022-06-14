import 'dart:io';

import 'package:bluecc_srv/suite.dart';
import 'package:bluecc_srv/utils.dart';

Future<void> main(List<String> arguments) async {
  var suite = MirrorsSuite();

  await partyGroups(suite);
  
  exit(0);
}

Future<void> partyGroups(MirrorsSuite suite) async {
  var rs = await suite.query(
      mapper: asPartyGroups, entity: EntitySymbol.partyGroup.name);
  await writeJsonAsset(rs!.asPartyGroups!, 'partyGroups');
}

