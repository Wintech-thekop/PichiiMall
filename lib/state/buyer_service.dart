// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:pichiimall/bodys/my_money_buyer.dart';
import 'package:pichiimall/bodys/my_order_buyer.dart';
import 'package:pichiimall/bodys/show_all_shop_buyer.dart';
import 'package:pichiimall/state/show_cart.dart';
import 'package:pichiimall/utility/my_constant.dart';
import 'package:pichiimall/widgets/show_signout.dart';
import 'package:pichiimall/widgets/show_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BuyerService extends StatefulWidget {
  const BuyerService({Key? key}) : super(key: key);

  @override
  _BuyerServiceState createState() => _BuyerServiceState();
}

class _BuyerServiceState extends State<BuyerService> {
  List<Widget> widgets = [
    ShowAllShopBuyer(),
    MyMoneyBuyer(),
    MyOrderBuyer(),
  ];
  int indexWidgets = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buyer'),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, MyConstant.routeShowCart),
            icon: Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      drawer: Drawer(
        child: Stack(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Column(
              children: [
                buildHeader(),
                menuShowAllShop(),
                menuMyMoney(),
                menuMyOrder(),
              ],
            ),
            ShowSignOut(),
          ],
        ),
      ),
      body: widgets[indexWidgets],
    );
  }

  ListTile menuShowAllShop() {
    return ListTile(
      leading: Icon(
        Icons.shop_outlined,
        size: 36,
        color: MyConstant.dark,
      ),
      title:
          ShowTitle(title: 'Show All Shop', textStyle: MyConstant().h2Style()),
      subtitle: ShowTitle(
          title: 'แสดงร้านค้าทั้งหมด', textStyle: MyConstant().h3Style()),
      onTap: () {
        setState(() {
          indexWidgets = 0;
          Navigator.pop(context);
        });
      },
    );
  }

  ListTile menuMyMoney() {
    return ListTile(
      leading: Icon(
        Icons.money,
        size: 36,
        color: MyConstant.dark,
      ),
      title: ShowTitle(title: 'My Money', textStyle: MyConstant().h2Style()),
      subtitle: ShowTitle(
          title: 'แสดงจำนวนเงินทั้งหมด', textStyle: MyConstant().h3Style()),
      onTap: () {
        setState(() {
          indexWidgets = 1;
          Navigator.pop(context);
        });
      },
    );
  }

  ListTile menuMyOrder() {
    return ListTile(
      leading: Icon(
        Icons.list,
        size: 36,
        color: MyConstant.dark,
      ),
      title: ShowTitle(title: 'My Order', textStyle: MyConstant().h2Style()),
      subtitle: ShowTitle(
          title: 'แสดงรายการสั่งซื้อสินค้าทั้งหมด',
          textStyle: MyConstant().h3Style()),
      onTap: () {
        setState(() {
          indexWidgets = 2;
          Navigator.pop(context);
        });
      },
    );
  }

  UserAccountsDrawerHeader buildHeader() =>
      UserAccountsDrawerHeader(accountName: null, accountEmail: null);
}
