import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:quickie_event/Constant.dart';
import 'package:quickie_event/Quicke_Events/Screens/Profile/CreateNewEvent.dart';
import 'package:quickie_event/Quicke_Events/Screens/Profile/FollowingScreen.dart';
import 'package:quickie_event/Quicke_Events/Screens/Profile/MyEvents.dart';
import 'package:quickie_event/Quicke_Events/Screens/Profile/MyPrivateEvents.dart';
import 'package:quickie_event/Quicke_Events/Screens/Profile/NotificationCenterScreen.dart';
import 'package:quickie_event/Quicke_Events/Screens/Profile/PaymentLinkScreen.dart';
import 'package:quickie_event/Quicke_Events/Screens/Profile/PersonalInformationScreen.dart';
import 'package:quickie_event/Quicke_Events/Screens/Profile/SelectCategoryForPrivateEvent.dart';
import 'package:quickie_event/Quicke_Events/Screens/SearchingEvents/SearchCategoryScreen.dart';
import 'package:quickie_event/Quicke_Events/Widgets/TextWidget.dart';

import '../../../ConstantProviders/AuthProviders.dart';
import '../../../ConstantScreens/AuthScreens/WelcomeScreen.dart';
import '../../../helper/storage_helper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage("assets/img/f4.png"),
                  ),
                  title: TextWidget(title: "UserName", size: 16),
                  subtitle: Text("abc@gmail.com"),
                ),
                Divider(
                  color: greyColor,
                ),
                ListTile(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: PersonalInformationScreen(),
                      withNavBar: false,
                    );
                  },
                  leading: Icon(Icons.person),
                  title: TextWidget(
                    title: "Personal data",
                    size: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                Divider(
                  color: greyColor,
                ),
                ListTile(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: SearchCategoryScreen(),
                      withNavBar: false,
                    );
                  },
                  leading: Icon(Icons.manage_search_sharp),
                  title: TextWidget(
                    title: "Searching",
                    size: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                Divider(
                  color: greyColor,
                ),
                ListTile(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: FollowingScreen(),
                      withNavBar: false,
                    );
                  },
                  leading: Icon(Icons.folder_copy_outlined),
                  title: TextWidget(
                    title: "Following",
                    size: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                Divider(
                  color: greyColor,
                ),
                ListTile(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: MyEvents(),
                      withNavBar: false,
                    );
                  },
                  leading: Icon(Icons.folder_copy_outlined),
                  title: TextWidget(
                    title: "My Events",
                    size: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                Divider(
                  color: greyColor,
                ),
                ListTile(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: SelectCategoryByCreateEvent(),
                      withNavBar: false,
                    );
                  },
                  leading: Icon(Icons.event_note_outlined),
                  title: TextWidget(
                    title: "Create Private Event",
                    size: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                Divider(
                  color: greyColor,
                ),
                ListTile(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: MyPrivateEvents(),
                      withNavBar: false,
                    );
                  },
                  
                  leading: Icon(Icons.event_note_outlined),
                  title: TextWidget(
                    title: "My Private Event",
                    size: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                Divider(
                  color: greyColor,
                ),
                ListTile(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: NotificationCenterScreen(),
                      withNavBar: false,
                    );
                  },
                  leading: Icon(Icons.notifications_active_outlined),
                  title: TextWidget(
                    title: "Notfication",
                    size: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                Divider(
                  color: greyColor,
                ),
                ListTile(
                  onTap: () {
                    _bottomSheet(context);
                  },
                  leading: Icon(Icons.language),
                  title: TextWidget(
                    title: "Language",
                    size: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                Divider(
                  color: greyColor,
                ),
                ListTile(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: PaymentLinkScreen(),
                      withNavBar: false,
                    );
                  },
                  leading: Icon(Icons.payment),
                  title: TextWidget(
                    title: "Payment",
                    size: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                Divider(
                  color: greyColor,
                ),
                ListTile(
                  onTap: () {
                    Storage.saveJWT("");

                    Provider.of<AuthProvider>(context, listen: false).setIsFirstRun(false);

                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                        WelcomeScreen()), (Route<dynamic> route) => false);

                  },
                  leading: Icon(Icons.logout),
                  title: TextWidget(
                    title: "Logout",
                    size: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _bottomSheet(context) {
  showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      )),
      context: context,
      builder: (context) {
        return Container(
          height: height * 0.6,
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    TextWidget(
                      title: "Langauge",
                      fontWeight: FontWeight.w700,
                      size: 16,
                    ),
                    Spacer(),
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: lightGreyColor,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close,
                          color: Colors.black,
                          size: 15,
                        ),
                      ),
                    )
                  ],
                ),
                Divider(
                  color: greyColor,
                ),
                SizedBox(
                  height: 20,
                ),
                _OrganizerWidget(title: "English (United States)"),
                _OrganizerWidget(title: "English (United Kingdom)"),
                _OrganizerWidget(title: "Espanol (America Latina)"),
                _OrganizerWidget(title: "Espanol (Espana)"),
                _OrganizerWidget(title: "Francais (France)"),
                _OrganizerWidget(title: "Bahasa Indonesia"),
                _OrganizerWidget(title: "Japanese"),
              ],
            ),
          ),
        );
      });
}

Widget _OrganizerWidget({String? title}) {
  return Container(
    margin: EdgeInsets.only(bottom: 5),
    width: width,
    decoration: BoxDecoration(
      border: Border.all(color: lightGreyColor),
      borderRadius: BorderRadius.circular(10),
    ),
    child: ListTile(
      title: TextWidget(
        title: "$title",
        size: 14,
        fontWeight: FontWeight.w500,
      ),
      leading: Icon(Icons.language),
      trailing: Icon(Icons.arrow_forward_ios),
    ),
  );
}
