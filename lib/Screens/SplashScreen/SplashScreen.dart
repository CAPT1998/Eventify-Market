import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quickie_event/Constant.dart';
import 'package:quickie_event/Screens/BottomNavigation/PersistanceNavigationBar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => BottomNavigationScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Image.asset("assets/img/logo.png"),
      ),
    );
  }
}
