import 'package:flutter/material.dart';
import 'package:pichiimall/widgets/show_title.dart';

class Waiting extends StatefulWidget {
  const Waiting({ Key? key }) : super(key: key);

  @override
  State<Waiting> createState() => _WaitingState();
}

class _WaitingState extends State<Waiting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ShowTitle(title: 'This is Walting',),
    );
  }
}