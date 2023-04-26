import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:quickie_event/Constant.dart';
import 'package:quickie_event/ConstantScreens/AuthScreens/ChangePassword.dart';
import 'package:quickie_event/ConstantScreens/AuthScreens/WelcomeScreen.dart';
import 'package:quickie_event/Quicke_Events/Widgets/TextWidget.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../Quicke_Features/Widget_Features/TextFieldFeature.dart';

class Enter4DigitPinCode extends StatelessWidget {
  Enter4DigitPinCode({super.key});
  RoundedLoadingButtonController buttonController =
      RoundedLoadingButtonController();
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),
                Image.asset(
                  "assets/img/forget.png",
                  width: width,
                ),
                SizedBox(
                  height: 50,
                ),
                TextWidget(
                  title: "Enter 4-digits code",
                  size: 28,
                ),
                SizedBox(
                  height: 20,
                ),
                TextWidget(
                  title:
                      "Enter the 4-digits code that you recieved on your email.",
                  size: 17,
                  maxline: 2,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(
                  height: 20,
                ),
                Pinput(
                  // controller: pinController,
                  length: 4,
                  toolbarEnabled: false,
                  inputFormatters: [Formatter()],
                ),
                SizedBox(
                  height: 50,
                ),
                RoundedLoadingButton(
                  color: appColor,
                  borderRadius: 10,
                  controller: buttonController,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangePassword()));
                    buttonController.reset();

                  },
                  child: TextWidget(
                    title: "Continue",
                    color: Colors.white,
                    size: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Formatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.length <= 3) {
      return oldValue;
    }
    return newValue;
  }
}
