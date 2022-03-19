// ignore_for_file: prefer_const_constructors, prefer_void_to_null, avoid_print

import 'package:flutter/material.dart';
import 'package:pichiimall/state/add_product.dart';
import 'package:pichiimall/state/add_wallet.dart';
import 'package:pichiimall/state/authen.dart';
import 'package:pichiimall/state/buyer_service.dart';
import 'package:pichiimall/state/confirm_add_wallet.dart';
import 'package:pichiimall/state/create_account.dart';
import 'package:pichiimall/state/rider_service.dart';
import 'package:pichiimall/state/seller_service.dart';
import 'package:pichiimall/state/show_cart.dart';
import 'package:pichiimall/utility/my_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'state/edit_profile_seller.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => Authen(),
  '/createAccount': (BuildContext context) => CreateAccount(),
  '/buyerService': (BuildContext context) => BuyerService(),
  '/sellerService': (BuildContext context) => SellerService(),
  '/riderService': (BuildContext context) => RiderService(),
  '/addProduct': (BuildContext context) => AddProduct(),
  '/editProfileSeller': (BuildContext context) => EditProfileSeller(),
  '/showCart': (BuildContext context) => ShowCart(),
  '/addWallet': (BuildContext context) => AddWallet(),
  '/confirmAddWallet': (BuildContext context) => ConfirmAddWallet(),
};

String? initialRoute; // initialRoute can be null

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? type = preferences.getString('type');

  print('### type ===>> $type');
  if (type?.isEmpty ?? true) {
    initialRoute = MyConstant.routeAuthen;
  } else {
    switch (type) {
      case 'buyer':
        initialRoute = MyConstant.routeBuyerService;

        break;
      case 'seller':
        initialRoute = MyConstant.routeSellerService;

        break;
      case 'rider':
        initialRoute = MyConstant.routeRiderService;

        break;
      default:
    }
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MaterialColor materialColor =
        MaterialColor(0xffb4004e, MyConstant.mapMaterialColor);
    return MaterialApp(
      title: MyConstant.appName,
      routes: map,
      initialRoute: initialRoute,
      theme: ThemeData(primarySwatch: materialColor),
    );
  }
}
