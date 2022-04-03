// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pichiimall/bodys/approved.dart';
import 'package:pichiimall/bodys/waitting.dart';
import 'package:pichiimall/bodys/wallet.dart';
import 'package:pichiimall/utility/my_constant.dart';
import 'package:pichiimall/widgets/show_no_data.dart';
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
  bool? haveWallet;

  // List<WalletModel> approvedWalletModels = [];
  var approvedWalletModels = <WalletModel>[];
  var waitWalletModels = <WalletModel>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readAllWallet();
    setUpBottomBar();
  }

  Future<Null> readAllWallet() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var idBuyer = preferences.getString("id");
    print(idBuyer);
    var path =
        "${MyConstant.domain}/pichiimall/getWalletWhereIdBuyer.php?isAdd=true&idBuyer=$idBuyer";
    await Dio().get(path).then((value) {
      print(value);

      if (value.toString() != 'null') {
        for (var item in json.decode(value.data)) {
          WalletModel model = WalletModel.fromMap(item);
          switch (model.status) {
            case 'Approved':
              approvedWallet = approvedWallet + int.parse(model.money);
              approvedWalletModels.add(model);
              break;

            case 'WaitOrder':
              waitApproveWallet = waitApproveWallet + int.parse(model.money);
              waitWalletModels.add(model);
              break;
            default:
              break;
          }
        }
        // print('approvedWallet ==> $approvedWallet');
        // print('waitApproveWallet ==> $waitApproveWallet');

        widgets.add(
          Wallet(
              approveWallet: approvedWallet,
              waitApproveWallet: waitApproveWallet),
        );
        widgets.add(
          Approved(
            walletModels: approvedWalletModels,
          ),
        );
        widgets.add(
          Waiting(
            walletModels: waitWalletModels,
          ),
        );
        setState(() {
          load = false;
          haveWallet = true;
        });
      } else {
        print('No wallet status');
        setState(() {
          load = false;
          haveWallet = false;
        });
      }
    });
  }

  void setUpBottomBar() {
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
      body: load
          ? ShowProgress()
          : haveWallet!
              ? widgets[indexWidget]
              : ShowNoData(
                  title: 'There is no Wallet',
                  pathImage: MyConstant.image1,
                ),
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
