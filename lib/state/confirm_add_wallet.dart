// ignore_for_file: prefer_const_constructors, prefer_if_null_operators

import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pichiimall/widgets/show_image.dart';
import 'package:pichiimall/widgets/show_title.dart';

import '../utility/my_constant.dart';
import '../utility/my_dialog.dart';

class ConfirmAddWallet extends StatefulWidget {
  const ConfirmAddWallet({Key? key}) : super(key: key);

  @override
  State<ConfirmAddWallet> createState() => _ConfirmAddWalletState();
}

class _ConfirmAddWalletState extends State<ConfirmAddWallet> {
  // late String dateTimeStr;
  // late File file;
  String? dateTimeStr;
  File? file;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    findCurrentTime();
  }

  void findCurrentTime() {
    DateTime dateTime = DateTime.now();
    DateFormat dateFormat = DateFormat('dd/MM/yyyy HH:mm');
    setState(() {
      dateTimeStr = dateFormat.format(dateTime);
    });
    // print(dateTimeStr);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm Add Wallet'),
        leading: IconButton(
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context, MyConstant.routeBuyerService, (route) => false),
          icon: Platform.isIOS
              ? Icon(Icons.arrow_back_ios)
              : Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          newHeader(),
          newDateTime(),
          Spacer(),
          newImages(),
          Spacer(),
          newButtonConfirm(),
        ],
      ),
    );
  }

  Future<Null> processTakePhoto(ImageSource source) async {
    try {
      var result = await ImagePicker().pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
      );
      setState(() {
        file = File(result!.path);
      });
    } catch (e) {}
  }

  Container newButtonConfirm() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (file == null) {
            MyDialog().normalDialog(context, 'There is no image',
                'Please take a photo or select from gallery');
          } else {
            processUploadAndInsertData();
          }
        },
        child: Text('Confirm Add Wallet'),
      ),
    );
  }

  Future<Null> processUploadAndInsertData() async {
    String apiSaveSlip = '${MyConstant.domain}/pichiimall/saveSlip.php';
    String nameSlip = 'slip${Random().nextInt(1000000)}.jpg';
    MyDialog().showProgressDialog(context);

    try {
      Map<String, dynamic> map = {};
      map['file'] =
          await MultipartFile.fromFile(file!.path, filename: nameSlip);
      FormData data = FormData.fromMap(map);
      await Dio().post(apiSaveSlip, data: data).then((value) {
        print(value);
        Navigator.pop(context);
      });
    } catch (e) {}
  }

  Row newImages() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {
              processTakePhoto(ImageSource.camera);
            },
            icon: Icon(Icons.add_a_photo)),
        // SvgPicture.asset('images/bill.svg'),
        Container(
          width: 200,
          height: 200,
          child: file == null
              ? ShowImage(path: 'images/bill.png')
              : Image.file(file!),
        ),
        IconButton(
            onPressed: () {
              processTakePhoto(ImageSource.gallery);
            },
            icon: Icon(Icons.add_photo_alternate)),
      ],
    );
  }

  ShowTitle newDateTime() {
    return ShowTitle(
      title: dateTimeStr == null ? 'dd/MM/yy HH:mm' : dateTimeStr!,
      textStyle: MyConstant().h2BlueStyle(),
    );
  }

  ShowTitle newHeader() {
    return ShowTitle(
      title: 'Current Date Pay',
      textStyle: MyConstant().h1Style(),
    );
  }
}
