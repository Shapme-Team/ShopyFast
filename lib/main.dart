import 'package:ShopyFast/getit.dart';

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
