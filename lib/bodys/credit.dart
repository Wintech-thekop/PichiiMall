// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pichiimall/utility/my_constant.dart';
import 'package:pichiimall/widgets/show_title.dart';

class Credit extends StatefulWidget {
  const Credit({Key? key}) : super(key: key);

  @override
  State<Credit> createState() => _CreditState();
}

class _CreditState extends State<Credit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTitle('Name Surname'),
            buildNameSurname(),
            buildTitle('ID Card No.'),
            formIDCard(),
            buildExpiresCVC(),
            buildTitle('Amount : '),
            formAmount(),
            Spacer(),
            buildButtonAddMoney(),
          ],
        ),
      ),
    );
  }

  Container buildButtonAddMoney() {
    return Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: Text('Add Money'),
            ),
          );
  }

  Widget formAmount() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          suffix: ShowTitle(
            title: 'THB.',
            textStyle: MyConstant().h2RedStyle(),
          ),
          label: ShowTitle(title: 'Amount : '),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  Container buildExpiresCVC() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          buildSizeBox(30),
          Expanded(
            child: Column(
              children: [
                buildTitle('Expires End : '),
                formExpiresDate(),
              ],
            ),
          ),
          buildSizeBox(8),
          Expanded(
            child: Column(
              children: [
                buildTitle('CVC : '),
                formCVC(),
              ],
            ),
          ),
          buildSizeBox(30),
        ],
      ),
    );
  }

  Widget formExpiresDate() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: 'xx/xxxx',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget formCVC() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: 'xxx',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget formIDCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'xxxx-xxxx-xxxx-xxxx',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  Container buildNameSurname() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          buildSizeBox(30),
          formName(),
          buildSizeBox(8),
          formSurname(),
          buildSizeBox(30),
        ],
      ),
    );
  }

  SizedBox buildSizeBox(double width) => SizedBox(
        width: width,
      );

  Widget formName() {
    return Expanded(
      child: TextFormField(
        decoration: InputDecoration(
          label: ShowTitle(title: 'Name : '),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  Widget formSurname() {
    return Expanded(
      child: TextFormField(
        decoration: InputDecoration(
          label: ShowTitle(title: 'Surname : '),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  Widget buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ShowTitle(
        title: title,
        textStyle: MyConstant().h2BlueStyle(),
      ),
    );
  }
}
