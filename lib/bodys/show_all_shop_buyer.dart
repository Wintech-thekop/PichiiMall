// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pichiimall/models/user_model.dart';
import 'package:pichiimall/utility/my_constant.dart';

class ShowAllShopBuyer extends StatefulWidget {
  const ShowAllShopBuyer({Key? key}) : super(key: key);

  @override
  _ShowAllShopBuyerState createState() => _ShowAllShopBuyerState();
}

class _ShowAllShopBuyerState extends State<ShowAllShopBuyer> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readApiAllShop();
  }

  Future<Null> readApiAllShop() async {
    String urlApi = '${MyConstant.domain}/pichiimall/getUserWhereSeller.php';
    await Dio().get(urlApi).then((value) {
      // print('$value');
      var result = json.decode(value.data);
      // print('$result');

      for (var item in result) {
        // print('$item');
        UserModel model = UserModel.fromMap(item);
        print('Name is ${model.name}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('ShowAllShopBuyer'),
    );
  }
}
