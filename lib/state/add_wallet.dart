import 'package:flutter/material.dart';
import 'package:pichiimall/bodys/bank.dart';
import 'package:pichiimall/bodys/credit.dart';
import 'package:pichiimall/bodys/prompay.dart';
import 'package:pichiimall/utility/my_constant.dart';

class AddWallet extends StatefulWidget {
  const AddWallet({Key? key}) : super(key: key);

  @override
  State<AddWallet> createState() => _AddWalletState();
}

class _AddWalletState extends State<AddWallet> {
  List<Widget> widgets = [
    Bank(),
    Prompay(),
    Credit(),
  ];
  List<IconData> icons = [
    Icons.money,
    Icons.book,
    Icons.credit_card,
  ];
  List<String> titles = [
    "Bank",
    "Prompay",
    "Credit",
  ];

  int indexPosition = 0;

  List<BottomNavigationBarItem> bottomNavigationBarItems = [];

  @override
  void initState() {
    // TODO: implement initState

    int i = 0;
    for (var item in titles) {
      bottomNavigationBarItems
          .add(createBottomNavigationBarItem(icons[i], item));
      i++;
    }
  }

  BottomNavigationBarItem createBottomNavigationBarItem(
          IconData iconData, String string) =>
      BottomNavigationBarItem(
        icon: Icon(iconData),
        label: string,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Wallet from ${titles[indexPosition]}'),
      ),
      body: widgets[indexPosition],
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: IconThemeData(color: MyConstant.dark),
        unselectedIconTheme: IconThemeData(color: MyConstant.light),
        selectedItemColor: MyConstant.dark,
        unselectedItemColor: MyConstant.light,
        items: bottomNavigationBarItems,
        currentIndex: indexPosition,
        onTap: (value) {
          setState(() {
            indexPosition = value;
          });
        },
      ),
    );
  }
}
