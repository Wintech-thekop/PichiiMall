// ignore_for_file: prefer_const_constructors, prefer_is_empty

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pichiimall/bodys/shop_manager_seller.dart';
import 'package:pichiimall/bodys/show_order_seller.dart';
import 'package:pichiimall/bodys/show_product_seller.dart';
import 'package:pichiimall/models/user_model.dart';
import 'package:pichiimall/utility/my_constant.dart';
import 'package:pichiimall/widgets/show_progress.dart';
import 'package:pichiimall/widgets/show_signout.dart';
import 'package:pichiimall/widgets/show_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SellerService extends StatefulWidget {
  const SellerService({Key? key}) : super(key: key);

  @override
  _SellerServiceState createState() => _SellerServiceState();
}

class _SellerServiceState extends State<SellerService> {
  List<Widget> widgets = [];

  int indexWidgets = 0;
  UserModel? userModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findUserModel();
  }

  Future<Null> findUserModel() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id')!;
    // print('$id');
    String apiGetUserWhereId =
        '${MyConstant.domain}/pichiimall/getUserWhereId.php?isAdd=true&id=$id';
    await Dio().get(apiGetUserWhereId).then((value) {
      // print('$value');

      for (var item in json.decode(value.data)) {
        setState(() {
          userModel = UserModel.fromMap(item);
          // print('${userModel!.name}');

          widgets.add(ShowOrderSeller());
          widgets.add(ShopManageSeller(userModel: userModel!));
          widgets.add(ShowProductSeller());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seller'),
      ),
      drawer: widgets.length == 0
          ? ShowProgress()
          : Drawer(
              child: Stack(
                children: [
                  ShowSignOut(),
                  Column(
                    children: [
                      buildDrawerHeader(),
                      menuShowOrder(),
                      menuShowManage(),
                      menuShowProduct(),
                    ],
                  ),
                ],
              ),
            ),
      body: widgets.length == 0 ? ShowProgress() : widgets[indexWidgets],
    );
  }

  UserAccountsDrawerHeader buildDrawerHeader() {
    return UserAccountsDrawerHeader(
      otherAccountsPictures: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.face),
          iconSize: 36,
          color: MyConstant.light,
          tooltip: 'Edit Shop',
        ),
      ],
      decoration: BoxDecoration(
        gradient: RadialGradient(
            colors: [MyConstant.light, MyConstant.dark],
            center: Alignment(-0.7, -0.15),
            radius: 1),
      ),
      currentAccountPicture: CircleAvatar(
        backgroundImage:
            NetworkImage('${MyConstant.domain}${userModel!.avatar}'),
      ),
      accountName: Text(userModel == null ? 'name ?' : userModel!.name),
      accountEmail: Text(userModel == null ? 'Type ?' : userModel!.type),
    );
  }

  ListTile menuShowOrder() {
    return ListTile(
      onTap: () {
        setState(() {
          indexWidgets = 0;
          Navigator.pop(context);
        });
      },
      leading: Icon(Icons.filter_1_outlined, color: MyConstant.dark),
      title: ShowTitle(title: 'Show Orders', textStyle: MyConstant().h2Style()),
      subtitle: ShowTitle(
          title: 'Show details ordered', textStyle: MyConstant().h3Style()),
    );
  }

  ListTile menuShowManage() {
    return ListTile(
      onTap: () {
        setState(() {
          indexWidgets = 1;
          Navigator.pop(context);
        });
      },
      leading: Icon(Icons.filter_2_outlined, color: MyConstant.dark),
      title: ShowTitle(title: 'Shop Manage', textStyle: MyConstant().h2Style()),
      subtitle: ShowTitle(
          title: 'Show details of shop (Customer can see)',
          textStyle: MyConstant().h3Style()),
    );
  }

  ListTile menuShowProduct() {
    return ListTile(
      onTap: () {
        setState(() {
          indexWidgets = 2;
          Navigator.pop(context);
        });
      },
      leading: Icon(Icons.filter_3_outlined, color: MyConstant.dark),
      title:
          ShowTitle(title: 'Show Product', textStyle: MyConstant().h2Style()),
      subtitle: ShowTitle(
          title: 'Show details of our product',
          textStyle: MyConstant().h3Style()),
    );
  }
}
