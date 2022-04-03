import 'package:flutter/material.dart';
import 'package:pichiimall/models/wallet_model.dart';
import 'package:pichiimall/utility/my_constant.dart';
import 'package:pichiimall/widgets/show_list_wallet.dart';
import 'package:pichiimall/widgets/show_title.dart';

class Waiting extends StatefulWidget {
  final List<WalletModel> walletModels;
  const Waiting({Key? key, required this.walletModels}) : super(key: key);

  @override
  State<Waiting> createState() => _WaitingState();
}

class _WaitingState extends State<Waiting> {
  List<WalletModel>? waitWalletModels;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    waitWalletModels = widget.walletModels;
    print('waitWalletModels = ${waitWalletModels!.length}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: waitWalletModels?.isEmpty ?? true
          ? ShowTitle(
              title: 'No Money waiting', textStyle: MyConstant().h1Style())
          : ShowListWallet(
              WalletModels: waitWalletModels,
            ),
    );
  }
}
