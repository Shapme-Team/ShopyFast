import 'package:ShopyFast/getit.dart';
import 'package:ShopyFast/view/helper/screenWrapper.dart';
import 'package:ShopyFast/view/screens/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../utils/constants/size_config.dart';

class Wrapper extends StatefulWidget {
  Wrapper({Key key}) : super(key: key);
  static String routeName = "/home";
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  futureTasks() async {
    await Firebase.initializeApp();
    await getIt.allReady();
  }

  Widget buildWidget;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    initBuildWidget();
    return buildWidget;
  }

  initBuildWidget() {
    if (buildWidget == null) {
      buildWidget = FutureBuilder(
        future: futureTasks(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return ScreenWrapper();
          }
          return SplashScreen();
        },
      );
    }
  }
}
