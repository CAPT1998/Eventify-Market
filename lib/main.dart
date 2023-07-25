import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickie_event/ConstantProviders/AuthProviders.dart';
import 'package:quickie_event/Quicke_Events/Providers/CategoryProvider.dart';
import 'package:quickie_event/Quicke_Events/Providers/EventsProvider.dart';
import 'package:quickie_event/SplashScreen/SplashScreen.dart';

import 'ConstantModels/pushnotifications.dart';
import 'ConstantProviders/ChatProvider.dart';
import 'ConstantProviders/cartitemsprovider.dart';
import 'Quicke_Features/providers/HomeProviders.dart';
import 'Quicke_Features/providers/Notificationprovider.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  // Shared.pref = await SharedPreferences.getInstance();
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp();
  await FCM().configureFCM();

  runApp(EasyLocalization(
      child: MyApp(),
      supportedLocales: [Locale('en', 'US'), Locale('es', 'ES')],
      path: 'assets/resources/langs/langs.csv',
      fallbackLocale: Locale('en', 'US'),
      assetLoader: CsvAssetLoader()));
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ChatProvider>(
            create: (context) => ChatProvider()),
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
        ChangeNotifierProvider<NotificationProvider>(
            create: (context) => NotificationProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        navigatorKey: navigatorKey,
        home: SplashScreen(),
      ),
    );
  }
}
