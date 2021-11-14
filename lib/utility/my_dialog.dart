import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pichiimall/utility/my_constant.dart';
import 'package:pichiimall/widgets/show_image.dart';
import 'package:pichiimall/widgets/show_title.dart';

class MyDialog {
  // ignore: prefer_void_to_null
  Future<Null> alertLocationService(BuildContext context, String title, String message) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: ShowImage(path: MyConstant.image4),
          title: ShowTitle(
              title: title,
              textStyle: MyConstant().h2Style()),
          subtitle: ShowTitle(
              title: message,
              textStyle: MyConstant().h3Style()),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await Geolocator.openLocationSettings();
              exit(0); // ปิดแอพเราทิ้งไป
            },
            // ignore: prefer_const_constructors
            child: Text('OK'),
          )
        ],
      ),
    );
  }
}
