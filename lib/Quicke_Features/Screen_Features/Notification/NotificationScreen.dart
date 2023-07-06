import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickie_event/Constant.dart';
import 'package:quickie_event/Quicke_Features/providers/Notificationprovider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    final notificationState = Provider.of<NotificationProvider>(context);

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
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Clear Notifications',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 16.0),
                            Text(
                                'Are you sure you want to clear all notifications?'),
                            SizedBox(height: 16.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(
                                        context); // Close the bottom sheet
                                  },
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Provider.of<NotificationProvider>(context,
                                            listen: false)
                                        .clearNotifications();
                                    Navigator.pop(
                                        context); // Close the bottom sheet
                                  },
                                  child: Text(
                                    'Clear',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
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
              for (final notification in notificationState.notifications)
                _notifications(
                  notification.image,
                  notification.title,
                  notification.subtitle,
                  notification.trailing,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _notifications(
  IconData image,
  String title,
  String subtitle,
  Gradient trailing,
) {
  return Consumer<NotificationProvider>(
    builder: (context, state, _) => Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: trailing,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Icon(
              image,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 10,
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
    ),
  );
}
