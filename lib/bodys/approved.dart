import 'package:flutter/material.dart';
import 'package:pichiimall/models/wallet_model.dart';
import 'package:pichiimall/utility/my_constant.dart';
import 'package:pichiimall/widgets/show_title.dart';

import '../widgets/show_list_wallet.dart';

class Approved extends StatefulWidget {
  final List<WalletModel> walletModels;

  const Approved({Key? key, required this.walletModels}) : super(key: key);

  @override
  State<Approved> createState() => _ApprovedState();
}

class _ApprovedState extends State<Approved> {
  List<WalletModel>? approvedWalletModels;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    approvedWalletModels = widget.walletModels;
    print('approvedWalletModels = ${approvedWalletModels!.length}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: approvedWalletModels?.isEmpty ?? true
          ? ShowTitle(
              title: 'No Money approve', textStyle: MyConstant().h1Style())
          : ShowListWallet(
              WalletModels: approvedWalletModels,
            ),
    );
  }
}
