import 'package:flutter/material.dart';
import 'package:quickie_event/Constant.dart';

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
      body: SingleChildScrollView(
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
                    title: "Full Name",
                    fontWeight: FontWeight.w600,
                  ),
                  Spacer(),
                  TextWidget(
                    title: "Change",
                    fontWeight: FontWeight.w600,
                    color: appColor,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              textfieldProduct(context: context, name: "Name"),
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
                  TextWidget(
                    title: "Change",
                    fontWeight: FontWeight.w600,
                    color: appColor,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              textfieldProduct(context: context, name: "Email"),
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
                  TextWidget(
                    title: "Update",
                    fontWeight: FontWeight.w600,
                    color: appColor,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              textfieldProduct(
                  context: context,
                  name: "Password",
                  obscureText: passwordVisible,
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                      icon: Icon(passwordVisible
                          ? Icons.visibility_off
                          : Icons.visibility))),
            ],
          ),
        ),
      ),
    );
  }
}
