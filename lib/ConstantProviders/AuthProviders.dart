import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quickie_event/ConstantModels/LoginModel.dart';

class AuthProvider with ChangeNotifier {
  mSignUpAuth() async {
    var request = http.Request(
        'POST',
        Uri.parse(
            'http://quickeeapi.pakwexpo.com/api/register?name=test&email=test@gmail.com&password=123456'));
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  LoginModel? loginModel;
  String? loginMessage;
  mLoginAuth({
    required String email,
    required String password,
  }) async {
    String? loginMessage;
    LoginModel? loginModel;
    var request = http.Request(
        'POST',
        Uri.parse(
            'http://quickeeapi.pakwexpo.com/api/login?email=$email&password=$password'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String value = await response.stream.bytesToString();
      loginModel = loginModelFromJson(value);
      this.loginModel = loginModel;
      loginMessage = "success";
      this.loginMessage = loginMessage;
      notifyListeners();
    } else {
      print(response.reasonPhrase);
      loginMessage = "unsuccess";
      this.loginMessage = loginMessage;
      notifyListeners();
    }
  }
}
