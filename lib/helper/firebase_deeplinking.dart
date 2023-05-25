import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quickie_event/ConstantIntroduction/IntroductionScreen1.dart';
import 'package:quickie_event/main.dart';

import 'package:uni_links/uni_links.dart';

import '../Quicke_Events/Screens/Profile/EventRequestScreen.dart';
import '../Quicke_Features/Screen_Features/BottomNavigationFeatures/BottomNavigationFeatures.dart';


class FirebaseDeepLink {
  String? _linkMessage;
  bool _isCreatingLink = false;

  Uri? _initialUri;
  Uri? _latestUri;
  Object? _err;
  bool _initialUriIsHandled = false;

   StreamSubscription? _sub;
  final storage = GetStorage();


  //handle from background to foreground => background=true.
  void handleIncomingLinks(BuildContext context) {
    print("handleincominglinks called");

    if (!kIsWeb) {
      // It will handle app links while the app is already started - be it in
      // the foreground or in the background.
      _sub = uriLinkStream.listen((Uri? deepLink)   async {
        print('got uri: $deepLink');
        if (deepLink != null) {
          if (deepLink != null) {
            print('deep link is found at location '+ deepLink.toString());

            final queryParams = deepLink.queryParameters;
            List<String> pathSegments = deepLink.pathSegments;
            if (pathSegments.isNotEmpty) {
              // String idProfile = queryParams["profileId"];
              // String profilePostId = queryParams["profilePostId"];

              String postID = pathSegments[pathSegments.length-1];
              String page = pathSegments[pathSegments.length-2];
              print('PostId${postID}');
              print('PostId${page}');

              print('PostId${postID}');
              print('if deep link id part init');
              // print('profile id:${idProfile}');

              if (page == "Events") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EventRequestScreen(eventId: postID)));

                // Get.to(Session(
                //   postId: null,
                //   profileId:idProfile,
                // ));
              }
              // Navigator.pushNamed(context,
              //     dynamicLinkData.link.path,
              //     arguments: {"productId": });
            } else {
              print('else part');
              // Navigator.pushNamed(
              //   context,
              //   dynamicLinkData.link.path,
              // );
            }
            //   }
          }

          //   }
        }
      }, onError: (Object err) {  } );
    }
  }
  /// Handle the initial Uri - the one the app was started with
  ///
  /// **ATTENTION**: `getInitialLink`/`getInitialUri` should be handled
  /// ONLY ONCE in your app's lifetime, since it is not meant to change
  /// throughout your app's life.
  ///
  ///

  /// We handle all exceptions, since it is called from initState.
  Future<void> handleInitialUri(BuildContext context) async {
    print("handleincominglinks called");
    // call();

    // In this example app this is an almost useless guard, but it is here to
    // show we are not going to call getInitialUri multiple times, even if this
    // was a weidget that will be disposed of (ex. a navigation route change).
    if (!_initialUriIsHandled) {
      _initialUriIsHandled = true;
      print("_handleInitialUri called");
      try {
        final deepLink = await getInitialUri();
        if (deepLink == null) {
          print('no initial uri');
        } else {
          print('got initial uri: $deepLink');
          if (deepLink != null) {
            print('deep link is found at location '+ deepLink.toString());

            final queryParams = deepLink.queryParameters;
            List<String> pathSegments = deepLink.pathSegments;
            if (pathSegments.isNotEmpty) {
              // String idProfile = queryParams["profileId"];
              // String profilePostId = queryParams["profilePostId"];

              String postID = pathSegments[pathSegments.length-1];
              String page = pathSegments[pathSegments.length-2];
              print('PostId${postID}');
              print('PostId${page}');

              print('PostId${postID}');
              print('if deep link id part init');
              // print('profile id:${idProfile}');

              if (page == "Events") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EventRequestScreen(eventId: postID)));

                // Get.to(Session(
                //   postId: null,
                //   profileId:idProfile,
                // ));
              }
              // Navigator.pushNamed(context,
              //     dynamicLinkData.link.path,
              //     arguments: {"productId": });
            } else {
              print('else part');
              // Navigator.pushNamed(
              //   context,
              //   dynamicLinkData.link.path,
              // );
            }
            //   }
          }
        }

      } on PlatformException {
        // Platform messages may fail but we ignore the exception
        print('falied to get initial uri');
      }
    }
  }





}
