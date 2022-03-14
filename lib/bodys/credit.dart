// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pichiimall/utility/my_constant.dart';
import 'package:pichiimall/widgets/show_title.dart';

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
            expiresDateMonth = stringExpiresDate?.substring(0, 2);
            expiresDateYear = stringExpiresDate?.substring(2, 6);
            print('idcard Value ==>> $idCard');
            print('expiresDate Value ==>> $stringExpiresDate');
            print('expiresDateMonth Value ==>> $expiresDateMonth');
            print('expiresDateYear Value ==>> $expiresDateYear');
            print('CVC Value ==>> $cvc');
          }
        },
        child: Text('Add Money'),
      ),
    );
  }

  Widget formAmount() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please fill Amount in blank';
          } else {
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
          return null;
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
