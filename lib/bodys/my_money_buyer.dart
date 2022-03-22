// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pichiimall/bodys/approved.dart';
import 'package:pichiimall/bodys/waitting.dart';
import 'package:pichiimall/bodys/wallet.dart';
import 'package:pichiimall/utility/my_constant.dart';

class MyMoneyBuyer extends StatefulWidget {
  const MyMoneyBuyer({Key? key}) : super(key: key);

  @override
  _MyMoneyBuyerState createState() => _MyMoneyBuyerState();
}

class _MyMoneyBuyerState extends State<MyMoneyBuyer> {
  int indexWidget = 0;
  var widgets = <Widget>[
    Wallet(),
    Approved(),
    Waiting(),
  ];

  var titles = <String>['Wallet', 'Approved', 'Waiting'];
  var iconsDatas = <IconData>[
    Icons.money,
    Icons.fact_check,
    Icons.hourglass_bottom,
  ];

  var bottomNavigationBarItems = <BottomNavigationBarItem>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setUpBottonBar();
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
      body: widgets[indexWidget],
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
