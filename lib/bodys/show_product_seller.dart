// ignore_for_file: prefer_const_constructors, avoid_print, prefer_void_to_null

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pichiimall/models/product_model.dart';
import 'package:pichiimall/state/edit_product.dart';
import 'package:pichiimall/utility/my_constant.dart';
import 'package:pichiimall/widgets/show_image.dart';
import 'package:pichiimall/widgets/show_progress.dart';
import 'package:pichiimall/widgets/show_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowProductSeller extends StatefulWidget {
  const ShowProductSeller({Key? key}) : super(key: key);

  @override
  _ShowProductSellerState createState() => _ShowProductSellerState();
}

class _ShowProductSellerState extends State<ShowProductSeller> {
  bool load = true;
  bool? haveData;
  List<ProductModel> productModels = [];

  @override
  void initState() {
    super.initState();
    loadValueFromAPI();
  }

  Future<Null> loadValueFromAPI() async {
    if (productModels.length != 0) {
      productModels.clear();
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id')!;
    String getProductWhereIdSeller =
        '${MyConstant.domain}/pichiimall/getProductWhereIdSeller.php?isAdd=true&idSeller=$id';

    await Dio().get(getProductWhereIdSeller).then((value) {
      if (value.toString() == 'null') {
        // No data
        setState(() {
          load = false;
          haveData = false;
        });
      } else {
        // Have data
        for (var item in json.decode(value.data)) {
          // print('### value ==>> $value');
          ProductModel model = ProductModel.fromMap(item);
          print('### Product name ==>> ${model.name}');

          setState(() {
            load = false;
            haveData = true;
            productModels.add(model);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: load
          ? ShowProgress()
          : haveData!
              ? LayoutBuilder(
                  builder: (context, constraints) => buildListView(constraints),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ShowTitle(
                          title: 'Have no data',
                          textStyle: MyConstant().h1Style()),
                      ShowTitle(
                          title: 'Please add any Product',
                          textStyle: MyConstant().h2Style()),
                    ],
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyConstant.dark,
        onPressed: () =>
            Navigator.pushNamed(context, MyConstant.routeAddProduct).then(
          (value) => loadValueFromAPI(),
        ),
        child: Text('Add'),
      ),
    );
  }

  String buildUrl(String string) {
    String result = string.substring(1, string.length - 1);
    List<String> strings = result.split(',');
    String url = '${MyConstant.domain}/pichiimall${strings[0]}';
    return url;
  }

  ListView buildListView(BoxConstraints constraints) {
    return ListView.builder(
      itemCount: productModels.length,
      itemBuilder: (context, index) => Card(
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(4),
              height: constraints.maxWidth * 0.5,
              width: constraints.maxWidth * 0.5 - 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ShowTitle(
                    title: productModels[index].name,
                    textStyle: MyConstant().h2Style(),
                  ),
                  Container(
                    height: constraints.maxWidth * 0.37,
                    width: constraints.maxWidth * 0.5,
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: buildUrl(productModels[index].images),
                      placeholder: (context, url) => ShowProgress(),
                      errorWidget: (context, url, error) =>
                          ShowImage(path: MyConstant.image1),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.all(4),
              height: constraints.maxWidth * 0.4,
              width: constraints.maxWidth * 0.5 - 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShowTitle(
                    title: 'Price: ${productModels[index].price} THB',
                    textStyle: MyConstant().h2Style(),
                  ),
                  ShowTitle(
                    title: productModels[index].detail,
                    textStyle: MyConstant().h3Style(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProduct(productModel: productModels[index],),
                            ),
                          );
                        },
                        icon: Icon(Icons.edit_outlined,
                            size: 36, color: MyConstant.dark),
                      ),
                      IconButton(
                        onPressed: () {
                          print('You click delete index $index');
                          confirmDialogDelete(productModels[index]);
                        },
                        icon: Icon(Icons.delete_outlined,
                            size: 36, color: MyConstant.dark),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> confirmDialogDelete(ProductModel productModel) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: CachedNetworkImage(
            imageUrl: buildUrl(productModel.images),
            placeholder: (context, url) => ShowProgress(),
            errorWidget: (context, url, error) =>
                ShowImage(path: MyConstant.image1),
          ),
          title: ShowTitle(
            title: 'Delete ${productModel.name} ???',
            textStyle: MyConstant().h2Style(),
          ),
          subtitle: ShowTitle(
            title: productModel.detail,
            textStyle: MyConstant().h3Style(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              String apiDeleteProductWhereId =
                  '${MyConstant.domain}/pichiimall/deleteProductWhereId.php?isAdd=true&id=${productModel.id}';
              await Dio().get(apiDeleteProductWhereId).then((value) {
                Navigator.pop(context);
                loadValueFromAPI();
              });
            },
            child: Text('Delete'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
