import 'dart:io';
import 'package:bluecc_srv/product_ops_disp.dart';
import 'package:hubs_data/messages.dart';

Future<void> main(List<String> arguments) async {
  var disp = ProductOpsDelegator().getProduct(input: {
    "handle": {"regionId": "default"},
    "id": "PIZZA"
  })
    ..mapObject(['productId', 'productName', productProductConfigs]);

  var prod = await disp.call((p0) => Product.fromJson(p0));
  print("${prod?.productId}, ${prod?.productName}");

  exit(0);
}

String get productProductConfigs {
  return r'''productProductConfigs {
				values {
					configItemId
					sequenceNum
					description
					isMandatory
					configItemProductConfigItem {
						configItemName
						description
						configItemProductConfigProducts {
							values {
								productId
								quantity {
									decimal
								}
							}
						}
					}
				}
			} ''';
}
