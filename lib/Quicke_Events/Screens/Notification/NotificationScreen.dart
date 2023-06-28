import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:quickie_event/Constant.dart';
import 'package:quickie_event/Quicke_Events/Widgets/TextWidget.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  TabController? _tabController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[50],
          title: TextWidget(title: "Notification", size: 16),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: greyColor,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                leading: Icon(Icons.notifications),
                                title: Text('Clear all'),
                                onTap: () {
                                  // Perform action for option 1
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.cancel),
                                title: Text('Cancel'),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      });
                },
                icon: Icon(
                  Icons.settings,
                  color: greyColor,
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Divider(
                  color: greyColor,
                ),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage("assets/img/f1.png"),
                  ),
                  title: TextWidget(
                      title:
                          "Jazz Club NY just added Fine & Mellow: Ekep Nkwelle Quartet event in New York.",
                      size: 12,
                      fontWeight: FontWeight.w500,
                      maxline: 2),
                  subtitle: TextWidget(
                      title: "1h ago",
                      size: 12,
                      fontWeight: FontWeight.w500,
                      color: greyColor.withOpacity(0.5)),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: greyColor,
                ),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage("assets/img/f1.png"),
                  ),
                  title: TextWidget(
                      title:
                          "Jazz Club NY just added Fine & Mellow: Ekep Nkwelle Quartet event in New York.",
                      size: 12,
                      fontWeight: FontWeight.w500,
                      maxline: 2),
                  subtitle: TextWidget(
                      title: "1h ago",
                      size: 12,
                      fontWeight: FontWeight.w500,
                      color: greyColor.withOpacity(0.5)),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: greyColor,
                ),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage("assets/img/f1.png"),
                  ),
                  title: TextWidget(
                      title:
                          "Jazz Club NY just added Fine & Mellow: Ekep Nkwelle Quartet event in New York.",
                      size: 12,
                      fontWeight: FontWeight.w500,
                      maxline: 2),
                  subtitle: TextWidget(
                      title: "1h ago",
                      size: 12,
                      fontWeight: FontWeight.w500,
                      color: greyColor.withOpacity(0.5)),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: greyColor,
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
