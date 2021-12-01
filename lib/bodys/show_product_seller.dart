// ignore_for_file: prefer_const_constructors, avoid_print, prefer_void_to_null

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pichiimall/models/product_model.dart';
import 'package:pichiimall/utility/my_constant.dart';
import 'package:pichiimall/widgets/show_progress.dart';
import 'package:pichiimall/widgets/show_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowProductSeller extends StatefulWidget {
  const ShowProductSeller({Key? key}) : super(key: key);

  @override
  _ShowProductSellerState createState() => _ShowProductSellerState();
}

class _ShowProductSellerState extends State<ShowProductSeller> {
  bool load = true;
  bool? haveData;

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
      if (value.toString() == 'null') {
        // No data
        setState(() {
          load = false;
          haveData = false;
        });
      } else {
        // Have data
        for (var item in json.decode(value.data)) {
          // print('### value ==>> $value');
          ProductModel model = ProductModel.fromMap(item);
          print('### Product name ==>> ${model.name}');

          setState(() {
            load = false;
            haveData = true;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: load
          ? ShowProgress()
          : haveData!
              ? Text('Have data')
              : Center(
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ShowTitle(title: 'Have no data', textStyle: MyConstant().h1Style()),
                    ShowTitle(title: 'Please add any Product', textStyle: MyConstant().h2Style()),
                  ],
                ),
              ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyConstant.dark,
        onPressed: () =>
            Navigator.pushNamed(context, MyConstant.routeAddProduct),
        child: Text('Add'),
      ),
    );
  }
}
