
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickie_event/Constant.dart';
import 'package:quickie_event/ConstantScreens/AuthScreens/WelcomeScreen.dart';
import 'package:quickie_event/Quicke_Events/Widgets/TextWidget.dart';
import 'package:quickie_event/helper/logging_utils.dart';
import 'package:quickie_event/helper/storage_helper.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../ConstantProviders/AuthProviders.dart';

class IntrductionScreen3 extends StatelessWidget {
  IntrductionScreen3({super.key});
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
              "assets/img/intro3.png",
              width: width * 0.7,
            ),
            SizedBox(
              height: 50,
            ),
            TextWidget(
              title: "Confirm Your Purchase",
              size: 28,
            ),
            SizedBox(
              height: 20,
            ),
            TextWidget(
              title: "Make the final purchase and\nget the quick delivery.",
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
                Storage.isFirstRun(true);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WelcomeScreen()));
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
