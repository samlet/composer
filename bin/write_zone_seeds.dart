import 'dart:io';

import 'package:bluecc_srv/suite.dart';
import 'package:bluecc_srv/utils.dart';

Future<void> main(List<String> arguments) async {
  initLogger();

  
  await writeNotes();
  await writeWorkEfforts();
  await writeProducts();
  await writeCatalogs();
  await writePermissions();
  await writeSecurityGroups();
  await writeStores();
  await writeProductFeatureCategories();
  await writeContents();
  await writeExamples();
  await writeProductCategories();
  await writeProductFeatures();
  await writeUserLogins();
  await writeContactMeches();
  await writeShoppingLists();
  await writeFixedAssets();
  await writeFacilities();
  await writeParties();
  await writeStoreGroups();
  await writeOrders();
  await writeDataResources();

  exit(0);
}


// suite: note
Future<void> writeNotes() async {
  print('write notes ..');
  var suite = NotesSuite();
  var notes=await suite.zonedNotes(mapper: valuesMapper(noteDataScalars));
  await writeJsonAsset(notes, 'zoneNotes');
}

// suite: workEffort
Future<void> writeWorkEfforts() async {
  print('write workEfforts ..');
  var suite = WorkEffortsSuite();
  var workEfforts=await suite.zonedWorkEfforts(mapper: valuesMapper(workEffortScalars));
  await writeJsonAsset(workEfforts, 'zoneWorkEfforts');
}

// suite: product
Future<void> writeProducts() async {
  print('write products ..');
  var suite = ProductsSuite();
  var products=await suite.zonedProducts(mapper: valuesMapper(productScalars));
  await writeJsonAsset(products, 'zoneProducts');
}

// suite: catalog
Future<void> writeCatalogs() async {
  print('write catalogs ..');
  var suite = CatalogsSuite();
  var catalogs=await suite.zonedCatalogs(mapper: valuesMapper(prodCatalogScalars));
  await writeJsonAsset(catalogs, 'zoneCatalogs');
}

// suite: permission
Future<void> writePermissions() async {
  print('write permissions ..');
  var suite = PermissionsSuite();
  var permissions=await suite.zonedPermissions(mapper: valuesMapper(securityPermissionScalars));
  await writeJsonAsset(permissions, 'zonePermissions');
}

// suite: securityGroup
Future<void> writeSecurityGroups() async {
  print('write securityGroups ..');
  var suite = SecurityGroupsSuite();
  var securityGroups=await suite.zonedSecurityGroups(mapper: valuesMapper(securityGroupScalars));
  await writeJsonAsset(securityGroups, 'zoneSecurityGroups');
}

// suite: store
Future<void> writeStores() async {
  print('write stores ..');
  var suite = StoresSuite();
  var stores=await suite.zonedStores(mapper: valuesMapper(productStoreScalars));
  await writeJsonAsset(stores, 'zoneStores');
}

// suite: productFeatureCategory
Future<void> writeProductFeatureCategories() async {
  print('write productFeatureCategories ..');
  var suite = ProductFeatureCategoriesSuite();
  var productFeatureCategories=await suite.zonedProductFeatureCategories(mapper: valuesMapper(productFeatureCategoryScalars));
  await writeJsonAsset(productFeatureCategories, 'zoneProductFeatureCategories');
}

// suite: content
Future<void> writeContents() async {
  print('write contents ..');
  var suite = ContentsSuite();
  var contents=await suite.zonedContents(mapper: valuesMapper(contentScalars));
  await writeJsonAsset(contents, 'zoneContents');
}

// suite: example
Future<void> writeExamples() async {
  print('write examples ..');
  var suite = ExamplesSuite();
  var examples=await suite.zonedExamples(mapper: valuesMapper(exampleScalars));
  await writeJsonAsset(examples, 'zoneExamples');
}

// suite: productCategory
Future<void> writeProductCategories() async {
  print('write productCategories ..');
  var suite = ProductCategoriesSuite();
  var productCategories=await suite.zonedProductCategories(mapper: valuesMapper(productCategoryScalars));
  await writeJsonAsset(productCategories, 'zoneProductCategories');
}

// suite: productFeature
Future<void> writeProductFeatures() async {
  print('write productFeatures ..');
  var suite = ProductFeaturesSuite();
  var productFeatures=await suite.zonedProductFeatures(mapper: valuesMapper(productFeatureScalars));
  await writeJsonAsset(productFeatures, 'zoneProductFeatures');
}

// suite: userLogin
Future<void> writeUserLogins() async {
  print('write userLogins ..');
  var suite = UserLoginsSuite();
  var userLogins=await suite.zonedUserLogins(mapper: valuesMapper(userLoginScalars));
  await writeJsonAsset(userLogins, 'zoneUserLogins');
}

// suite: contactMech
Future<void> writeContactMeches() async {
  print('write contactMeches ..');
  var suite = ContactMechesSuite();
  var contactMeches=await suite.zonedContactMeches(mapper: valuesMapper(contactMechScalars));
  await writeJsonAsset(contactMeches, 'zoneContactMeches');
}

// suite: shoppingList
Future<void> writeShoppingLists() async {
  print('write shoppingLists ..');
  var suite = ShoppingListsSuite();
  var shoppingLists=await suite.zonedShoppingLists(mapper: valuesMapper(shoppingListScalars));
  await writeJsonAsset(shoppingLists, 'zoneShoppingLists');
}

// suite: fixedAsset
Future<void> writeFixedAssets() async {
  print('write fixedAssets ..');
  var suite = FixedAssetsSuite();
  var fixedAssets=await suite.zonedFixedAssets(mapper: valuesMapper(fixedAssetScalars));
  await writeJsonAsset(fixedAssets, 'zoneFixedAssets');
}

// suite: facility
Future<void> writeFacilities() async {
  print('write facilities ..');
  var suite = FacilitiesSuite();
  var facilities=await suite.zonedFacilities(mapper: valuesMapper(facilityScalars));
  await writeJsonAsset(facilities, 'zoneFacilities');
}

// suite: party
Future<void> writeParties() async {
  print('write parties ..');
  var suite = PartiesSuite();
  var parties=await suite.zonedParties(mapper: valuesMapper(partyScalars));
  await writeJsonAsset(parties, 'zoneParties');
}

// suite: storeGroup
Future<void> writeStoreGroups() async {
  print('write storeGroups ..');
  var suite = StoreGroupsSuite();
  var storeGroups=await suite.zonedStoreGroups(mapper: valuesMapper(productStoreGroupScalars));
  await writeJsonAsset(storeGroups, 'zoneStoreGroups');
}

// suite: order
Future<void> writeOrders() async {
  print('write orders ..');
  var suite = OrdersSuite();
  var orders=await suite.zonedOrders(mapper: valuesMapper(orderHeaderScalars));
  await writeJsonAsset(orders, 'zoneOrders');
}

// suite: dataResource
Future<void> writeDataResources() async {
  print('write dataResources ..');
  var suite = DataResourcesSuite();
  var dataResources=await suite.zonedDataResources(mapper: valuesMapper(dataResourceScalars));
  await writeJsonAsset(dataResources, 'zoneDataResources');
}

