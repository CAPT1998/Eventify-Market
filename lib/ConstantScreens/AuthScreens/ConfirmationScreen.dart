import 'package:flutter/material.dart';
import 'package:quickie_event/Constant.dart';
import 'package:quickie_event/ConstantScreens/AuthScreens/LoginScreen.dart';
import 'package:quickie_event/ConstantScreens/AuthScreens/WelcomeScreen.dart';
import 'package:quickie_event/Quicke_Events/Widgets/TextWidget.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../Quicke_Features/Widget_Features/TextFieldFeature.dart';
import 'Enter4DigitPinCode.dart';

class ConfirmationScreen extends StatelessWidget {
  ConfirmationScreen({super.key});
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                Image.asset(
                  "assets/img/confirm.png",
                  width: width,
                  height: height * 0.3,
                ),
                SizedBox(
                  height: 50,
                ),
                TextWidget(
                  title: "Confirmation",
                  size: 28,
                ),
                SizedBox(
                  height: 20,
                ),
                TextWidget(
                  title:
                      "Your password has been changed. Now you \ncan log in with your new password.",
                  size: 17,
                  alignment: TextAlign.center,
                  fontWeight: FontWeight.w400,
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
                            builder: (context) => LoginScreen()));
                    buttonController.reset();

                  },
                  child: TextWidget(
                    title: "Login",
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
