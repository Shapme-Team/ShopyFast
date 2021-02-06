import 'constants/routes.dart';
import 'package:flutter/material.dart';
import 'utils/wrapper.dart';
import 'constants/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ShopyFast',
      theme: theme(),
      home: Wrapper(),
      //initialRoute: Wrapper.routeName,
      routes: routes,
    );
  }
}
