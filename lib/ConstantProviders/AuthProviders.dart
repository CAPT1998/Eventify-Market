import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

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
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ConstantModels/ProfileModel.dart';
import '../Quicke_Events/Widgets/api_url.dart';

class AuthProvider with ChangeNotifier {
  String? profile;
  List<LoginModel> loginModel = [];
  AuthProvider() {
    _loadLoginModel();
  }

  Future<void> loadLoginModel() async {
    await _loadLoginModel();
  }

  _loadLoginModel() async {
    print("login model loaded");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String loginModelJson = prefs.getString('login_model') ?? '[]';
    List<dynamic> loginModelList = json.decode(loginModelJson);
    loginModel =
        loginModelList.map((json) => LoginModel.fromJson(json)).toList();
    notifyListeners();
  }

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

  Future<void> profileUpdate(context, userId, token) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    print(userId);
    try {
      if (pickedImage != null) {
        final request = http.MultipartRequest(
            'POST', Uri.parse('${AppUrl.baseUrl}/users/$userId/update-avatar'));
        request.headers.addAll({'Authorization': "Bearer $token"});

        request.files
            .add(await http.MultipartFile.fromPath('avatar', pickedImage.path));

        var response = await request.send();
        var responseBody = await response.stream.bytesToString();
        final Map<String, dynamic> data = json.decode(responseBody);
        print("Data $data");
        print("Profile : ${responseBody}");
        if (response.statusCode == 200) {
          // loginModel = loginModelFromJson(responseBody);
          registerMessage = "success";
          this.registerMessage = registerMessage;
          //  this.loginModel = loginModel;
          print("Profile $profile");
          SuccessFlushbar(context, "Profile Update", data["message"]);
          notifyListeners();
        } else {
          // ErrorFlushbar(context, "Profile Update", data["message"]);
          notifyListeners();
        }
      } else {
        // Send an image from the asset folder instead
        final request = http.MultipartRequest(
            'POST', Uri.parse('${AppUrl.baseUrl}/users/$userId/update-avatar'));
        request.headers.addAll({'Authorization': "Bearer $token"});

        // Assuming you have an image named 'default_profile_pic.png' in the assets folder
        ByteData imageData = await rootBundle.load('assets/img/2.png');
        List<int> bytes = imageData.buffer.asUint8List();
        var multipartFile = http.MultipartFile.fromBytes('profile_pic', bytes,
            filename: '2.png');

        request.files.add(multipartFile);

        var response = await request.send();
        var responseBody = await response.stream.bytesToString();
        final Map<String, dynamic> data = json.decode(responseBody);
        print("Data $data");
        print("Profile : ${response.statusCode}");
        if (response.statusCode == 200) {
          loginModel = loginModelFromJson(responseBody);
          registerMessage = "success";
          this.registerMessage = registerMessage;
          this.loginModel = loginModel;
          print("Profile $profile");
          SuccessFlushbar(context, "Profile Update", data["message"]);

          notifyListeners();
        }
      }
    } catch (e) {
      print(e);
    }
  }

  updateprofile({
    required String id,
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    List<LoginModel> loginModel = [];

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
    if (phone.isNotEmpty) {
      requestBody["phone"] = phone;
    }
    var response = await http.post(
      Uri.parse('http://quickeeapi.pakwexpo.com/api/users/$id'),
      headers: {
        'Authorization':
            'Bearer ' + (Storage.getJWT().isEmpty ? "" : Storage.getJWT()),
      },
      body: requestBody,
    );
    print(response.body);

    final jsonData = json.decode(response.body);
    final Map<String, dynamic> data = json.decode(response.body);

    if (response.statusCode == 200) {
      List<LoginModel> loginModel = loginModelFromJsonupdateprofile(jsonData);
      this.loginModel = loginModel;
      Storage.saveUser2(loginModel);
      Storage.saveJWT(loginModel[0].data!.apiToken!);
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

  bool? isLoggedIn = false;
  setIsFirstRun(bool value) {
    isLoggedIn = value;
    notifyListeners();
  }

  String? loginMessage;
  mLoginAuth({
    required String email,
    required String password,
  }) async {
    String? loginMessage;
    List<LoginModel> loginModel = [];
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://quickeeapi.pakwexpo.com/api/login'));
    request.fields.addAll({'email': '$email', 'password': '$password'});
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String value = await response.stream.bytesToString();
      print(value);
      Map<String, dynamic> jsonMap = json.decode(value);

      // Use the LoginModel.fromJson constructor directly
      loginModel = loginModelFromJsonlogin((jsonMap));

      // Add the single model to the loginModel list

      this.loginModel = loginModel;
      Storage.saveUser2(loginModel);
      Storage.saveJWT(loginModel[0].data!.apiToken!);
      loginMessage = "success";
      print("token is " + loginModel[0].data!.apiToken!);
      this.loginMessage = loginMessage;
      //profile = loginModel.data!.media![0].url;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String loginModelJson = json.encode(loginModel);
      prefs.setString('login_model', loginModelJson);

      notifyListeners();
    } else {
      print(response.reasonPhrase);
      loginMessage = "unsuccess";
      this.loginMessage = loginMessage;
      notifyListeners();
    }
  }

  profilepictureupdate({
    required String email,
    required String password,
  }) async {
    String? loginMessage;
    List<LoginModel> loginModel = [];
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://quickeeapi.pakwexpo.com/api/login'));
    request.fields.addAll({'email': '$email', 'password': '$password'});
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String value = await response.stream.bytesToString();
      final jsonData = json.decode(value);
      loginModel = loginModelFromJsonupdateprofile(jsonData);
      this.loginModel = loginModel;
      Storage.saveUser2(loginModel);
      Storage.saveJWT(loginModel[0].data!.apiToken!);
      loginMessage = "success";
      this.loginMessage = loginMessage;
      profile = loginModel[0].data!.media![0].url;

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
