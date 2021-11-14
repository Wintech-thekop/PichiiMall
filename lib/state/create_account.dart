// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pichiimall/utility/my_constant.dart';
import 'package:pichiimall/utility/my_dialog.dart';
import 'package:pichiimall/widgets/show_image.dart';
import 'package:pichiimall/widgets/show_title.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  String? typeUser;
  File? file;

  @override
  void initState() {
    // TODO: implement initState

    checkPermission();
  }

  // ignore: prefer_void_to_null
  Future<Null> checkPermission() async {
    bool locationService;
    LocationPermission locationPermission;

    locationService = await Geolocator
        .isLocationServiceEnabled(); // เป็นการค่า Service Location ด้วยแพ็กเกจ Geolocator

    if (locationService) {
      print('Service location opened');
      locationPermission = await Geolocator.checkPermission();
      if (locationPermission == LocationPermission.denied) {
        locationPermission = await Geolocator.requestPermission();
        if (locationPermission == LocationPermission.deniedForever) {
          MyDialog().alertLocationService(context, 'ไม่อนุญาตแชร์ Location', 'โปรดแชร์ Location');
        } else {
          //Find Latlng
        }
      } else if (locationPermission == LocationPermission.deniedForever) {
        MyDialog().alertLocationService(context, 'ไม่อนุญาตแชร์ Location', 'โปรดแชร์ Location');
      } else {
        //Find Latlng
      }
    } else {
      print('Service location Close');
      MyDialog().alertLocationService(context, 'Location Service ปิดอยู่!!', 'กรุณาเปิด Location Service ด้วยค่ะ');
    }
  }

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
            buildTitle('รูปภาพ :'),
            buildSubTitle(
                'แสดงรูปภาพของผู้ใช้งาน (หากไม่สะดวกจะแสดงเป็นรูป Default แทน)'),
            buildAvatar(size),
          ],
        ),
      ),
    );
  }

  Future<Null> chooseImage(ImageSource source) async {
    try {
      // ignore: deprecated_member_use
      var result = await ImagePicker().getImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
      );
      setState(() {
        file = File(result!.path);
      });
    } catch (e) {}
  }

  Row buildAvatar(double size) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => chooseImage(ImageSource.camera),
          icon: Icon(
            Icons.add_a_photo,
            size: 36,
            color: MyConstant.dark,
          ),
        ),
        Container(
          // ignore: prefer_const_constructors
          margin: EdgeInsets.symmetric(vertical: 15),
          width: size * 0.6, // กำหนดความกว้างของรูปภาพเป็น 60% ของหน้าจอ

          child: file == null
              ? ShowImage(path: MyConstant.avatar)
              : Image.file(file!),
        ),
        IconButton(
          onPressed: () => chooseImage(ImageSource.gallery),
          icon: Icon(
            Icons.add_photo_alternate,
            size: 36,
            color: MyConstant.dark,
          ),
        ),
      ],
    );
  }

  ShowTitle buildSubTitle(String message) {
    return ShowTitle(
      title: message,
      textStyle: MyConstant().h3Style(),
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
