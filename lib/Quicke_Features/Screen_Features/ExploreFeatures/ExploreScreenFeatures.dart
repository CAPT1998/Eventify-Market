import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:quickie_event/Constant.dart';
import 'package:quickie_event/Quicke_Events/Widgets/TextWidget.dart';
import 'package:quickie_event/Quicke_Features/Screen_Features/SearchFeatures/SearchFeatureScreen.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../Model/ProductScreenResponseModel.dart';
import '../../providers/HomeProviders.dart';
import '../Categories/ProductScreen.dart';

class ExploreScreenFeatures extends StatefulWidget {
  ExploreScreenFeatures({super.key});

  @override
  State<ExploreScreenFeatures> createState() => _ExploreScreenFeaturesState();
}

class _ExploreScreenFeaturesState extends State<ExploreScreenFeatures> {
  RoundedLoadingButtonController buttonController =
      RoundedLoadingButtonController();
  List<Categories> _filteredListReviews = [];

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
            TextWidget(
                title: "Don't have any item in your cart",
                size: 20,
                fontWeight: FontWeight.w500),
            SizedBox(
              height: 50,
            ),
            Consumer<HomeProvider>(builder: (context, person, child) {
              _filteredListReviews = person.getProductScreenData != null
                  ? person.getProductScreenData!.data!.categories!
                  : [];

              return RoundedLoadingButton(
                  borderRadius: 10,
                  controller: buttonController,
                  onPressed: () {
                    PersistentNavBarNavigator.pushNewScreen(context,
                        screen: ProductScreen(
                            _filteredListReviews[0].id.toString()),
                        withNavBar: false);
                    buttonController.reset();
                  },
                  child: TextWidget(
                    title: "Explore",
                    size: 16,
                    color: Colors.white,
                  ));
            })
          ],
        ),
      ),
    );
  }
}
