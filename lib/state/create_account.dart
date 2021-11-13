import 'package:flutter/material.dart';
import 'package:pichiimall/utility/my_constant.dart';
import 'package:pichiimall/widgets/show_title.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  @override
  Widget build(BuildContext context) {
    double size =
        MediaQuery.of(context).size.width; // เป็นการหาความกว้างตามขนาดหน้าจอ
    return Scaffold(
      appBar: AppBar(
        title: Text('Create new Account'),
        backgroundColor: MyConstant.primary,
      ),
      body: ListView(
        padding: EdgeInsets.all(15),
        children: [
          buildTitle('ข้อมูลทั่วไป :'),
          buildName(size),
          buildTitle('ชนิดของ User :'),
        ],
      ),
    );
  }

  Container buildTitle(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: ShowTitle(
        title: title,
        textStyle: MyConstant().h2Style(),
      ),
    );
  }
}

Row buildName(double size) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        margin: EdgeInsets.only(top: 15),
        width: size * 0.6, // กำหนดความกว้างของรูปภาพเป็น 60% ของหน้าจอ
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Name :',
            labelStyle: MyConstant().h3Style(),
            prefixIcon: Icon(
              Icons.fingerprint,
              color: MyConstant.dark,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyConstant.dark),
              borderRadius: BorderRadius.circular(25),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyConstant.light),
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
      ),
    ],
  );
}
