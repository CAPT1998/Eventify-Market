import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickie_event/ConstantProviders/AuthProviders.dart';
import 'package:quickie_event/ConstantScreens/AuthScreens/LoginScreen.dart';
import 'package:quickie_event/Quicke_Events/Widgets/TextWidget.dart';
import 'package:quickie_event/Quicke_Features/Widget_Features/TextFieldFeature.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../Constant.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool passwordVisible = true;
  RoundedLoadingButtonController buttonController =
      RoundedLoadingButtonController();
       RoundedLoadingButtonController fbuttonController =
      RoundedLoadingButtonController();
       RoundedLoadingButtonController gbuttonController =
      RoundedLoadingButtonController();
       RoundedLoadingButtonController abuttonController =
      RoundedLoadingButtonController();
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Consumer<AuthProvider>(
      builder: (context, value, child) => Scaffold(
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
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
                  TextFieldFeatures(
                      context: context,
                      name: "Full Name",
                      controller: name,
                      suffixIcon: Icon(Icons.close_rounded)),
                  SizedBox(
                    height: 15,
                  ),
                  TextFieldFeatures(
                      context: context,
                      name: "Email",
                      controller: email,
                      suffixIcon: Icon(Icons.close_rounded)),
                  SizedBox(
                    height: 15,
                  ),
                  TextFieldFeatures(
                    context: context,
                    name: "Password",
                    controller: password,
                    obscureText: passwordVisible,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                      icon: Icon(
                        passwordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        // color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextWidget(
                    title:
                        "By joining you are agree to our Terms of Service and Privacy Policy.",
                    size: 15,
                    maxline: 3,
                    fontWeight: FontWeight.w400,
                  ),
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
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await value.mSignUpAuth(
                            name: name.text,
                            email: email.text,
                            password: password.text,
                          );
                          if (value.registerMessage == "success") {
                            buttonController.success();
                            SuccessFlushbar(
                                context, "Register", "Register Successfull");
                            Timer(Duration(seconds: 2), () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                              buttonController.reset();
                            });
                          } else {
                            buttonController.error();
                            ErrorFlushbar(
                                context, "Register", "Register UnSuccessfull");
                            Timer(Duration(seconds: 2), () {
                              buttonController.reset();
                            });
                          }
                        } else {
                          buttonController.error();
                          Timer(Duration(seconds: 2), () {
                            buttonController.reset();
                          });
                        }
                      },
                      child: TextWidget(
                        title: "Register",
                        size: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: width * 0.38,
                        child: Divider(
                          // height: 30,
                          // thickness: 1,
                          color: greyColor,
                        ),
                      ),
                      TextWidget(
                        title: "  Or  ",
                        size: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        width: width * 0.38,
                        child: Divider(
                          // height: 30,
                          // thickness: 1,
                          color: greyColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    width: width,
                    child: RoundedLoadingButton(
                      // width: width,
                      color: blueColor,
                      height: 60,
                      borderRadius: 10,
                      controller: fbuttonController,
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
                      onPressed: () {},
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
                      controller: abuttonController,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
