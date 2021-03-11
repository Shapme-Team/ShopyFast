import 'package:ShopyFast/getit.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

import 'utils/constants/routes.dart';
import 'package:flutter/material.dart';
import 'view/helper/wrapper.dart';
import 'utils/theme.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ShopyFast',

      theme: theme(),
      home: Wrapper(),

      navigatorObservers: [observer],
      //initialRoute: Wrapper.routeName,
      routes: routes,
    );
  }
}
