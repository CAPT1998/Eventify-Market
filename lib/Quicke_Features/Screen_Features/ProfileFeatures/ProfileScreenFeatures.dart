import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:quickie_event/Constant.dart';
import 'package:quickie_event/ConstantProviders/AuthProviders.dart';
import 'package:quickie_event/Quicke_Events/Screens/Profile/FollowingScreen.dart';
import 'package:quickie_event/Quicke_Events/Screens/Profile/NotificationCenterScreen.dart';
import 'package:quickie_event/Quicke_Events/Screens/Profile/PaymentLinkScreen.dart';
import 'package:quickie_event/Quicke_Events/Screens/Profile/PersonalInformationScreen.dart';
import 'package:quickie_event/Quicke_Events/Screens/SearchingEvents/SearchCategoryScreen.dart';
import 'package:quickie_event/Quicke_Events/Widgets/TextWidget.dart';
import 'package:quickie_event/Quicke_Features/Screen_Features/ProfileFeatures/profileinfoproduct.dart';

import '../../../ConstantModels/LoginModel.dart';
import '../../../helper/storage_helper.dart';
import '../SearchFeatures/SearchFeatureScreen.dart';

class ProfileScreenFeatures extends StatefulWidget {
  const ProfileScreenFeatures({super.key});

  @override
  State<ProfileScreenFeatures> createState() => _ProfileScreenFeaturesState();
}

class _ProfileScreenFeaturesState extends State<ProfileScreenFeatures> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, value, child) => SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Consumer<AuthProvider>(
                builder: (context, value, child) => Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: ClipOval(
                          child: Image.network(
                            value.loginModel[0].data?.media?.isNotEmpty == true
                                ? value.loginModel[0].data!.media![0].url!
                                : "http://quickeeapi.pakwexpo.com/images/logo_default.png",
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                // Image finished loading
                                return child;
                              } else if (loadingProgress
                                      .cumulativeBytesLoaded ==
                                  0) {
                                // Image failed to load, show fallback or error image from asset
                                return Image.asset('assets/img/2.png',
                                    width: 100, height: 100);
                              } else {
                                // Image is still loading
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            (loadingProgress
                                                    .expectedTotalBytes ??
                                                1)
                                        : null,
                                  ),
                                );
                              }
                            },
                            errorBuilder: (BuildContext context, Object error,
                                StackTrace? stackTrace) {
                              // Error occurred while loading the image, show fallback or error image from asset
                              return Image.asset('assets/img/2.png',
                                  width: 100, height: 100);
                            },
                          ),
                        ),
                      ),
                      title: TextWidget(
                          title:
                              "${value.loginModel[0].data!.name ?? value.userData["username"]}",
                          size: 16),
                      subtitle: Text(
                        "${value.loginModel[0].data!.email ?? value.userData["email"]}",
                      ),
                    ),
                    Divider(
                      color: greyColor,
                    ),
                    ListTile(
                      onTap: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: PersonalInformationScreenProducts(),
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
                        //  PersistentNavBarNavigator.pushNewScreen(
                        //     context,
                        //    screen: SearchFeatureScreen(),
                        //    withNavBar: false,
                        // );
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void _bottomSheet(BuildContext context) {
  void _changeLanguage(Locale locale) {
    context.setLocale(locale);
  }

  showModalBottomSheet(
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    context: context,
    builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.6,
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    tr('language'),
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  Spacer(),
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.grey,
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
                color: Colors.grey,
              ),
              SizedBox(height: 20),
              _OrganizerWidget(
                title: "tr('english_us')",
                onPressed: () {
                  _changeLanguage(Locale('en', 'US'));
                  Navigator.pop(context);
                },
              ),
              _OrganizerWidget(
                title: tr('english_uk'),
                onPressed: () {
                  _changeLanguage(Locale('en', 'UK'));
                  Navigator.pop(context);
                },
              ),
              // Add other languages with their respective Locale and onPressed function
            ],
          ),
        ),
      );
    },
  );
}

class _OrganizerWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;

  const _OrganizerWidget({
    required this.title,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
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
      ),
    );
  }
}
