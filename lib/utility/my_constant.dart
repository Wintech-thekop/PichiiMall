// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MyConstant {
  //Generally

  static String appName = "Phichii Mall";
  static String domain =
      "https://f59b-2001-fb1-157-1c01-c563-32f6-fde0-2885.ngrok.io";

  //Routes
  static String routeAuthen = "/authen";
  static String routeCreateAccount = "/createAccount";
  static String routeBuyerService = "/buyerService";
  static String routeSellerService = "/sellerService";
  static String routeRiderService = "/riderService";
  static String routeAddProduct = "/addProduct";
  static String routeEditProfileSeller = "/editProfileSeller";
  static String routeShowCart = "/showCart";

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

  // Text style
  TextStyle h1Style() => TextStyle(
        fontSize: 24,
        color: dark,
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
