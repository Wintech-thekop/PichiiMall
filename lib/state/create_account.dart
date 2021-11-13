import 'package:flutter/material.dart';
import 'package:pichiimall/utility/my_constant.dart';
import 'package:pichiimall/widgets/show_title.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  String? typeUser;

  @override
  Widget build(BuildContext context) {
    double size =
        MediaQuery.of(context).size.width; // เป็นการหาความกว้างตามขนาดหน้าจอ
    return Scaffold(
      appBar: AppBar(
        title: Text('Create new Account'),
        backgroundColor: MyConstant.primary,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: ListView(
          padding: EdgeInsets.all(15),
          children: [
            buildTitle('ข้อมูลทั่วไป :'),
            buildName(size),
            buildTitle('ชนิดของ User :'),
            buildRadioBuyer(size),
            buildRadioSeller(size),
            buildRadioRider(size),
            buildTitle('ข้อมูลพื้นฐาน :'),
            buildAddress(size),
            buildPhone(size),
            buildUser(size),
            buildPassword(size),
          ],
        ),
      ),
    );
  }

  Row buildRadioBuyer(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.6,
          child: RadioListTile(
            value: 'buyer',
            groupValue: typeUser,
            onChanged: (value) {
              setState(() {
                typeUser = value as String?;
              });
            },
            title: ShowTitle(
              title: 'ผู้ซื้อ (Buyer)',
              textStyle: MyConstant().h3Style(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildRadioSeller(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.6,
          child: RadioListTile(
            value: 'seller',
            groupValue: typeUser,
            onChanged: (value) {
              setState(() {
                typeUser = value as String?;
              });
            },
            title: ShowTitle(
              title: 'ผู้ขาย (seller)',
              textStyle: MyConstant().h3Style(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildRadioRider(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.6,
          child: RadioListTile(
            value: 'rider',
            groupValue: typeUser,
            onChanged: (value) {
              setState(() {
                typeUser = value as String?;
              });
            },
            title: ShowTitle(
              title: 'ผู้จัดส่ง (Rider)',
              textStyle: MyConstant().h3Style(),
            ),
          ),
        ),
      ],
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

Row buildPassword(double size) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        margin: EdgeInsets.only(top: 15),
        width: size * 0.6, // กำหนดความกว้างของรูปภาพเป็น 60% ของหน้าจอ
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Password :',
            labelStyle: MyConstant().h3Style(),
            prefixIcon: Icon(
              Icons.lock,
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

Row buildUser(double size) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        margin: EdgeInsets.only(top: 15),
        width: size * 0.6, // กำหนดความกว้างของรูปภาพเป็น 60% ของหน้าจอ
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'User :',
            labelStyle: MyConstant().h3Style(),
            prefixIcon: Icon(
              Icons.perm_identity,
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

Row buildPhone(double size) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        margin: EdgeInsets.only(top: 15),
        width: size * 0.6, // กำหนดความกว้างของรูปภาพเป็น 60% ของหน้าจอ
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Phone :',
            labelStyle: MyConstant().h3Style(),
            prefixIcon: Icon(
              Icons.phone_iphone_outlined,
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

Row buildAddress(double size) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        margin: EdgeInsets.only(top: 15),
        width: size * 0.6, // กำหนดความกว้างของรูปภาพเป็น 60% ของหน้าจอ
        child: TextFormField(
          maxLines: 4,
          decoration: InputDecoration(
            hintText: 'Address :',
            hintStyle: MyConstant().h3Style(),
            prefixIcon: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
              child: Icon(
                Icons.home,
                color: MyConstant.dark,
              ),
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
