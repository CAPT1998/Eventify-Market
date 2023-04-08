import 'package:flutter/material.dart';
import 'package:quickie_event/Constant.dart';

import 'Widgets/ChatInputField.dart';

class ChatScreenFeatures extends StatefulWidget {
  const ChatScreenFeatures({Key? key}) : super(key: key);

  @override
  State<ChatScreenFeatures> createState() => _ChatScreenFeaturesState();
}

class _ChatScreenFeaturesState extends State<ChatScreenFeatures> {
  TextEditingController message = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: app_bar(title: "Chat"),
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        title: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage("assets/img/slider1.jpg"),
          ),
          title: Text(
            "Rafa Fashion",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: Icon(
            Icons.info,
            color: appColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0XFF2473F2).withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "Message to this chat and calls are now secured & Encripted",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Color(0XFF828588)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            _RightWidget(title: "Is it available now?"),
            SizedBox(
              height: 20,
            ),
            _LeftWidget(title: "Yeah. It is available. You\ncan buy it now."),
            SizedBox(
              height: 20,
            ),
            _RightWidget(title: "Wheen will I get if I make a order.\nWill I get within the cristmas?"),
            SizedBox(
              height: 20,
            ),
            _LeftWidget(title: "Off course. You will get the\nproduct within 2 days.\nThank you! 😍❤️")
          ],
        ),
      ),
      bottomSheet: ChatInputField(message: message, press: () {}),
    );
  }
}

Widget _RightWidget({required String title}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        // width: width * 0.6,
        decoration: BoxDecoration(
          color: appColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          "$title",
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      SizedBox(
        width: 10,
      ),
      Icon(
        Icons.check_circle_outline_rounded,
        size: 20,
        color: appColor,
      ),
      SizedBox(
        width: 10,
      ),
    ],
  );
}

Widget _LeftWidget({required String title}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      SizedBox(
        width: 10,
      ),
      CircleAvatar(
        backgroundImage: AssetImage("assets/img/slider1.jpg"),
      ),
      SizedBox(
        width: 10,
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        // width: width * 0.6,
        decoration: BoxDecoration(
          color: Color(0XFFB8BCBF),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          "$title",
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    ],
  );
}
