// ignore_for_file: prefer_const_constructors, avoid_print, prefer_void_to_null

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pichiimall/models/product_model.dart';
import 'package:pichiimall/utility/my_constant.dart';
import 'package:pichiimall/widgets/show_progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowProductSeller extends StatefulWidget {
  const ShowProductSeller({Key? key}) : super(key: key);

  @override
  _ShowProductSellerState createState() => _ShowProductSellerState();
}

class _ShowProductSellerState extends State<ShowProductSeller> {

bool load = true;

  @override
  void initState() {
    super.initState();
    loadValueFromAPI();
  }

  Future<Null> loadValueFromAPI() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id')!;
    String getProductWhereIdSeller =
        '${MyConstant.domain}/pichiimall/getProductWhereIdSeller.php?isAdd=true&idSeller=$id';

    await Dio().get(getProductWhereIdSeller).then((value) {
      for (var item in json.decode(value.data)) {
        // print('### value ==>> $value');
        ProductModel model = ProductModel.fromMap(item);
        print('### Product name ==>> ${model.name}');

        setState(() {
          load = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: load ? ShowProgress() : Text('Loading Done'),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyConstant.dark,
        onPressed: () =>
            Navigator.pushNamed(context, MyConstant.routeAddProduct),
        child: Text('Add'),
      ),
    );
  }
}
