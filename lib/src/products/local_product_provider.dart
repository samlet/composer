import 'package:bluecc_srv/data_wrappers.dart';
import 'package:hubs_data/messages.dart';

class LocalProductProvider {
  static List<Product> products = [
    Product(
      productId: 'CPU_586',
      productName: 'Apples',
      introductionDate: DateTime.now().tsVal,
    ),
    Product(
      productId: 'CPU_386',
      productName: 'Intel',
    ),
  ];
}

