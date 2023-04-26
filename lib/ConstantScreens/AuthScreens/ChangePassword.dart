import 'package:flutter/material.dart';
import 'package:quickie_event/Constant.dart';
import 'package:quickie_event/ConstantScreens/AuthScreens/ConfirmationScreen.dart';
import 'package:quickie_event/ConstantScreens/AuthScreens/WelcomeScreen.dart';
import 'package:quickie_event/Quicke_Events/Widgets/TextWidget.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../Quicke_Features/Widget_Features/TextFieldFeature.dart';
import 'Enter4DigitPinCode.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({super.key});
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
                  "assets/img/change.png",
                  width: width,
                  height: height * 0.3,
                ),
                SizedBox(
                  height: 50,
                ),
                TextWidget(
                  title: "Create a new password",
                  size: 28,
                ),
                SizedBox(
                  height: 20,
                ),
                TextWidget(
                  title:
                      "Make a new password for future log in to\nShoppir platform.",
                  size: 17,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFieldFeatures(
                    context: context,
                    name: "Enter a new password",
                    controller: email,
                    suffixIcon: Icon(Icons.close_rounded)),
                SizedBox(
                  height: 20,
                ),
                TextFieldFeatures(
                    context: context,
                    name: "Re-type the password",
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
                            builder: (context) => ConfirmationScreen()));
                    buttonController.reset();
                  },
                  child: TextWidget(
                    title: "Reset Password",
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
