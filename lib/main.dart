import 'package:flutter/material.dart';
import 'package:pichiimall/state/authen.dart';
import 'package:pichiimall/state/buyer_service.dart';
import 'package:pichiimall/state/create_account.dart';
import 'package:pichiimall/state/rider_service.dart';
import 'package:pichiimall/state/seller_service.dart';
import 'package:pichiimall/utility/my_constant.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => Authen(),
  '/createAccount': (BuildContext context) => CreateAccount(),
  '/buyerServive': (BuildContext context) => BuyerService(),
  '/sellerServive': (BuildContext context) => SellerService(),
  '/riderServive': (BuildContext context) => RiderService(),
};

String? initialRoute; // initialRoute can be null

void main() {
  initialRoute = MyConstant.routeAuthen;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyConstant.appName,
      routes: map,
      initialRoute: initialRoute,
    );
  }
}
