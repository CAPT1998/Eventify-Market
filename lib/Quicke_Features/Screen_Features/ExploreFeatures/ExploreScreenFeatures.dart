import 'package:flutter/material.dart';
import 'package:quickie_event/Constant.dart';
import 'package:quickie_event/Quicke_Events/Widgets/TextWidget.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ExploreScreenFeatures extends StatefulWidget {
  const ExploreScreenFeatures({super.key});

  @override
  State<ExploreScreenFeatures> createState() => _ExploreScreenFeaturesState();
}

class _ExploreScreenFeaturesState extends State<ExploreScreenFeatures> {
  RoundedLoadingButtonController buttonController =
      RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            Image.asset(
              "assets/img/logo.png",
              width: width * 0.5,
            ),
             SizedBox(
              height: 50,
            ),
            TextWidget(title: "Don't have any item in your cart",size: 20,fontWeight: FontWeight.w500),
            SizedBox(
              height: 50,
            ),
            RoundedLoadingButton(
                borderRadius: 10,
                controller: buttonController,
                onPressed: () {},
                child: TextWidget(
                  title: "Explore",
                  size: 16,
                  color: Colors.white,
                ))
          ],
        ),
      ),
    );
  }
}
