// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pichiimall/utility/my_constant.dart';
import 'package:pichiimall/utility/my_dialog.dart';
import 'package:pichiimall/widgets/show_title.dart';

class Prompay extends StatefulWidget {
  const Prompay({Key? key}) : super(key: key);

  @override
  State<Prompay> createState() => _PrompayState();
}

class _PrompayState extends State<Prompay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            buildTitle(),
            buildCopyPrompay(),
          ],
        ),
      ),
    );
  }

  Widget buildCopyPrompay() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        color: Colors.lime.shade100,
        child: ListTile(
          title: ShowTitle(
            title: '0845503246',
            textStyle: MyConstant().h1Style(),
          ),
          subtitle: ShowTitle(
            title: 'บัญชีพร้อมเพย์',
            textStyle: MyConstant().h2Style(),
          ),
          trailing: IconButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: '0845503246'));
              MyDialog().normalDialog(
                  context, 'Copy Prompay success', 'Copy พร้อมเพย์สำเร็จแล้ว กรุณาไปที่แอพธนาคารของท่าน เพื่อโอนเงินผ่านระบบพร้อมเพย์ได้เลยค่ะ');
            },
            icon: Icon(
              Icons.copy,
              color: MyConstant.dark,
            ),
          ),
        ),
      ),
    );
  }

  ShowTitle buildTitle() {
    return ShowTitle(
      title: 'การโอนเงินผ่านระบบ Prompay',
      textStyle: MyConstant().h2Style(),
    );
  }
}
