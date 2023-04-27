import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:quickie_event/ConstantModels/LoginModel.dart';
import 'package:quickie_event/Quicke_Features/Screen_Features/BottomNavigationFeatures/BottomNavigationFeatures.dart';

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
      print("$isUserCreated");
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

    // Future<UserCredential?> signInWithFacebook() async {
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
  //     userLoginMessage = "Welcome.!";
  //     notifyListeners();
  //     return userCredential;
  //     // } on FirebaseAuthException catch (e){
  //     //   print("1111");
  //     // }

  //   } on FirebaseAuthException catch (e) {
  //     // print("1111");
  //     // print(e);
  //     // print(e.message);
  //     // print(e.email);
  //     // print(e.code);

  //     if (e.code == 'weak-password') {
  //       print('The password provided is too weak.');
  //       userLoginMessage = "The password provided is too weak.";
  //     } else if (e.code == 'email-already-in-use') {
  //       print('The account already exists for that email.');
  //       userLoginMessage = "The account already exists for that email.";
  //     }
  //     else if (e.code == 'account-exists-with-different-credential') {
  //       print('The account already exists for that email.');
  //       userLoginMessage =
  //           "The account already exists with different credential.";
  //     }
  //     isUserCreated = false;
  //     notifyListeners();
  //     return null;
  //   } catch (e) {
  //     isUserCreated = false;
  //     userLoginMessage = "Something went wrong";
  //     notifyListeners();
  //     print(e);
  //     return null;
  //   }
  // }
}
