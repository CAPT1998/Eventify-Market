import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickie_event/ConstantProviders/AuthProviders.dart';
import 'package:quickie_event/ConstantScreens/AuthScreens/ForgetScreen.dart';
import 'package:quickie_event/Quicke_Events/Screens/BottomNavigation/PersistanceNavigationBar.dart';
import 'package:quickie_event/Quicke_Events/Widgets/TextWidget.dart';
import 'package:quickie_event/Quicke_Features/Screen_Features/BottomNavigationFeatures/BottomNavigationFeatures.dart';
import 'package:quickie_event/Quicke_Features/Widget_Features/TextFieldFeature.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Constant.dart';
import 'RegistrationScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passwordVisible = true;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  RoundedLoadingButtonController buttonController =
      RoundedLoadingButtonController();
  RoundedLoadingButtonController fbuttonController =
      RoundedLoadingButtonController();
  RoundedLoadingButtonController gbuttonController =
      RoundedLoadingButtonController();
  RoundedLoadingButtonController abuttonController =
      RoundedLoadingButtonController();
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
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgetScreen()));
                      },
                      child: TextWidget(
                        title: "Forget Password?",
                        size: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
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
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setString('email', email.text);
                        await prefs.setString('password', password.text);
                        if (_formKey.currentState!.validate()) {
                          await value.mLoginAuth(
                            email: email.text,
                            password: password.text,
                          );
                          if (value.loginMessage == "success") {
                            buttonController.success();
                            SuccessFlushbar(
                                context, "Login", "Log in Successfull");
                            Timer(Duration(seconds: 2), () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          BottomNavigationFeatures()));
                              buttonController.reset();
                            });
                          } else {
                            buttonController.error();
                            ErrorFlushbar(
                                context, "Login", "Invalid Credentials...");
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
                        title: "LOG IN",
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
                      onPressed: () async {
                        await value.facebookLogin(context);
                        buttonController.reset();
                      },
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
                          ErrorFlushbar(context, "Sign in",
                              "Google Sign in UnSuccessfull");
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
      ),
    );
  }
}
