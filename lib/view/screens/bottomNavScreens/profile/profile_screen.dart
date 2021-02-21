import 'package:ShopyFast/domain/provider/google_signin.dart';
import 'package:ShopyFast/view/screens/Auth/phoneAuth.dart';

import 'package:ShopyFast/view/screens/cart/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'components/LoggedInProfile.dart';
import 'components/body.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = "/profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          'Profile',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 23,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Icon(
            Icons.search,
            color: Colors.grey,
          ),
          IconButton(
            color: Colors.grey,
            icon: Icon(Icons.shopping_cart_outlined),
            onPressed: () => Navigator.pushNamed(context, CartScreen.routeName),
          ),
        ],
      ),
      body: AuthScreen(),
      // ChangeNotifierProvider(
      //   create: (context) => GoogleSignInProvider(),
      //   child: StreamBuilder<Object>(
      //       stream: FirebaseAuth.instance.authStateChanges(),
      //       builder: (context, snapshot) {
      //         final provider = Provider.of<GoogleSignInProvider>(context);
      //         if (provider.isSigningIn) {
      //           return buildLoading();
      //         } else if (snapshot.hasData) {
      //           return AuthScreen();
      //         } else {
      //           return Body();
      //         }
      //       }),
      // ),
    );
  }

  Widget buildLoading() => Stack(
        fit: StackFit.expand,
        children: [
          Center(child: CircularProgressIndicator()),
        ],
      );
}
