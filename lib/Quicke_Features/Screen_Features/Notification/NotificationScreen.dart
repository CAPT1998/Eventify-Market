import 'package:flutter/material.dart';
import 'package:quickie_event/Constant.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[50],
          elevation: 0,
          title: Text(
            "Notification",
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.w700, color: Colors.black),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.more_horiz,
                  color: Colors.black,
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Text(
                "Today",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  // color: Color(0XFF00ADF4),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              _notifications(
                Icons.wallet,
                "Payment Successful!",
                "You have made a shipping payment",
                LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0XFF22BB9C),
                    Color(0XFF35DEBC),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Text(
                "Yesterday",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  // color: Color(0XFF00ADF4),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              _notifications(
                Icons.airplane_ticket,
                "Today’s Special Offers",
                "You have made a shipping payment",
                LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0XFFFACC15),
                    Color(0XFFFFE580),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              _notifications(
                Icons.add_box_rounded,
                "New Services Available!",
                "Now you can search the nearby drop",
                LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0XFFFF4D67),
                    Color(0XFFFF8A9B),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Text(
                "December 20, 2024",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  // color: Color(0XFF00ADF4),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              _notifications(
                Icons.wallet,
                "Credit Card Connected!",
                "Credit Card has been linked!",
                LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0XFF246BFD),
                    Color(0XFF6F9EFF),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              _notifications(
                Icons.person,
                "Account Setup Successful!",
                "Your account has been created!",
                LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0XFF4ADE80),
                    Color(0XFF4ADE80),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _notifications(
    IconData image, String title, String subtitle, Gradient trailing) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(10)),
    child: Row(
      children: [
        Container(
          // radius: 100,
          padding: EdgeInsets.all(25),
          decoration: BoxDecoration(
              gradient: trailing, borderRadius: BorderRadius.circular(50)),
          child: Icon(
            image,
            color: Colors.white,
          ),
        ),
        SizedBox(
          width: width * 0.03,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$title",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  // color: Color(0XFF00ADF4),
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Text(
                "$subtitle",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0XFF616161),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
