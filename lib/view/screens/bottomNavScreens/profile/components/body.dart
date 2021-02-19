import 'package:ShopyFast/domain/provider/google_signin.dart';
import 'package:ShopyFast/view/components/socal_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'profile_menu.dart';

import 'profile_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfileMenu(
            text: "Sign Up With Google",
            icon: "assets/icons/google-icon.svg",
            press: () {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.login();
            },
          ),
        ],
      ),
    );
  }
}
