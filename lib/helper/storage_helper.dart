import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';

import '../ConstantModels/LoginModel.dart';
import '../ConstantModels/ProfileModel.dart';
import 'logging_utils.dart';

class Storage {
  static GetStorage box = GetStorage();
  static String userKey = "userKey";
  static String jwt = "jwt";
  static String firebase_token = "firebase_token";
  static String is_first_run = "is_first_run";
  static String mentorship_requests = "mentorship_requests";

  static LoginModel getUser() {
    var data = box.read(userKey);
    Map<String, dynamic> json = jsonDecode(data) as Map<String, dynamic>;

    if (kDebugMode) {
      print(json.runtimeType);
    }
    return LoginModel.fromJson(json);
  }

  static String getJWT() {
    return box.read(jwt) ?? "";
  }

  static String getFirebaseToken() {
    return box.read(firebase_token) ?? "";
  }

  static String getMentorshipRequests() {
    return box.read(mentorship_requests) ?? "";
  }

  static bool getIsMentorTutorialComplete() {
    return box.read(is_first_run) ?? true;
  }

  // static saveUser(LoginModel data) {
  //   if (kDebugMode) {
  //     print("** SAVE USER DATA");
  //   }
  //  String user = jsonEncode(data);
  //   box.write(userKey, user);
  // }

  static saveUser2(List<LoginModel> data) {
    if (kDebugMode) {
      print("** SAVE USER DATA");
    }
    String user = jsonEncode(data);
    box.write(userKey, user);
  }

  static profileinfo(ProfileModel data) {
    String userdata = jsonEncode(data);
    box.write(userKey, userdata);
  }

  static isFirstRun(bool isFirstRun) {
    if (kDebugMode) {
      print("** SAVE ISFIRSTRUN");
    }

    box.write(is_first_run, isFirstRun);
    if (kDebugMode) {
      print("** SAVED ISFIRSTRUN");
    }
  }

  static saveJWT(String? data) {
    box.write(jwt, data);
    LoggingUtils.printValue("jwt saved", data);
  }

  static saveFirebaseToken(String? data) {
    box.write(firebase_token, data);
    LoggingUtils.printValue("jwt Firebase Token in storage", data);
  }
}
