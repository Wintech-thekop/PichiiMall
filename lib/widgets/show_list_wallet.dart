import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pichiimall/models/wallet_model.dart';
import 'package:pichiimall/utility/my_constant.dart';
import 'package:pichiimall/widgets/show_image.dart';
import 'package:pichiimall/widgets/show_progress.dart';
import 'package:pichiimall/widgets/show_title.dart';

class ShowListWallet extends StatelessWidget {
  const ShowListWallet({
    Key? key,
    required this.WalletModels,
  }) : super(key: key);

  final List<WalletModel>? WalletModels;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: WalletModels!.length,
        itemBuilder: (context, index) => Card(
              color: index % 2 == 0
                  ? MyConstant.light.withOpacity(0.5)
                  : MyConstant.light.withOpacity(0.25),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ShowTitle(
                            title: WalletModels![index].money,
                            textStyle: MyConstant().h1Style()),
                        Container(
                          width: 150,
                          height: 170,
                          child: CachedNetworkImage(
                              placeholder: (context, url) => ShowProgress(),
                              errorWidget: (context, url, error) =>
                                  ShowImage(path: 'images/bill.png'),
                              imageUrl:
                                  '${MyConstant.domain}/pichiimall${WalletModels![index].pathSlip}'),
                        ),
                      ],
                    ),
                    ShowTitle(
                        title: WalletModels![index].datePay,
                        textStyle: MyConstant().h2BlueStyle()),
                  ],
                ),
              ),
            ));
  }
}
