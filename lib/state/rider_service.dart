import 'package:flutter/material.dart';
import 'package:pichiimall/utility/my_constant.dart';

class RiderService extends StatefulWidget {
  const RiderService({ Key? key }) : super(key: key);

  @override
  _RiderServiceState createState() => _RiderServiceState();
}

class _RiderServiceState extends State<RiderService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rider'),
        backgroundColor: MyConstant.primary,
      ),
    );
  }
}