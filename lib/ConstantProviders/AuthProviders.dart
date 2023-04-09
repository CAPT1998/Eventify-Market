import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quickie_event/ConstantModels/LoginModel.dart';

class AuthProvider with ChangeNotifier {
  String? registerMessage;
  mSignUpAuth({
    required String name,
    required String email,
    required String password,
  }) async {
    String? registerMessage;
    var request = http.Request(
        'POST',
        Uri.parse(
            'http://quickeeapi.pakwexpo.com/api/register?name=$name&email=$email&password=$password'));
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      registerMessage = "success";
      this.registerMessage = registerMessage;
      notifyListeners();
    } else {
      print(response.reasonPhrase);
      registerMessage = "unsuccess";
      this.registerMessage = registerMessage;
      notifyListeners();
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
      print(value);
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
