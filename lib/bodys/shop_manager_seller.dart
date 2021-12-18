// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pichiimall/models/user_model.dart';
import 'package:pichiimall/utility/my_constant.dart';
import 'package:pichiimall/widgets/show_title.dart';

class ShopManageSeller extends StatefulWidget {
  final UserModel userModel;
  const ShopManageSeller({Key? key, required this.userModel}) : super(key: key);

  @override
  _ShopManageSellerState createState() => _ShopManageSellerState();
}

class _ShopManageSellerState extends State<ShopManageSeller> {
  UserModel? userModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userModel = widget.userModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShowTitle(title: 'Shop name : ', textStyle: MyConstant().h2Style()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ShowTitle(
                      title: userModel!.name, textStyle: MyConstant().h1Style()),
                ),
              ],
            ),
            ShowTitle(title: 'Address : ', textStyle: MyConstant().h2Style()),
            Row(mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(width: constraints.maxWidth * 0.6,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ShowTitle(
                        title: userModel!.address, textStyle: MyConstant().h2Style()),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
