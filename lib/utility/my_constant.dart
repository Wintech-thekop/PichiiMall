// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MyConstant {
  //Generally

  static String appName = "Phichii Mall";
  static String domain =
      "https://229f-2001-fb1-157-1399-859-7ab6-350f-173d.ngrok.io";
  static String urlPrompay = "https://promptpay.io/0845503246.png";
  static String omisePublicKey = 'pkey_test_5r5y6n0rlmbrsej2d9y';
  static String omiseSecretKey = 'skey_test_5r5y6n0rto3ugj7dpau';
  static String omiseChargeUrl = 'https://api.omise.co/charges';

  //Routes
  static String routeAuthen = "/authen";
  static String routeCreateAccount = "/createAccount";
  static String routeBuyerService = "/buyerService";
  static String routeSellerService = "/sellerService";
  static String routeRiderService = "/riderService";
  static String routeAddProduct = "/addProduct";
  static String routeEditProfileSeller = "/editProfileSeller";
  static String routeShowCart = "/showCart";
  static String routeAddWallet = "/addWallet";
  static String routeConfirmAddWallet = "/confirmAddWallet";

  // Images
  static String image1 = 'images/image1.png';
  static String image2 = 'images/image2.png';
  static String image3 = 'images/image3.png';
  static String image4 = 'images/image4.png';
  static String image5 = 'images/image5.png';
  static String avatar = 'images/avatar.png';

  // Color
  static Color primary = Color(0xffec407a);
  static Color dark = Color(0xffb4004e);
  static Color light = Color(0xffff77a9);
  static Map<int, Color> mapMaterialColor = {
    50: Color.fromRGBO(255, 180, 0, 0.1),
    100: Color.fromRGBO(255, 180, 0, 0.2),
    200: Color.fromRGBO(255, 180, 0, 0.3),
    300: Color.fromRGBO(255, 180, 0, 0.4),
    400: Color.fromRGBO(255, 180, 0, 0.5),
    500: Color.fromRGBO(255, 180, 0, 0.6),
    600: Color.fromRGBO(255, 180, 0, 0.7),
    700: Color.fromRGBO(255, 180, 0, 0.8),
    800: Color.fromRGBO(255, 180, 0, 0.9),
    900: Color.fromRGBO(255, 180, 0, 1.0),
  };
  //Background

  BoxDecoration planBackground() =>
      BoxDecoration(color: MyConstant.light.withOpacity(0.75));

  BoxDecoration gradientLinearBackground() => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, MyConstant.primary, MyConstant.dark],
        ),
      );

  BoxDecoration gradientRadioBackground() => BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(0, -0.5),
          radius: 1.5,
          colors: [Colors.white, MyConstant.primary],
        ),
      );

  // Text style
  TextStyle h1Style() => TextStyle(
        fontSize: 24,
        color: dark,
        fontWeight: FontWeight.bold,
      );

  TextStyle h1WhiteStyle() => TextStyle(
        fontSize: 24,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      );
      TextStyle h1RedStyle() => TextStyle(
        fontSize: 24,
        color: Colors.red.shade900,
        fontWeight: FontWeight.bold,
      );

  TextStyle h2Style() => TextStyle(
        fontSize: 18,
        color: dark,
        fontWeight: FontWeight.w700,
      );

  TextStyle h2WhiteStyle() => TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.w700,
      );
  TextStyle h2RedStyle() => TextStyle(
        fontSize: 18,
        color: Colors.red,
        fontWeight: FontWeight.w700,
      );
  TextStyle h2BlueStyle() => TextStyle(
        fontSize: 18,
        color: Colors.blue,
        fontWeight: FontWeight.w700,
      );
  TextStyle h3Style() => TextStyle(
        fontSize: 14,
        color: dark,
        fontWeight: FontWeight.normal,
      );

  TextStyle h3WhiteStyle() => TextStyle(
        fontSize: 14,
        color: Colors.white,
        fontWeight: FontWeight.normal,
      );

  // Button style
  ButtonStyle myButtonStyle() => ElevatedButton.styleFrom(
        primary: MyConstant.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      );
}
