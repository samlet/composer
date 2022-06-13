
import 'package:bluecc_srv/utils.dart';
import 'package:composer/local_data.dart';

void main(List<String> arguments) {
  var prod=LocalProductProvider.products[0];
  pretty(prod.toJson());
}

