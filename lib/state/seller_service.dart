// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pichiimall/bodys/shop_manager_seller.dart';
import 'package:pichiimall/bodys/show_order_seller.dart';
import 'package:pichiimall/bodys/show_product_seller.dart';
import 'package:pichiimall/utility/my_constant.dart';
import 'package:pichiimall/widgets/show_signout.dart';
import 'package:pichiimall/widgets/show_title.dart';

class SellerService extends StatefulWidget {
  const SellerService({Key? key}) : super(key: key);

  @override
  _SellerServiceState createState() => _SellerServiceState();
}

class _SellerServiceState extends State<SellerService> {
  List<Widget> widgets = [
    ShowOrderSeller(),
    ShopManageSeller(),
    ShowProductSeller()
  ];

  int indexWidgets = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seller'),
        
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            ShowSignOut(),
            Column(
              children: [
                UserAccountsDrawerHeader(accountName: null, accountEmail: null),
                menuShowOrder(),
                menuShowManage(),
                menuShowProduct(),
              ],
            ),
          ],
        ),
      ),
      body: widgets[indexWidgets],
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
