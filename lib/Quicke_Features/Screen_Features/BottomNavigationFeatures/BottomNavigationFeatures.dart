import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:quickie_event/Quicke_Features/Screen_Features/CartFeatures/CartScreenFeatures.dart';
import 'package:quickie_event/Quicke_Features/Screen_Features/ChatFeatures/ChatScreenFeatures.dart';
import 'package:quickie_event/Quicke_Features/Screen_Features/HomeFeatures/HomeScreenFeatures.dart';
import 'package:quickie_event/Quicke_Features/Screen_Features/ProfileFeatures/ProfileScreenFeatures.dart';
import '../../../Constant.dart';
import 'package:flutter/material.dart';

import '../../../helper/firebase_deeplinking.dart';
import '../ExploreFeatures/ExploreScreenFeatures.dart';

class BottomNavigationFeatures extends StatefulWidget {
  const BottomNavigationFeatures({key}) : super(key: key);

  @override
  _BottomNavigationFeaturesState createState() =>
      _BottomNavigationFeaturesState();
}

class _BottomNavigationFeaturesState extends State<BottomNavigationFeatures> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      FirebaseDeepLink().handleInitialUri(context);
      FirebaseDeepLink().handleIncomingLinks(context);
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          PersistentTabView(
            context,
            controller: _controller,
            items: _navBarsItems(),
            resizeToAvoidBottomInset: false,
            hideNavigationBarWhenKeyboardShows: true,
            screens: [
              HomeScreenFeatures(),
              ChatScreenFeatures(),
              ExploreScreenFeatures(),
              CartScreenFeatures(),
              ProfileScreenFeatures(),
            ],
            navBarStyle: NavBarStyle.style6,
          ),
        ],
      ),
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: ("Home"),
        textStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w900),
        activeColorPrimary: appColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.chat_outlined,
        ),
        title: ("Chat"),
        textStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w900),
        activeColorPrimary: appColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          CupertinoIcons.search,
        ),
        title: ("Explore"),
        textStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w900),
        activeColorPrimary: appColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.shopping_cart_outlined),
        title: ("Cart"),
        textStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w900),
        activeColorPrimary: appColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person),
        title: ("Profile"),
        textStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w900),
        activeColorPrimary: appColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }
}
