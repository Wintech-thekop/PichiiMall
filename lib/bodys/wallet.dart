import 'package:flutter/material.dart';
import 'package:pichiimall/widgets/show_title.dart';

import '../utility/my_constant.dart';

class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            newListTile(Icons.wallet_giftcard, 'จำนวนเงินที่ใช้ได้', 'xxxx THB'),
            newListTile(
                Icons.wallet_membership, 'จำนวนเงินที่รออนุมัติ', 'xxxx THB'),
            newListTile(Icons.grade_sharp, 'จำนวนเงินทั้งหมด', 'xxxx THB'),
          ],
        ),
      ),
    );
  }

  Widget newListTile(IconData iconData, String title, String subTitle) {
    return Container(
      width: 300,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: ListTile(
            leading: Icon(iconData),
            title: ShowTitle(
              title: title,
              textStyle: MyConstant().h2BlueStyle(),
            ),
            subtitle: ShowTitle(
              title: subTitle,
              textStyle: MyConstant().h1Style(),
            ),
          ),
        ),
      ),
    );
  }
}
