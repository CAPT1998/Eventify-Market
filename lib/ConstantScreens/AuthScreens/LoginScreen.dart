import 'package:flutter/material.dart';
import 'package:quickie_event/Quicke_Events/Widgets/TextWidget.dart';
import 'package:quickie_event/Quicke_Features/Widget_Features/TextFieldFeature.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../Constant.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passwordVisible = true;
  RoundedLoadingButtonController buttonController =
      RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                  suffixIcon: Icon(Icons.close_rounded)),
              SizedBox(
                height: 15,
              ),
              TextFieldFeatures(
                context: context,
                name: "Password",
                obscureText: passwordVisible,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                  icon: Icon(
                    passwordVisible ? Icons.visibility_off : Icons.visibility,
                    // color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.center,
                child: TextWidget(
                  title: "Forget Password?",
                  size: 15,
                  fontWeight: FontWeight.w400,
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
                  onPressed: () {
                  
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
                  controller: buttonController,
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
            ],
          ),
        ),
      ),
    );
  }
}
