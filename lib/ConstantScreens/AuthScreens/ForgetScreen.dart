import 'package:flutter/material.dart';
import 'package:quickie_event/Constant.dart';
import 'package:quickie_event/ConstantScreens/AuthScreens/WelcomeScreen.dart';
import 'package:quickie_event/Quicke_Events/Widgets/TextWidget.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../Quicke_Features/Widget_Features/TextFieldFeature.dart';
import 'Enter4DigitPinCode.dart';

class ForgetScreen extends StatelessWidget {
  ForgetScreen({super.key});
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
                  title: "Forgot Password",
                  size: 28,
                ),
                SizedBox(
                  height: 20,
                ),
                TextWidget(
                  title:
                      "Enter your e-mail for verfication proccess. We\nwill send you a 4-digits verification code\nin your eamil.",
                  size: 17,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFieldFeatures(
                    context: context,
                    name: "Email",
                    controller: email,
                    suffixIcon: Icon(Icons.close_rounded)),
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
                            builder: (context) => Enter4DigitPinCode()));
                    buttonController.reset();
                  },
                  child: TextWidget(
                    title: "Get Code",
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
