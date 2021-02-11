import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../utils/constants/size_config.dart';
import '../view/screens/home/home.dart';

class Wrapper extends StatefulWidget {
  Wrapper({Key key}) : super(key: key);
  static String routeName = "/home";
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error');
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return HomeScreen();
        }
        return CircularProgressIndicator();
      },
    );
  }
}
