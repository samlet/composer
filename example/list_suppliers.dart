import 'dart:io';
import 'package:bluecc_srv/party_disp.dart';
import 'package:bluecc_srv/src/dispatch/disp_common.dart';
import 'package:bluecc_srv/utils.dart';
import 'package:composer/composer.dart';
import 'package:hubs_data/messages.dart';

Future<void> main(List<String> arguments) async {
  var disp = PartyDelegator().listSuppliers()
    ..mapList([
      'id',
      r'''party { partyTypeId }''',
      r'''supplierProducts {
				values {
					productId
					lastPrice {decimal}
					format(as: "<o.id> - <o.lastPrice>")
				}
			} '''
    ]);
  // print(disp.render());
  // await processWithTemplate(disp);
  // var rs = await disp.executeAsList();
  // var suppliers = rs?.map((e) => PartyWithSupplier.fromJson(e)).toList();
  var suppliers=await disp.list((e) => PartyWithSupplier.fromJson(e));
  print(suppliers?.length);
  printLines([for (var e in suppliers!) "${e.id}, ${getProducts(e)}"]);
  exit(0);
}

String? getProducts(PartyWithSupplier e) =>
    e.supplierProducts?.values?.map((e) => "${e.productId}(${e.lastPrice?.decimal})").join(', ');

Future<void> processWithTemplate(QlDisp disp) async {
  var rs = await disp.executeAsList();
  printLines([for (var r in rs!) "${r['id']} - ${r['party']?['partyTypeId']}"]);

  var cnt = build(r'''
    {% for e in rs %}
    {{ e.id }}
      {% for p in e.supplierProducts.values %}
      {{ p.productId }}
      {%- endfor %}
    {%- endfor %}
  ''', {'rs': rs});

  print(cnt);
}
