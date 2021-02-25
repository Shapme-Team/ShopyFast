import 'package:ShopyFast/domain/provider/authprovider.dart';
import 'package:ShopyFast/view/screens/Auth/authScreen.dart';
import 'package:ShopyFast/view/screens/bottomNavScreens/profile/components/editProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/provider/authprovider.dart';
import 'components/profileHome.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = "/profile";

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, value, _) {
      var authState = value.getAuthState;
      return authState == AuthStatusValue.PROFILE_AUTH
          ? ProfileHome()
          : AuthScreen();
    });
  }
}
