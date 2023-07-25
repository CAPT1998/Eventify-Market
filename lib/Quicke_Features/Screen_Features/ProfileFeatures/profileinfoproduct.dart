import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:quickie_event/Constant.dart';
import 'package:quickie_event/ConstantModels/LoginModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../ConstantProviders/AuthProviders.dart';
import '../../../Quicke_Events/Screens/HomeScreens/ProfileScreen.dart';
import '../../../Quicke_Events/Widgets/SizedBoxWidget.dart';
import '../../../Quicke_Events/Widgets/TextFormWidget.dart';
import '../../../Quicke_Events/Widgets/TextWidget.dart';
import 'ProfileScreenFeatures.dart';

class PersonalInformationScreenProducts extends StatefulWidget {
  const PersonalInformationScreenProducts({super.key});

  @override
  State<PersonalInformationScreenProducts> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState
    extends State<PersonalInformationScreenProducts> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }


 

  bool passwordVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: TextWidget(title: "Personal Info", size: 16),
        backgroundColor: Colors.grey[50],
        elevation: 0,
        centerTitle: true,
      ),
      body: Consumer<AuthProvider>(
        builder: (context, value, child) => SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizeWidget(height: 50),
                  CircleAvatar(
                    radius: 50,
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
                          } else if (loadingProgress.cumulativeBytesLoaded ==
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
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        (loadingProgress.expectedTotalBytes ??
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
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      await value.profileUpdate(
                          context,
                        value.loginModel[0].data!.id.toString(),
                        value.loginModel[0].data!.apiToken);
                      final prefs = await SharedPreferences.getInstance();
                      String email = prefs.getString('email') ?? '';
                      String password = prefs.getString('password') ?? '';

                      await value.profilepictureupdate(
                        email: email,
                        password: password,
                      );
                     value.loginModel[0].data!.media![0].url = value.profile;
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => ProfileScreenFeatures(),
                        ),
                        (route) => false,
                      );
                    },
                    child: TextWidget(
                      title: "Change Picture",
                      fontWeight: FontWeight.w600,
                      color: appColor,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      TextWidget(
                        title: " Name ",
                        fontWeight: FontWeight.w600,
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () async {
                          await value.updateprofile(
                            id: value.loginModel[0].data!.id.toString(),
                            name: nameController.text,
                            email: "",
                            password: "",
                            phone: "",
                          );
                          Navigator.pop(context, nameController.text);
                        },
                        child: TextWidget(
                          title: "Change",
                          fontWeight: FontWeight.w600,
                          color: appColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  textfieldProduct(
                    context: context,
                    name: value.loginModel[0].data!.name ?? "No name",
                    controller: nameController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      TextWidget(
                        title: "Email",
                        fontWeight: FontWeight.w600,
                      ),
                      Spacer(),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  textfieldProduct(
                    inputtype: TextInputType.none,
                    isread: true,
                    context: context,
                    name:value.loginModel[0].data!.email ?? " ",
                    controller: emailController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      TextWidget(
                        title: "Password",
                        fontWeight: FontWeight.w600,
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () async {
                          await value.updateprofile(
                            id:value.loginModel[0].data!.id.toString(),
                            name: "",
                            email: "",
                            password: passwordController.text,
                            phone: "",
                          );
                        },
                        child: TextWidget(
                          title: "Update",
                          fontWeight: FontWeight.w600,
                          color: appColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  textfieldProduct(
                    context: context,
                    name: " ",
                    obscureText: passwordVisible,
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                        icon: Icon(passwordVisible
                            ? Icons.visibility_off
                            : Icons.visibility)),
                    controller: passwordController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      TextWidget(
                        title: "Phone",
                        fontWeight: FontWeight.w600,
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () async {
                          await value.updateprofile(
                            id:value.loginModel[0].data!.id.toString(),
                            name: "",
                            email: "",
                            password: "",
                            phone: phoneController.text,
                          );
                        },
                        child: TextWidget(
                          title: "Update",
                          fontWeight: FontWeight.w600,
                          color: appColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  textfieldProduct(
                    isread: true,
                    context: context,
                    name: value.loginModel[0].data!.phone ?? "123456789 ",
                    controller: emailController,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
