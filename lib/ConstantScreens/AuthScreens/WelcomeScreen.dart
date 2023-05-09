import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickie_event/ConstantProviders/AuthProviders.dart';
import 'package:quickie_event/ConstantScreens/AuthScreens/LoginScreen.dart';
import 'package:quickie_event/ConstantScreens/AuthScreens/RegistrationScreen.dart';
import 'package:quickie_event/Quicke_Events/Widgets/TextWidget.dart';
import 'package:quickie_event/Quicke_Features/Widget_Features/TextFieldFeature.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../Constant.dart';
import '../../Quicke_Features/Screen_Features/BottomNavigationFeatures/BottomNavigationFeatures.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool passwordVisible = true;
  RoundedLoadingButtonController buttonController =
      RoundedLoadingButtonController();
  RoundedLoadingButtonController gbuttonController =
      RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, value, child) => Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                Image.asset("assets/img/welcome.png"),
                SizedBox(
                  height: 40,
                ),
                TextWidget(title: "Welcome to Shoppir", size: 27),
                SizedBox(
                  height: 10,
                ),
                TextWidget(
                    title:
                        "Log in Explore all the genuine products and get deliver to your doorstep.",
                    size: 17,
                    maxline: 3,
                    fontWeight: FontWeight.w700,
                    color: Color(0XFF828588)),
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: width,
                  child: RoundedLoadingButton(
                    width: width,
                    height: 60,
                    borderRadius: 10,
                    controller: buttonController,
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                      buttonController.reset();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        TextWidget(
                          title: "  Continue with Email",
                          size: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: width,
                  child: RoundedLoadingButton(
                    // width: width,
                    color: blueColor,
                    height: 60,
                    borderRadius: 10,
                    controller: buttonController,
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.facebook,
                          color: Colors.white,
                        ),
                        TextWidget(
                          title: "  Continue with Facebook",
                          size: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: width,
                  child: RoundedLoadingButton(
                    // width: width,
                    color: Colors.red,
                    height: 60,
                    borderRadius: 10,
                    controller: gbuttonController,
                    onPressed: () async {
                      await value.signInWithGoogle();
                      if (value.isUserCreated == true) {
                        gbuttonController.success();
                        SuccessFlushbar(
                            context, "Sign in", "Google Sign in Successfull");
                        Timer(Duration(seconds: 2), () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      BottomNavigationFeatures()));
                          gbuttonController.reset();
                        });
                      } else {
                        gbuttonController.error();
                        ErrorFlushbar(
                            context, "Sign in", "Google Sign in UnSuccessfull");
                        Timer(Duration(seconds: 2), () {
                          gbuttonController.reset();
                        });
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.g_mobiledata,
                          color: Colors.white,
                        ),
                        TextWidget(
                          title: "  Continue with Google",
                          size: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: width,
                  child: RoundedLoadingButton(
                    // width: width,
                    color: Colors.black,
                    height: 60,
                    borderRadius: 10,
                    controller: buttonController,
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.apple,
                          color: Colors.white,
                        ),
                        TextWidget(
                          title: "  Continue with Apple",
                          size: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegistrationScreen()));
                  },
                  child: TextWidget(
                    title: "Don’t have an account? Register",
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
