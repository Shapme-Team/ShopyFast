import 'package:ShopyFast/getit.dart';
import 'package:ShopyFast/view/helper/screenWrapper.dart';
import 'package:ShopyFast/view/screens/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

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
    print('------------------------------------- ***');
    print('everything is ok !!');
    print('------------------------------------- ***');
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
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          } else
            return ScreenWrapper();
        },
      );
    }
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
