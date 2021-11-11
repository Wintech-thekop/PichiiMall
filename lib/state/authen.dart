import 'package:flutter/material.dart';
import 'package:pichiimall/utility/my_constant.dart';
import 'package:pichiimall/widgets/show_image.dart';

class Authen extends StatefulWidget {
  const Authen({Key? key}) : super(key: key);

  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width; // เป็นการหาความกว้างตามขนาดหน้าจอ
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: size*0.6, // กำหนดความกว้างของรูปภาพเป็น 60% ของหน้าจอ
          child: ShowImage(path: MyConstant.image1),
        ),
      ),
    );
  }
}
