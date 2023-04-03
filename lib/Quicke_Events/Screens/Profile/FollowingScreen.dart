import 'package:flutter/material.dart';
import 'package:quickie_event/Constant.dart';

import '../../Widgets/SizedBoxWidget.dart';
import '../../Widgets/TextFormWidget.dart';
import '../../Widgets/TextWidget.dart';

class FollowingScreen extends StatefulWidget {
  const FollowingScreen({super.key});

  @override
  State<FollowingScreen> createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
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
        title: TextWidget(title: "Following", size: 16),
        backgroundColor: Colors.grey[50],
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizeWidget(height: 30),
              textfieldProduct(
                context: context,
                name: "Search",
                prefixIcon: Icon(Icons.search),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  TextWidget(title: "Sort by Default", size: 16),
                  Spacer(),
                  Icon(
                    Icons.compare_arrows_sharp,
                    color: greyColor.withOpacity(0.5),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              _OrganizerWidget(),
              _OrganizerWidget(),
              _OrganizerWidget(),
              _OrganizerWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _OrganizerWidget() {
  return Container(
    margin: EdgeInsets.only(bottom: 10),
    width: width,
    padding: EdgeInsets.all(5),
    decoration: BoxDecoration(
      border: Border.all(color: lightGreyColor),
      borderRadius: BorderRadius.circular(10),
    ),
    child: ListTile(
      title: TextWidget(
        title: "Living Gallery",
        size: 14,
        fontWeight: FontWeight.w500,
      ),
      subtitle: TextWidget(
        title: "10.5K Followers",
        size: 12,
        color: greyColor.withOpacity(0.5),
        fontWeight: FontWeight.w500,
      ),
      leading: Image.asset(
        "assets/img/f1.png",
      ),
      trailing: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: lightGreyColor,
        onPressed: () {},
        child: TextWidget(
          title: "Following",
          size: 12,
          fontWeight: FontWeight.w700,
          color: appColor,
        ),
      ),
    ),
  );
}
