// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, deprecated_member_use

import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pichiimall/models/product_model.dart';
import 'package:pichiimall/utility/my_constant.dart';
import 'package:pichiimall/utility/my_dialog.dart';
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
  List<File?> files = [];

  bool statusImage = false;

  final formKey = GlobalKey<FormState>();

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
      files.add(null);
    }
    print('$pathImages');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                processEditProduct();
              },
              icon: Icon(Icons.cloud_upload),
              tooltip: 'Upload Editting Product',
            )
          ],
          title: Text('Edit Product'),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              behavior: HitTestBehavior.opaque,
              child: Form(
                key: formKey,
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
                    editProductButton(constraints),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Row editProductButton(BoxConstraints constraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: constraints.maxWidth * 0.75,
          child: ElevatedButton(
            style: MyConstant().myButtonStyle(),
            onPressed: () {
              processEditProduct();
            },
            child: Text('Upload Editting Product'),
          ),
        ),
      ],
    );
  }

  Future<Null> chooseImage(ImageSource source, int index) async {
    try {
      var result = await ImagePicker().getImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
      );
      setState(() {
        files[index] = File(result!.path);
        statusImage = true;
      });
    } catch (e) {}
  }

  Container buildImage(BoxConstraints constraints, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: MyConstant.light),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              chooseImage(ImageSource.camera, index);
            },
            icon: Icon(Icons.add_a_photo),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            width: constraints.maxWidth * 0.5,
            child: files[index] == null
                ? CachedNetworkImage(
                    imageUrl:
                        '${MyConstant.domain}/pichiimall${pathImages[index]}',
                    placeholder: (context, url) => ShowProgress(),
                  )
                : Image.file(files[index]!),
          ),
          IconButton(
            onPressed: () {
              chooseImage(ImageSource.gallery, index);
            },
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
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอกรายละเอียดสินค้าด้วยค่ะ';
              } else {
                return null;
              }
            },
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
            keyboardType: TextInputType.number,
            controller: productPriceController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอกราคาด้วยค่ะ';
              } else {
                return null;
              }
            },
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
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอกชื่อสินค้าด้วยค่ะ';
              } else {
                return null;
              }
            },
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

  Future<Null> processEditProduct() async {
    if (formKey.currentState!.validate()) {
      MyDialog().showProgressDialog(context);

      String name = productNameController.text;
      String price = productPriceController.text;
      String detail = productDetailController.text;
      String id = productModel!.id;
      String images;

      if (statusImage) {
        // upload image and refresh array pathImages
        int index = 0;
        for (var item in files) {
          if (item != null) {
            int i = Random().nextInt(1000000);
            String nameImage = 'productEdit$i.jpg';
            String apiUploadImage =
                '${MyConstant.domain}/pichiimall/saveProduct.php';

            Map<String, dynamic> map = {};
            map['file'] =
                await MultipartFile.fromFile(item.path, filename: nameImage);
            FormData formData = FormData.fromMap(map);
            await Dio().post(apiUploadImage, data: formData).then((value) {
              pathImages[index] = '/product/$nameImage';
            });
          }
          index++;
        }
        images = pathImages.toString();
        Navigator.pop(context);
      } else {
        images = pathImages.toString();
        Navigator.pop(context);
      }

      print('$id, $name, $price, $detail, $images');

      String apiEditProduct =
          '${MyConstant.domain}/pichiimall/editProductWhereId.php?isAdd=true&id=$id&name=$name&price=$price&detail=$detail&images=$images';
      await Dio().get(apiEditProduct).then((value) => Navigator.pop(context));
    }
  }
}
