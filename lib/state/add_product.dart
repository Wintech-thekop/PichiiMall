// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, avoid_print, prefer_void_to_null, deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pichiimall/utility/my_constant.dart';
import 'package:pichiimall/widgets/show_image.dart';
import 'package:pichiimall/widgets/show_title.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final formKey = GlobalKey<FormState>();

  List<File?> files = []; // files = [null, null, null, null];
  File? file;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void initialFile() {
    for (var i = 0; i < 4; i++) {
      files.add(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    buildProductName(constraints),
                    buildProductPrice(constraints),
                    buildProductDetail(constraints),
                    buildImage(constraints),
                    addProductButton(constraints),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container addProductButton(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.75,
      child: ElevatedButton(
        style: MyConstant().myButtonStyle(),
        onPressed: () {
          if (formKey.currentState!.validate()) {}
        },
        child: Text('Add Product'),
      ),
    );
  }

  Future<Null> processImagePicker(ImageSource source, int index) async {
    try {
      var result = await ImagePicker().getImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
      );
      setState(() {
        file = File(result!.path);
     //  files[index] = file;
      });
    } catch (e) {}
  }

  Future<Null> chooseSourceImageDialog(int index) async {
    print("You click image$index");
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: ShowImage(path: MyConstant.image4),
          title: ShowTitle(
              title: 'Source Image ${index + 1} ?',
              textStyle: MyConstant().h2Style()),
          subtitle: ShowTitle(
              title: 'Please select Tab from Camera or Gallery',
              textStyle: MyConstant().h3Style()),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  processImagePicker(ImageSource.camera, index);
                },
                child: Text('Camera'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  processImagePicker(ImageSource.gallery, index);
                },
                child: Text('Gallery'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Column buildImage(BoxConstraints constraints) {
    return Column(
      children: [
        Container(
          width: constraints.maxWidth * 0.75,
          height: constraints.maxWidth * 0.75,
          child: file == null ? Image.asset(MyConstant.image5) : Image.file(file!),
        ),
        Container(
          width: constraints.maxWidth * 0.75,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 50,
                height: 50,
                child: InkWell(
                  child: Image.asset(MyConstant.image5),
                  onTap: () => chooseSourceImageDialog(0),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: InkWell(
                  child: Image.asset(MyConstant.image5),
                  onTap: () => chooseSourceImageDialog(1),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: InkWell(
                  child: Image.asset(MyConstant.image5),
                  onTap: () => chooseSourceImageDialog(2),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: InkWell(
                  child: Image.asset(MyConstant.image5),
                  onTap: () => chooseSourceImageDialog(3),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildProductDetail(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.75,
      margin: EdgeInsets.only(top: 15),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอกรายละเอียดสินค้าด้วยค่ะ';
          } else {
            return null;
          }
        },
        maxLines: 4,
        decoration: InputDecoration(
          hintText: 'Product detail :',
          hintStyle: MyConstant().h3Style(),
          prefixIcon: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
            child: Icon(
              Icons.details_sharp,
              color: MyConstant.dark,
            ),
          ),
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
    );
  }

  Widget buildProductPrice(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.75,
      margin: EdgeInsets.only(top: 15),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอกราคาด้วยค่ะ';
          } else {
            return null;
          }
        },
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'Product Price :',
          labelStyle: MyConstant().h3Style(),
          prefixIcon: Icon(
            Icons.money_sharp,
            color: MyConstant.dark,
          ),
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
    );
  }

  Widget buildProductName(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.75,
      margin: EdgeInsets.only(top: 15),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณากรอกชื่อสินค้าด้วยค่ะ';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelText: 'Product Name :',
          labelStyle: MyConstant().h3Style(),
          prefixIcon: Icon(
            Icons.production_quantity_limits_sharp,
            color: MyConstant.dark,
          ),
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
    );
  }
}
