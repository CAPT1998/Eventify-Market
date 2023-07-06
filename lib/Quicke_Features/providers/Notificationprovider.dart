import 'package:flutter/material.dart';

class NotificationProvider extends ChangeNotifier {
  List<NotificationModel> notifications = []; // List of notifications

  void addNotification(NotificationModel notification) {
    notifications.add(notification);
    notifyListeners(); // Notify listeners of state change
  }

  void clearNotifications() {
    notifications.clear();
    notifyListeners();
  }
}

class NotificationModel {
  final IconData image;
  final String title;
  final String subtitle;
  final Gradient trailing;

  NotificationModel({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.trailing,
  });
}
