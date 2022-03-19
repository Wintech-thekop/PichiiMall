// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:omise_flutter/omise_flutter.dart';
import 'package:pichiimall/utility/my_constant.dart';
import 'package:pichiimall/widgets/show_title.dart';

import '../utility/my_dialog.dart';

import 'package:http/http.dart' as http;

class Credit extends StatefulWidget {
  const Credit({Key? key}) : super(key: key);

  @override
  State<Credit> createState() => _CreditState();
}

class _CreditState extends State<Credit> {
  String? name,
      surname,
      idCard,
      expiresDateMonth,
      expiresDateYear,
      cvc,
      amount,
      stringExpiresDate;
  MaskTextInputFormatter idCardMask =
      MaskTextInputFormatter(mask: '####-####-####-####');
  MaskTextInputFormatter expiresDateMask =
      MaskTextInputFormatter(mask: '##/####');
  MaskTextInputFormatter cvcMask = MaskTextInputFormatter(mask: '###');

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: Form(
          key: formKey,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTitle('Name Surname'),
                    buildNameSurname(),
                    buildTitle('ID Card No.'),
                    formIDCard(),
                    buildExpiresCVC(),
                    buildTitle('Amount : '),
                    formAmount(),
                    // Spacer(),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  buildButtonAddMoney(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildButtonAddMoney() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            getTokenAndChargeOmise();
          }
        },
        child: Text('Add Money'),
      ),
    );
  }

  Future<Null> getTokenAndChargeOmise() async {
    String publicKey = MyConstant.omisePublicKey;

    // print('name ==>> $name, surname ==>> $surname');
    // print('publicKey ==>> $publicKey');
    // print('idcard Value ==>> $idCard');
    // print('expiresDate Value ==>> $stringExpiresDate');
    // print('expiresDateMonth Value ==>> $expiresDateMonth');
    // print('expiresDateYear Value ==>> $expiresDateYear');
    // print('CVC Value ==>> $cvc');

    OmiseFlutter omiseFlutter = OmiseFlutter(publicKey);
    await omiseFlutter.token
        .create('$name $surname', idCard!, expiresDateMonth!, expiresDateYear!,
            cvc!)
        .then((value) async {
      String token = value.id.toString();
      print('token Value ==>> $token');

      String secretKey = MyConstant.omiseSecretKey;
      String urlAPI = MyConstant.omiseChargeUrl;
      String basicAuth = 'Basic ' + base64Encode(utf8.encode(secretKey + ":"));

      Map<String, String> headerMap = {};
      headerMap['authorization'] = basicAuth;
      headerMap['Cache-Control'] = 'no-cache';
      headerMap['Content-Type'] = 'application/x-www-form-urlencoded';

      String zero = '00';
      amount = '$amount$zero';
      print('amount ==> $amount');

      Map<String, dynamic> data = {};
      data['amount'] = amount;
      data['currency'] = 'thb';
      data['card'] = token;

      Uri uri = Uri.parse(urlAPI);

      http.Response response = await http.post(
        uri,
        headers: headerMap,
        body: data,
      );
      var resultCharge = json.decode(response.body);
      // print('resultCharge ==> $resultCharge');

      print('Status ของการตัดบัตร--->>> ${resultCharge['status']}');
    }).catchError((value) {
      String title = value.code;
      String message = value.message;
      MyDialog().normalDialog(context, title, message);
    });
  }

  Widget formAmount() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please fill Amount in blank';
          } else {
            amount = value.trim();
            return null;
          }
        },
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          suffix: ShowTitle(
            title: 'THB.',
            textStyle: MyConstant().h2RedStyle(),
          ),
          label: ShowTitle(title: 'Amount : '),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  Container buildExpiresCVC() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          buildSizeBox(30),
          Expanded(
            child: Column(
              children: [
                buildTitle('Expires End : '),
                formExpiresDate(),
              ],
            ),
          ),
          buildSizeBox(8),
          Expanded(
            child: Column(
              children: [
                buildTitle('CVC : '),
                formCVC(),
              ],
            ),
          ),
          buildSizeBox(30),
        ],
      ),
    );
  }

  Widget formExpiresDate() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please fill Expires Date in blank';
        } else if (stringExpiresDate!.length != 6) {
          return 'Please fill correctly';
        } else {
          expiresDateMonth = stringExpiresDate?.substring(0, 2);
          expiresDateYear = stringExpiresDate?.substring(2, 6);

          int intExpiresDateMonth = int.parse(expiresDateMonth!);
          expiresDateMonth = intExpiresDateMonth.toString();

          if (intExpiresDateMonth > 12) {
            return 'Month lower than 12';
          } else {
            return null;
          }
        }
      },
      onChanged: (value) {
        stringExpiresDate = expiresDateMask.getUnmaskedText();
      },
      inputFormatters: [expiresDateMask],
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: 'xx/xxxx',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget formCVC() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please fill CVC number in blank';
        } else if (cvc!.length != 3) {
          return 'Please fill correctly';
        } else {
          return null;
        }
      },
      onChanged: (value) {
        cvc = cvcMask.getUnmaskedText();
      },
      inputFormatters: [cvcMask],
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: 'xxx',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget formIDCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please fill ID card in blank';
          } else if (idCard!.length != 16) {
            return 'ID card No. must has 16 charaters';
          } else {
            return null;
          }
        },
        inputFormatters: [idCardMask],
        onChanged: (value) {
//          idCard = value.trim();
          idCard = idCardMask.getUnmaskedText();
        },
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'xxxx-xxxx-xxxx-xxxx',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  Container buildNameSurname() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          buildSizeBox(30),
          formName(),
          buildSizeBox(8),
          formSurname(),
          buildSizeBox(30),
        ],
      ),
    );
  }

  SizedBox buildSizeBox(double width) => SizedBox(
        width: width,
      );

  Widget formName() {
    return Expanded(
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please fill Name in blank';
          } else {
            name = value.trim();
            return null;
          }
        },
        decoration: InputDecoration(
          label: ShowTitle(title: 'Name : '),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  Widget formSurname() {
    return Expanded(
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please fill Surname in blank';
          } else {
            surname = value.trim();
            return null;
          }
        },
        decoration: InputDecoration(
          label: ShowTitle(title: 'Surname : '),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  Widget buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ShowTitle(
        title: title,
        textStyle: MyConstant().h2BlueStyle(),
      ),
    );
  }
}
