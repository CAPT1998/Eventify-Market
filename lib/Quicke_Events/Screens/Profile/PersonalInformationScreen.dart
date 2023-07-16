import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:quickie_event/Constant.dart';
import 'package:quickie_event/ConstantModels/LoginModel.dart';

import '../../../ConstantProviders/AuthProviders.dart';
import '../../Widgets/SizedBoxWidget.dart';
import '../../Widgets/TextFormWidget.dart';
import '../../Widgets/TextWidget.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({super.key});

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}



class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
@override
void initState() {
    super.initState();
    getProfileInfo();
}
   LoginModel? profile;

   LoginModel? getProfileInfo() {
    final box = GetStorage();
    String? userData = box.read("userKey");

    if (userData != null) {
       Map<String, dynamic> jsonMap = jsonDecode(userData);
setState(() {
        profile = LoginModel.fromJson(jsonMap);
        print("name is" + profile!.data.email);
      });
      return profile;
    } else {
      return null;
    }
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
        child:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizeWidget(height: 50),
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage("assets/img/f4.png"),
              ),
              TextWidget(
                title: "Change Picture",
                fontWeight: FontWeight.w600,
                color: appColor,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  TextWidget(
                    title: profile?.data.name ?? " ",
                    fontWeight: FontWeight.w600,
                  ),
                  Spacer(),
                  GestureDetector(
                onTap: () async {
  await value.updateprofile(
    id: profile!.data.id.toString(),
    name: nameController.text,
    email: "",
    password: "",
  );
  Navigator.pop(context, nameController.text); // Pass the updated name as a result
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
              textfieldProduct(context: context, name: profile?.data.name?? "No name",  controller: nameController,
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
                  GestureDetector(
                    onTap: () async {
                       await value.updateprofile(
                                                id:  profile!.data.id.toString(),

                        name: "",
                            email: emailController.text,
                            password: "",
                          );
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
              textfieldProduct(context: context, name: profile?.data.email?? " ",  controller: emailController,
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
                    onTap: ()async{
 await value.updateprofile(
                          id:  profile!.data.id.toString(),

                        name: "",
                            email: "",
                            password: passwordController.text,
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
            ],
          ),
        ),
      ),
      ),
    ),
    );
  }
}
