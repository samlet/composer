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
  print("product ==> ${prod?.productId}, ${prod?.productName}");
  var configOptNames = prod?.productProductConfigs?.values
      ?.map((e) => e.configItemProductConfigItem?.configItemName)
      // ?.map((e) => e.configItemProductConfigItem!)
      .toList();
  print("available selections: $configOptNames");

  var configOpts = prod?.productProductConfigs?.values
      ?.map((e) => e.configItemProductConfigItem)
      .toList();
  configOpts?.forEach((element) {
    print("${element?.configItemName} - ${element?.description}");
    var optVals = element?.configItemProductConfigProducts?.values
        ?.map((e) => "${e.productId} (${e.quantity?.decimal})").toList();
    print("\tto select: $optVals");
  });

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
