import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:quickie_event/Constant.dart';

import '../../Widgets/SizedBoxWidget.dart';
import '../../Widgets/TextFormWidget.dart';
import '../../Widgets/TextWidget.dart';

class NotificationCenterScreen extends StatefulWidget {
  const NotificationCenterScreen({super.key});

  @override
  State<NotificationCenterScreen> createState() =>
      _NotificationCenterScreenState();
}

class _NotificationCenterScreenState extends State<NotificationCenterScreen> {
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
        title: TextWidget(title: "Notification Centre", size: 16),
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
              SizedBox(
                height: 20,
              ),
              _OrganizerWidget(
                  title: "Get alert in your phone",
                  icon: Icons.notifications_active_outlined),
                  
              _OrganizerWidget(
                  title: "Get alert in your email",
                  icon: Icons.email_outlined),
                  
              _OrganizerWidget(
                  title: "Newsletters",
                  icon: Icons.newspaper_outlined),
                  
              _OrganizerWidget(
                  title: "Followed organized email",
                  icon: Icons.person_outline_outlined),
                  
              _OrganizerWidget(
                  title: "Reminders email",
                  icon: Icons.info_outline),
                  
              _OrganizerWidget(
                  title: "Liked event email",
                  icon: Icons.favorite_border),
                  
              _OrganizerWidget(
                  title: "Followed collection email",
                  icon: Icons.dashboard_outlined),
            ],
          ),
        ),
      ),
    );
  }
}

bool valueCheckBox = false;
class _OrganizerWidget extends StatefulWidget {
  final dynamic icon;
  final String? title;

  const _OrganizerWidget({Key? key, this.icon, this.title}) : super(key: key);

  @override
  _OrganizerWidgetState createState() => _OrganizerWidgetState();
}

class _OrganizerWidgetState extends State<_OrganizerWidget> {
  bool valueCheckBox = false;

  @override
  Widget build(BuildContext context) {
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
          title: "${widget.title}",
          size: 14,
          fontWeight: FontWeight.w500,
        ),
        leading: Icon(widget.icon),
        trailing: SizedBox(
          width: width * 0.15,
          child: FlutterSwitch(
            showOnOff: true,
            activeTextColor: Colors.black,
            activeColor: appColor,
            toggleSize: 15,
            height: 25,
            width: 55,
            value: valueCheckBox,
            onToggle: (value) {
              setState(() {
                valueCheckBox = value;
              });
            },
          ),
        ),
      ),
    );
  }
}
