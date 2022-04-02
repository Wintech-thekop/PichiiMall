// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pichiimall/bodys/approved.dart';
import 'package:pichiimall/bodys/waitting.dart';
import 'package:pichiimall/bodys/wallet.dart';
import 'package:pichiimall/utility/my_constant.dart';
import 'package:pichiimall/widgets/show_progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/wallet_model.dart';

class MyMoneyBuyer extends StatefulWidget {
  const MyMoneyBuyer({Key? key}) : super(key: key);

  @override
  _MyMoneyBuyerState createState() => _MyMoneyBuyerState();
}

class _MyMoneyBuyerState extends State<MyMoneyBuyer> {
  int indexWidget = 0;
  var widgets = <Widget>[];

  var titles = <String>['Wallet', 'Approved', 'Waiting'];
  var iconsDatas = <IconData>[
    Icons.money,
    Icons.fact_check,
    Icons.hourglass_bottom,
  ];

  var bottomNavigationBarItems = <BottomNavigationBarItem>[];
  int approvedWallet = 0;
  int waitApproveWallet = 0;
  bool load = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readAllWallet();
    setUpBottonBar();
  }

  Future<Null> readAllWallet() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var idBuyer = preferences.getString("id");
    print(idBuyer);
    var path =
        "${MyConstant.domain}/pichiimall/getWalletWhereIdBuyer.php?isAdd=true&idBuyer=$idBuyer";
    await Dio().get(path).then((value) {
      print(value);

      for (var item in json.decode(value.data)) {
        WalletModel model = WalletModel.fromMap(item);
        switch (model.status) {
          case 'Approved':
            approvedWallet = approvedWallet + int.parse(model.money);
            break;

          case 'WaitOrder':
            waitApproveWallet = waitApproveWallet + int.parse(model.money);
            break;
          default:
            break;
        }
      }
      // print('approvedWallet ==> $approvedWallet');
      // print('waitApproveWallet ==> $waitApproveWallet');

      widgets.add(Wallet(approveWallet: approvedWallet, waitApproveWallet: waitApproveWallet));
      widgets.add(Approved());
      widgets.add(Waiting());

      setState(() {
        load = false;
      });
    });
  }

  void setUpBottonBar() {
    int index = 0;
    for (var title in titles) {
      bottomNavigationBarItems.add(
        BottomNavigationBarItem(
          label: title,
          icon: Icon(
            iconsDatas[index],
          ),
        ),
      );
      index++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: load ? ShowProgress() : widgets[indexWidget],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: MyConstant.light,
        selectedItemColor: MyConstant.dark,
        onTap: (value) {
          setState(() {
            indexWidget = value;
          });
        },
        currentIndex: indexWidget,
        items: bottomNavigationBarItems,
      ),
    );
  }
}
