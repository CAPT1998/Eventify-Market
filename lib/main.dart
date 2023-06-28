import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickie_event/ConstantProviders/AuthProviders.dart';
import 'package:quickie_event/Quicke_Events/Providers/CategoryProvider.dart';
import 'package:quickie_event/Quicke_Events/Providers/EventsProvider.dart';
import 'package:quickie_event/SplashScreen/SplashScreen.dart';

import 'ConstantProviders/cartitemsprovider.dart';
import 'Quicke_Features/providers/HomeProviders.dart';

void main(List<String> args) async {

  WidgetsFlutterBinding.ensureInitialized();
  // Shared.pref = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

    MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
            create: (context) => AuthProvider()),
        ChangeNotifierProvider<EventProvider>(
            create: (context) => EventProvider()),
        ChangeNotifierProvider<CategoryPRovider>(
            create: (context) => CategoryPRovider()),
        ChangeNotifierProvider<HomeProvider>(
            create: (context) => HomeProvider()),
             ChangeNotifierProvider<CartProvider>(
            create: (context) => CartProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,

        home: SplashScreen(),
      ),
    );
  }
}
