// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pichiimall/models/product_model.dart';
import 'package:pichiimall/utility/my_constant.dart';
import 'package:pichiimall/widgets/show_progress.dart';
import 'package:pichiimall/widgets/show_title.dart';

class EditProduct extends StatefulWidget {
  final ProductModel productModel;
  const EditProduct({Key? key, required this.productModel}) : super(key: key);

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  ProductModel? productModel;
  TextEditingController productNameController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productDetailController = TextEditingController();

  List<String> pathImages = [];

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    productModel = widget.productModel;
    // print("Name edit is ${productModel!.name}");

    productNameController.text = productModel!.name;
    productPriceController.text = productModel!.price;
    productDetailController.text = productModel!.detail;

    convertStringToArray();
  }

  void convertStringToArray() {
    String string = productModel!.images;
    string = string.substring(1, string.length - 1);
    List<String> strings = string.split(',');
    for (var item in strings) {
      pathImages.add(item.trim());
    }
    print('$pathImages');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Product'),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTitle('General :'),
                buildProductName(constraints),
                buildProductPrice(constraints),
                buildProductDetail(constraints),
                buildTitle('Image Product :'),
                buildImage(constraints, 0),
                buildImage(constraints, 1),
                buildImage(constraints, 2),
                buildImage(constraints, 3),
              ],
            ),
          ),
        ));
  }

  Container buildImage(BoxConstraints constraints, int index) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add_a_photo),
          ),
          Container(
            width: constraints.maxWidth * 0.5,
            child: CachedNetworkImage(
              imageUrl: '${MyConstant.domain}/pichiimall${pathImages[index]}',
              placeholder: (context, url) => ShowProgress(),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add_photo_alternate),
          ),
        ],
      ),
    );
  }

  Row buildProductDetail(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: constraints.maxWidth * 0.75,
          child: TextFormField(
            maxLines: 3,
            controller: productDetailController,
            decoration: InputDecoration(
              labelText: 'Product Detail:',
              labelStyle: MyConstant().h3Style(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.dark),
                borderRadius: BorderRadius.circular(25),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.light),
                borderRadius: BorderRadius.circular(25),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildProductPrice(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: constraints.maxWidth * 0.75,
          child: TextFormField(
            controller: productPriceController,
            decoration: InputDecoration(
              labelText: 'Product Price (THB):',
              labelStyle: MyConstant().h3Style(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.dark),
                borderRadius: BorderRadius.circular(25),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.light),
                borderRadius: BorderRadius.circular(25),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildProductName(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: constraints.maxWidth * 0.75,
          child: TextFormField(
            controller: productNameController,
            decoration: InputDecoration(
              labelText: 'Product Name:',
              labelStyle: MyConstant().h3Style(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.dark),
                borderRadius: BorderRadius.circular(25),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.light),
                borderRadius: BorderRadius.circular(25),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Container buildTitle(String string) {
    return Container(
      margin: EdgeInsets.all(15),
      child: ShowTitle(title: string, textStyle: MyConstant().h2Style()),
    );
  }
}
