import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:quickie_event/Constant.dart';
import 'package:quickie_event/ConstantModels/LoginModel.dart';
import 'package:quickie_event/Quicke_Features/Screen_Features/BottomNavigationFeatures/BottomNavigationFeatures.dart';
import 'package:quickie_event/helper/storage_helper.dart';

import '../ConstantModels/ProfileModel.dart';

class AuthProvider with ChangeNotifier {
  String? registerMessage;
  Map userData = {};
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


   updateprofile({
    required String id,
    required String name,
    required String email,
    required String password,
  }) async {    LoginModel? loginModel;


        String token = "PivvPlsQWxPl1bB5KrbKNBuraJit0PrUZekQUgtLyTRuyBq921atFtoR1HuA"; // Assuming the token is stored in `apiToken` property of `LoginModel`
var requestBody = {};

  if (name.isNotEmpty) {
    requestBody["name"] = name;
  }
  if (email.isNotEmpty) {
    requestBody["email"] = email;
  }
  if (password.isNotEmpty) {
    requestBody["password"] = password;
  }
   var response = await http.post(
      Uri.parse('http://quickeeapi.pakwexpo.com/api/users/$id'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    body: requestBody,

    );
    print(response.body);

      final jsonData = json.decode(response.body);
            final Map<String, dynamic> data = json.decode(response.body);

     if (response.statusCode == 200) {
      
loginModel = loginModelFromJson(json.encode(data));
      this.loginModel = loginModel;
      Storage.saveUser(loginModel);
      Storage.saveJWT(loginModel.data.apiToken);
      loginMessage = "success";
      this.loginMessage = loginMessage;
      print("updated");
      notifyListeners();
    } else {
      print(response.reasonPhrase);
      loginMessage = "unsuccess";
      this.loginMessage = loginMessage;
      notifyListeners();
    }
  }

  LoginModel? loginModel;
  bool? isLoggedIn=false;
  setIsFirstRun(bool value){
    isLoggedIn=value;
    notifyListeners();
  }

  String? loginMessage;
  mLoginAuth({
    required String email,
    required String password,
  }) async {
    String? loginMessage;
    LoginModel? loginModel;
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://quickeeapi.pakwexpo.com/api/login'));
    request.fields.addAll({'email': '$email', 'password': '$password'});
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String value = await response.stream.bytesToString();
      print(value);
      loginModel = loginModelFromJson(value);
      this.loginModel = loginModel;
      Storage.saveUser(loginModel);
      Storage.saveJWT(loginModel.data.apiToken);
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
  /*      ProfileModel? profileModel;

   Future<void> fetchProfile() async {
        ProfileModel? profileModel;

    try {
          String id = loginModel!.data.id.toString();

    final response = await http.get(Uri.parse('http://quickeeapi.pakwexpo.com/api/users/$id'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

         profileModel = ProfileModel.fromJson(jsonData);

this.profileModel = profileModel;        
        Storage.saveUser(loginModel!);

        notifyListeners();
        print("profile data fetched");
      } else {
        throw Exception('Failed to fetch profile data');
      }
    } catch (error) {
      throw Exception('An error occurred while fetching profile data: $error');
    }
  }
  */

  bool isUserCreated = false;
  String userLoginMessage = "";
  Future<UserCredential?> signInWithGoogle() async {
    // Trigger the authentication flow
    bool isUserCreated = false;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      print(userCredential.user!.email);
      // isUserLoggedIn = true;

      isUserCreated = true;
      this.isUserCreated = isUserCreated;
      userData = {
        "UID": userCredential.user!.uid.toString(),
        "username": userCredential.user!.displayName.toString(),
        "email": userCredential.user!.email.toString(),
        "phoneNumber": userCredential.user!.phoneNumber.toString(),
        "picture": userCredential.user!.photoURL.toString()
      };
      userLoginMessage = "Welcome.!";
      notifyListeners();
      return userCredential;
      // Once signed in, return the UserCredential
      // return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        userLoginMessage = "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        userLoginMessage = "The account already exists for that email.";
      } else if (e.code == 'account-exists-with-different-credential') {
        print('The account already exists for that email.');
        userLoginMessage =
            "The account already exists with different credential.";
      }
      isUserCreated = false;
      notifyListeners();
      return null;
    } catch (e) {
      isUserCreated = false;
      this.isUserCreated = isUserCreated;
      userLoginMessage = "Something went wrong";
      notifyListeners();
      print(e);
      return null;
    }
  }

  facebookLogin(context) async {
    try {
      final result = await FacebookAuth.i.login(
        permissions: [
          'public_profile',
          'email',
          'pages_show_list',
          'pages_messaging',
          'pages_manage_metadata'
        ],
      );
      if (result.status == LoginStatus.success) {
        final userData = await FacebookAuth.i.getUserData();
        print(userData);
        print("================>New Login");

        // "UID": userData["id"],
        // "username": userData["name"],
        // "email": userData["email"],
        // "balance": 0,
        // "JoinDate": user.metadata.creationTime,

        print("${result.message}");
      }
      print("================>${result.message}");
    } catch (error) {
      print("===========>$error");
      SuccessFlushbar(context, "Login", "$error");
    }
  }
  // Future<UserCredential?> signInWithFacebook() async {
  //   bool isUserCreated = false;
  //   try {
  //     final LoginResult loginResult = await FacebookAuth.instance.login();
  //     OAuthCredential facebookAuthCredential;

  //     facebookAuthCredential =
  //         FacebookAuthProvider.credential(loginResult.accessToken!.token);
  //     // print("11");
  //     UserCredential userCredential = await FirebaseAuth.instance
  //         .signInWithCredential(facebookAuthCredential);
  //     // print("111");
  //     print(userCredential.user!.uid);
  //     // isUserLoggedIn = true;
  //     isUserCreated = true;
  //     this.isUserCreated = isUserCreated;
  //     userLoginMessage = "Welcome.!";
  //     notifyListeners();
  //     return userCredential;
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       print('The password provided is too weak.');
  //       userLoginMessage = "The password provided is too weak.";
  //     } else if (e.code == 'email-already-in-use') {
  //       print('The account already exists for that email.');
  //       userLoginMessage = "The account already exists for that email.";
  //     } else if (e.code == 'account-exists-with-different-credential') {
  //       print('The account already exists for that email.');
  //       userLoginMessage =
  //           "The account already exists with different credential.";
  //     }
  //     isUserCreated = false;
  //     notifyListeners();
  //     return null;
  //   } catch (e) {
  //     isUserCreated = false;
  //     this.isUserCreated = isUserCreated;
  //     userLoginMessage = "Something went wrong";
  //     notifyListeners();
  //     print(e);
  //     return null;
  //   }
  // }
}
