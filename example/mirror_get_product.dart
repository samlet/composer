import 'dart:io';

import 'package:bluecc_srv/mirror_proto.dart';
import 'package:bluecc_srv/suite.dart';

Future<void> main(List<String> arguments) async {
  var prod = await Hubs.mirrors.productEntity('product_1');
  prod.productPriceList?.values.forEach((element) {
    print([element.productPriceTypeId, element.price]);
  });
  exit(0);
}


