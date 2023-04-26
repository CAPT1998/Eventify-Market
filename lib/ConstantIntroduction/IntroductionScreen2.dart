import 'package:flutter/material.dart';
import 'package:quickie_event/Constant.dart';
import 'package:quickie_event/ConstantIntroduction/IntroducationScreen3.dart';
import 'package:quickie_event/Quicke_Events/Widgets/TextWidget.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class IntrductionScreen2 extends StatelessWidget {
  IntrductionScreen2({super.key});
  RoundedLoadingButtonController buttonController =
      RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 150,
            ),
            Image.asset(
              "assets/img/intro2.png",
              width: width * 0.7,
            ),
            SizedBox(
              height: 50,
            ),
            TextWidget(
              title: "Select Your Product",
              size: 28,
            ),
            SizedBox(
              height: 20,
            ),
            TextWidget(
              title:
                  "Choose your desire product\nthat you want to buy.",
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
                        builder: (context) => IntrductionScreen3()));
                buttonController.reset();
              },
              child: TextWidget(
                title: "Start Shopping",
                color: Colors.white,
                size: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
