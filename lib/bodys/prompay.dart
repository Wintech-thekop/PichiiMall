// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:file_utils/file_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pichiimall/utility/my_constant.dart';
import 'package:pichiimall/utility/my_dialog.dart';
import 'package:pichiimall/widgets/show_progress.dart';
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
            buildQRcodePrompay(),
            buildDownload(),
          ],
        ),
      ),
    );
  }

  ElevatedButton buildDownload() {
    return ElevatedButton(
      onPressed: () async {
        String path = '/sdcard/download';
        try {
          await FileUtils.mkdir([path]);
          await Dio().download(MyConstant.urlPrompay, '$path/prompay.png').then(
              (value) => MyDialog().normalDialog(
                  context,
                  'Download Prompay Finish',
                  'กรุณาไปที่แอพธนาคารของท่าน เพื่ออ่าน QR Code ที่โหลดมา'));
        } catch (e) {
          MyDialog().normalDialog(context, 'Storage Permission Denied',
              'กรุณาเปิด Permission Storage ด้วยค่ะ');
        }
      },
      child: Text('Download QRcode'),
    );
  }

  Container buildQRcodePrompay() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: CachedNetworkImage(
        imageUrl: MyConstant.urlPrompay,
        placeholder: (context, url) => ShowProgress(),
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
            textStyle: MyConstant().h3Style(),
          ),
          trailing: IconButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: '0845503246'));
              MyDialog().normalDialog(context, 'Copy Prompay success',
                  'คัดลอกพร้อมเพย์สำเร็จแล้ว กรุณาไปที่แอพธนาคารของท่าน เพื่อโอนเงินผ่านระบบพร้อมเพย์ได้เลยค่ะ');
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
      textStyle: MyConstant().h1Style(),
    );
  }
}
