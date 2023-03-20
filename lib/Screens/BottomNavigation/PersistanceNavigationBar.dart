import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:quickie_event/Screens/HomeScreens/DiscoverScreen.dart';
import 'package:quickie_event/Screens/HomeScreens/FavouriteScreen.dart';
import 'package:quickie_event/Screens/HomeScreens/MyTicketScreen.dart';
import 'package:quickie_event/Screens/HomeScreens/ProfileScreen.dart';

import '../../Constant.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        items: _navBarsItems(),
        resizeToAvoidBottomInset: false,
        hideNavigationBarWhenKeyboardShows: true,
        screens: [
          DiscoverScreen(),
          FavouriteScreen(),
          MyticketScreen(),
          ProfileScreen(),
        ],
        navBarStyle: NavBarStyle.style6,
      ),
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.dashboard_outlined),
        title: ("Discover"),
        textStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w900),
        activeColorPrimary: appColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.favorite_border,
        ),
        title: ("Favorites"),
        textStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w900),
        activeColorPrimary: appColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          CupertinoIcons.ticket,
        ),
        title: ("My Tickets"),
        textStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w900),
        activeColorPrimary: appColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person_outline_outlined),
        // icon: apbar_photo = Image.asset(
        //   "assets/logo/photo.png",
        //   height: 25,
        // ),
        title: ("Profile"),
        textStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w900),
        activeColorPrimary: appColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }
}
