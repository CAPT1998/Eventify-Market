import 'package:flutter/material.dart';
import 'package:quickie_event/Constant.dart';
import 'package:quickie_event/ConstantIntroduction/IntroductionScreen2.dart';
import 'package:quickie_event/Quicke_Events/Widgets/TextWidget.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class IntrductionScreen1 extends StatelessWidget {
  IntrductionScreen1({super.key});
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
              "assets/img/intro1.png",
              width: width * 0.7,
            ),
            SizedBox(
              height: 50,
            ),
            TextWidget(
              title: "Explore Best Products",
              size: 28,
            ),
            SizedBox(
              height: 20,
            ),
            TextWidget(
              title:
                  "Browse 2 million+ products and\nfind your desire product.",
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
                        builder: (context) => IntrductionScreen2()));
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
