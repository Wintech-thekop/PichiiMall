import 'package:flutter/material.dart';
import 'package:pichiimall/utility/my_constant.dart';

class SellerService extends StatefulWidget {
  const SellerService({ Key? key }) : super(key: key);

  @override
  _SellerServiceState createState() => _SellerServiceState();
}

class _SellerServiceState extends State<SellerService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seller'),
        backgroundColor: MyConstant.primary,
      ),
    );
  }
}