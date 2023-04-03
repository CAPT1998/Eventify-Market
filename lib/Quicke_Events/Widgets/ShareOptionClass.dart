import 'dart:io';
import 'package:flutter/services.dart';

class ShareSocialClass {
  static const MethodChannel _channel = const MethodChannel('social_share');
  static Future<bool?> shareOptions(String contentText) async {
    Map<String, dynamic> args;
    if (Platform.isIOS) {
      args = <String, dynamic>{ "content": contentText};
    } else {
      args = <String, dynamic>{ "content": contentText};
    }
    final bool? version = await _channel.invokeMethod('shareOptions', args);
    return version;
  }
}
