import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickie_event/Constant.dart';
import 'package:quickie_event/ConstantIntroduction/IntroductionScreen1.dart';
import 'package:quickie_event/ConstantProviders/AuthProviders.dart';
import 'package:quickie_event/ConstantScreens/AuthScreens/LoginScreen.dart';
import 'package:quickie_event/ConstantScreens/AuthScreens/WelcomeScreen.dart';
import 'package:quickie_event/Quicke_Events/Screens/BottomNavigation/PersistanceNavigationBar.dart';
import 'package:quickie_event/Quicke_Features/Screen_Features/BottomNavigationFeatures/BottomNavigationFeatures.dart';
import 'package:quickie_event/helper/logging_utils.dart';
import 'package:quickie_event/helper/storage_helper.dart';

class SplashScreen extends StatefulWidget {

   SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    LoggingUtils.printValue("isfirst", Storage.getJWT());
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  !Storage.getIsMentorTutorialComplete()
              ?IntrductionScreen1():
                  Storage.getJWT() != null && Storage.getJWT().isNotEmpty
                      ? BottomNavigationFeatures()
                      : LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/img/logo.png",
          width: width * 0.4,
        ),
      ),
    );
  }
}
