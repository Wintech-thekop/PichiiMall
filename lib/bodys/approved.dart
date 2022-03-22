import 'package:flutter/material.dart';
import 'package:pichiimall/widgets/show_title.dart';

class Approved extends StatefulWidget {
  const Approved({ Key? key }) : super(key: key);

  @override
  State<Approved> createState() => _ApprovedState();
}

class _ApprovedState extends State<Approved> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ShowTitle(title: 'This is Approved',),
    );
  }
}